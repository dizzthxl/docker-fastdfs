# FastDFS Docker

Usage:(最后一个参数为说明)

docker run -itd --net=host --name ubuntu-storage0 -e TRACKER_SERVER=192.168.126.166:22122 ubuntu-fastdfs-php-client

#docker run -itd -p 9001:80 --name ubuntu-php-client -e TRACKER_SERVER=192.168.126.166:22122 ubuntu-fastdfs-php-client


参数说明
--net=host 外部端口和容器端口一致
TRACKER_SERVER GROUP_NAME PORT   会写入fastdfs的配置文件
-v /var/fdfs/storage2:/var/fdfs  将存储目录挂载出来
最后参数storage  会启用不同配置是tracker还是storage

测试
http://192.168.126.166:9001/test.php
