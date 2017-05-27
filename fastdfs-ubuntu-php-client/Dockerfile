FROM ubuntu

LABEL maintainer "plokplokplok@163.com"

ENV FASTDFS_PATH=/opt/fdfs \
    FASTDFS_BASE_PATH=/var/fdfs \
    PORT= \
    GROUP_NAME= \
    TRACKER_SERVER=


RUN apt-get update -y
#get all the dependences
RUN apt-get install -y git gcc make

#create the dirs to store the files downloaded from internet
RUN mkdir -p ${FASTDFS_PATH}/libfastcommon \
 && mkdir -p ${FASTDFS_PATH}/fastdfs \
 && mkdir ${FASTDFS_BASE_PATH}

#compile the libfastcommon
WORKDIR ${FASTDFS_PATH}/libfastcommon

RUN git clone --depth 1 https://github.com/happyfish100/libfastcommon.git ${FASTDFS_PATH}/libfastcommon \
 && ./make.sh \
 && ./make.sh install \
 && rm -rf ${FASTDFS_PATH}/libfastcommon

#compile the fastdfs
WORKDIR ${FASTDFS_PATH}/fastdfs

RUN git clone --depth 1 https://github.com/happyfish100/fastdfs.git ${FASTDFS_PATH}/fastdfs \
 && ./make.sh \
 && ./make.sh install \
 && rm -rf ${FASTDFS_PATH}/fastdfs

RUN apt-get install -y nginx
RUN apt-get install -y php
RUN apt-get install -y php-mbstring
RUN apt-get install -y php-curl
RUN apt-get install -y php-xml
RUN apt-get install -y php-gd
RUN apt-get install -y php-mysql
RUN rm -rf /etc/nginx/sites-enabled/default

#php 7.0 fastdfs扩展及配置
COPY fastdfs_client.so /usr/lib/php/20151012/fastdfs_client.so
COPY fastdfs_client.ini ${FASTDFS_PATH}/fastdfs/fastdfs_client.ini
RUN cat ${FASTDFS_PATH}/fastdfs/fastdfs_client.ini >> /etc/php/7.0/fpm/php.ini

#EXPOSE 22122 23000 8080 8888
EXPOSE 80
VOLUME ["$FASTDFS_BASE_PATH", "/etc/fdfs"]

COPY conf/*.* /etc/fdfs/

#nginx配置
COPY nginx-conf/www.conf /etc/nginx/conf.d/www.conf

#demo
COPY demo /var/www/

#sh脚本
COPY start.sh /usr/bin/

#make the start.sh executable 
RUN chmod 777 /usr/bin/start.sh

#如不需要nginx，可去掉第二个参数
ENTRYPOINT ["/usr/bin/start.sh"]
