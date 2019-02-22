#!/bin/bash
if [ -z $1 ];then
 echo "版本不能为空"
 exit 1
fi
echo "读取配置"
source ./config.ini 
echo "开始创建处理路径..."

if [ ! -d "$project_path" ];then
 echo "创建project路径"
 mkdir -p "$project_path"
fi

if [ ! -d "$docker_build_path" ];then
 echo "创建docker构建路径"
 mkdir -p "$docker_build_path"
fi
if [ ! -f "$docker_build_path/Dockerfile" ];then
 echo "创建Dockerfile"
 mv ~/autobuild/Dockerfile $docker_build_path/Dockerfile
fi

echo "开始clone文件..."
if [ ! -f "$project_path/pom.xml" ];then
  git clone $git_path $project_path
  if [ $? -ne 0 ];then
    echo "克隆失败"
    exit 0
  fi
fi

echo "开始编译"
if [ ! -d "$project_path/target" ];then
 cd $project_path
 source ~/autobuild/mavenbuild.sh
 if [ $? -ne 0 ];then
   echo "编译失败"
   exit 0
 fi
fi
echo "编译完成"

echo "获取打包的文件"
cd $project_path/target
result_jar=`ls | grep ".jar$"`
echo $result_jar

# 可能有问题
echo "转移jar包"
if [ ! -f "$docker_build_path/shape.jar" ]; then
  cp $project_path/target/$result_jar $docker_build_path/shape.jar
  if [ ! -f "$docker_build_path/shape.jar" ];then
    echo "jar包转移失败"
    exit 0
  fi
fi

echo "开始构建镜像"
exits_image=`docker image ls | grep $docker_login_registry_url$docker_registry_store | awk '{print $2}'`
if [ "$exits_image" == "$1" ];then
 echo "已存在目标版本镜像"
else 
  cd $docker_build_path
  docker build -t "$docker_login_registry_url$docker_registry_store:$1" .
  if [ $? -ne 0 ];then
    echo "构建失败"
    exit 0
  fi
fi
echo "构建成功开始push镜像"
docker login -u $docker_login_user_name -p $docker_login_user_pwd registry.cn-hangzhou.aliyuncs.com
if [ $? -ne 0 ];then
 echo "登录失败"
fi
echo "上传镜像"
docker push $docker_login_registry_url$docker_registry_store:$1
echo "final done"
