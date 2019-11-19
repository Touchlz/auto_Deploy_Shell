#!/bin/bash
#自动部署LNMP服务, 需要提供nginx源码包
#确保yum仓库可用

yumIns(){
	rpm -q $1 &> /dev/null
	[ $? -ne 0  ] && ( yum -y install $1 &> /dev/null )
}
yumIns gcc;yumIns pcre-devel;yumIns openssl-devel;yumIns mariadb;yumIns mariadb-server;yumIns mariadb-devel;yumIns php;yumIns php-mysql;yumIns php-fpm
read -p "请指定nginx源码包路径:" path
tar -xf $path -C /root/ &> /dev/null
cd ${path%.tar.gz}
id nginx
if [ $? -ne 0 ];then
	useradd -s /sbin/nologin nginx &> /dev/null
fi
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module &> /dev/null
make && make install &> /dev/null
cp /usr/local/nginx/sbin/nginx /usr/bin/nginx
nginx
systemctl restart mariadb &> /dev/null
systemctl restart php-fpm &> /dev/null
