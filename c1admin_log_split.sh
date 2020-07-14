#!/bin/bash

tar -zxvf ./*.tar.gz  &&  cd cron*/  && ./configure && make && make install 

mkdir -p /data/nginx/logs/


mkfifo /data/nginx/logs/access_log_pipe
mkfifo /data/nginx/logs/error_log_pipe


#sed -i s/access_log/access_log_pipe/g /usr/local/nginx/conf/conf.d/*.conf
#configuration  *.conf 's  root  &  access error  log

nohup cat /data/nginx/access_log_pipe | /usr/local/sbin/cronolog /data/nginx/logs/newAdmin_access%Y%m%d/%Y%m%d%H%M.log & 



nohup cat /data/nginx/error_log_pipe | /usr/local/sbin/cronolog /data/nginx/logs/newAdmin_error%Y%m%d/%Y%m%d%H%M.log 2>&1 & 
