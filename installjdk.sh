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


echo "jdk未安装... 安装jdk"
cd /usr/local
mkdir /devsoft >/dev/null 2>&1
if [ ! -d "/usr/local/devsoft" ];then
  mkdir -p "/usr/local/devsoft"
fi

cd devsoft
if [ ! -f "/usr/local/devsoft/jdk-8u201-linux-x64.tar.gz" ];then
   echo "无jdk包...开始下载.."
   wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"
fi
if [ ! -d "/usr/local/devsoft/jdk1.8" ];then
 tar -zxvf jdk-8u141-linux-x64.tar.gz
 mv jdk1.8.0_141 jdk1.8
fi

echo "设置环境变量"
if [ -z $JAVA_HOME ];then
   echo "设置JAVA_HOME.."
   echo "export JAVA_HOME=/usr/local/devsoft/jdk1.8" >> /etc/profile
   source /etc/profile
fi
if [ -z $CLASSPATH ];then
  echo "设置CLASSPATH..."
  echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile
  source /etc/profile
fi
if isexist $PATH $JAVA_HOME; then
   echo "" > /dev/null 2>&1
else
   echo "设置PATH..."
   echo "export PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
   source /etc/profile
fi
echo "jdk已安装"
