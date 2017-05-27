#!/bin/bash
#set -e

if [ "$1" = "storage" ] ; then
	FASTDFS_MODE="storage"
	#
	rm /var/fdfs/data/.data_init_flag
	#删除无用config
	rm /etc/nginx/conf.d/tracker.conf
	#建立软链接
	ln -s /var/fdfs/data/ /var/fdfs/data/M00
else
	FASTDFS_MODE="tracker"
	#删除无用config
	rm /etc/nginx/conf.d/storage.conf
fi

if [ -n "$PORT" ] ; then
	sed -i "s|^port=.*$|port=${PORT}|g" /etc/fdfs/"$FASTDFS_MODE".conf
fi

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

#group1		group2	分组
if [ -n "$GROUP_NAME" ] ; then
	sed -i "s|group_name=.*$|group_name=${GROUP_NAME}|g" /etc/fdfs/storage.conf
fi

FASTDFS_LOG_FILE="${FASTDFS_BASE_PATH}/logs/${FASTDFS_MODE}d.log"
PID_NUMBER="${FASTDFS_BASE_PATH}/data/fdfs_${FASTDFS_MODE}d.pid"

echo "try to start the $FASTDFS_MODE node..."
if [ -f "$FASTDFS_LOG_FILE" ]; then
	rm "$FASTDFS_LOG_FILE"
fi
# start the fastdfs node.	
fdfs_${FASTDFS_MODE}d /etc/fdfs/${FASTDFS_MODE}.conf start

if [ "$1" = "storage" ] ; then
#启动nginx
/etc/init.d/nginx start
fi

# wait for pid file(important!),the max start time is 5 seconds,if the pid number does not appear in 5 seconds,start failed.
TIMES=5
while [ ! -f "$PID_NUMBER" -a $TIMES -gt 0 ]
do
	sleep 1s
	TIMES=`expr $TIMES - 1`
done

tail -f "$FASTDFS_LOG_FILE"
