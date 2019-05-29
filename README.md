# autobuild-centos7
 基于centos7的自动构建系统
## 前提条件
  1. Centos7系统
  2. 拥有阿里云镜像仓库
  3. SpringBoot以jar包形式打包的项目
  4. JDK8项目
  5. 使用maven构建
  6. 使用github或其他可以使用https clone项目的版本库
## 使用
  1. 开启一台虚拟机或者Centos7的服务器等。
  2. 执行命令`yum -y install unzip && curl -L https://github.com/SHPStudio/autobuild-centos7/archive/master.zip -o autobuild.zip && unzip autobuild.zip && mv autobuild-centos7-master autobuild`
  3. 修改配置，主要是要clone的git路经、docker镜像仓库的链接和仓库名字、用于登录推送镜像到docker镜像仓库的用户名密码、和项目数据、docker构建路劲，以后可能还会有其他配置。
  4. 第一次使用时需要安装必备的软件，进入autobuild目录，执行`source init.sh`命令，一定要用source因为安装jdk等软件需要修改环境变量，只有在本shell中执行才会修改生效。失败后直接退出当前会话，如有bug欢迎骚扰。
  5. 安装成功后，就可以以`sh start.sh [版本号]` eg:v1 的形式执行最终会把生成好的镜像推送到远端镜像仓库中。
  
## 未来计划
  1.使用python写一个能够可视化操作页面操作
  2.会写一个客户端脚本并可以在该系统中发现客户端，一件构建和部署
