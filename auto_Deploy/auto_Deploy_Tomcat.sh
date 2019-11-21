#!/bin/bash
#自动部署安装Tomcat
yumIns(){
        rpm -q $1 &> /dev/null
        [ $? -ne 0 ] && ( yum -y install $1 &> /dev/null )
}
yumIns java-1.8.0-openjdk
read -p "请输入Tomcat的安装包路径:" path
tar -xf $path
mv ${path%.tar.gz} /usr/local/tomcat &> /dev/null
/usr/local/tomcat/bin/startup.sh &> /dev/null
