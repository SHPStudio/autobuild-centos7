#!/bin/bash
function isexist()
{
    source_str=$1
    test_str=$2
    
    strings=$(echo $source_str | sed 's/:/ /g')
    for str in $strings
    do  
        if [ $test_str = $str ]; then
            return 0
        fi  
    done
    return 1
}

echo "maven未安装... 安装maven"
cd /usr/local
mkdir /devsoft >/dev/null 2>&1
cd devsoft
if [ ! -f "/usr/local/devsoft/apache-maven-3.3.9-bin.tar.gz" ];then
   echo "无maven包...开始下载.."
   wget "https://link.jianshu.com/?t=http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz" -O apache-maven-3.3.9-bin.tar.gz
fi
if [ ! -d "/usr/local/devsoft/apache-maven-3.3.9" ];then
 tar -zxvf apache-maven-3.3.9-bin.tar.gz
fi

echo "设置环境变量"
if [ -z $M2_HOME ];then
   echo "设置M2_HOME.."
   echo "export M2_HOME=/usr/local/devsoft/apache-maven-3.3.9" >> /etc/profile
   source /etc/profile
fi
if [ -z $MAVEN_OPTS ];then
  echo "设置MAVEN_OPTS..."
  echo "export MAVEN_OPTS=-Xmx256m" >> /etc/profile
  source /etc/profile
fi
if isexist $PATH $M2_HOME;then
   echo "" > /dev/null 2>&1
else
   echo "设置PATH..."
   echo "export PATH=/usr/local/devsoft/apache-maven-3.3.9/bin:$PATH" >> /etc/profile
   source /etc/profile
fi
echo "maven已安装"
