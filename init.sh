#!/bin/bash
checkyumsoft() {
  list_all_installed=`yum list installed | grep "^$1."`
  if [[ ! -z $list_all_installed ]]
    then
       echo "已安装$1...."
  else
    echo "没有安装$1 ... 开始安装$1 ..."
    yum install -y $1
    if [ $? -ne 0 ];then
      echo "安装$1...失败"
      exit 1
    else
      echo "done"
    fi
  fi

}

echo "读取配置...."
source ./config.ini
echo "检查yum软件安装...."
checkyumsoft "wget"
checkyumsoft "git"

echo "检查docker是否安装...."
docker info >/dev/null 2>&1
if [ $? -ne 0 ];then
   echo "未安装docker...开始安装docker"
   curl -fsSL https://get.docker.com/ | sh
   service docker start
   systemctl enable docker
   echo "done"
else
   echo "docker已安装"
fi

echo "检查jdk是否安装...."
java -version >/dev/null 2>&1
if [ $? -ne 0 ];then
   source ~/autobuild/installjdk.sh
   if [ $? -ne 0 ];then
     echo "安装jdk失败"
     exit 0
   fi
else
   echo "jdk已安装"
fi

echo "检查maven是否安装..."
mvn -v >/dev/null 2>&1
if [ $? -ne 0 ];then
  source ~/autobuild/installmaven.sh
  if [ $? -ne 0 ];then
    echo "安装maven失败"
    exit 0
  fi
else
  echo "maven已安装"
fi

echo "软件检查结束。"

