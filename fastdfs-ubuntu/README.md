# FastDFS Docker

Usage:(最后一个参数为说明)


docker run -itd --net=host --name ubuntu-tracker -v /var/fdfs/tracker:/var/fdfs ubuntu-fastdfs tracker

#docker run -itd -p 22122:22122 -p 8001:80 --name ubuntu-tracker -v /var/fdfs/tracker:/var/fdfs ubuntu-fastdfs-v2 tracker



docker run -itd --net=host --name ubuntu-storage0 -e TRACKER_SERVER=192.168.126.166:22122 -v /var/fdfs/storage0:/var/fdfs ubuntu-fastdfs storage

#docker run -itd -p 23000:23000 -p 8002:80 --name ubuntu-storage0 -e TRACKER_SERVER=192.168.126.166:22122 -v /var/fdfs/storage0:/var/fdfs ubuntu-fastdfs-v2 storage


docker run -itd --net=host --name ubuntu-storage1 -e TRACKER_SERVER=192.168.126.166:22122 -v /var/fdfs/storage1:/var/fdfs ubuntu-fastdfs storagee

docker run -itd --net=host --name ubuntu-storage2 -e TRACKER_SERVER=192.168.126.166:22122 -e GROUP_NAME=group2 -e PORT=22222 -v /var/fdfs/storage2:/var/fdfs ubuntu-fastdfs storage

参数说明
--net=host 外部端口和容器端口一致
TRACKER_SERVER GROUP_NAME PORT   会写入fastdfs的配置文件
-v /var/fdfs/storage2:/var/fdfs  将存储目录挂载出来
最后参数storage  会启用不同配置是tracker还是storage

测试
fdfs_test /opt/fastdfs/conf/client.conf upload /tmp/12.jpg
