#!/bin/bash
#set -e
#参数格式 TRACKER_SERVER=192.168.126.166:22122,192.168.126.167:22122
if [ -n "$TRACKER_SERVER" ] ; then
	#split string
	arr=($TRACKER_SERVER)
	IFS=","
	tracker_server_str=""
	for element in ${arr[@]}
	do
		tracker_server_str=${tracker_server_str}"tracker_server"=${element}"\\n"
	done
	echo $tracker_server_str
	sed -i "s|tracker_server=.*$|${tracker_server_str}|g" /etc/fdfs/*
fi


/etc/init.d/nginx start
/etc/init.d/php7.0-fpm start
tail -f /var/log/nginx/error.log
