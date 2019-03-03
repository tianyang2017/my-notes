###  centos7.0下安装redis-4.0.6

mkdir -p /usr/local/services

cd /usr/local/services

wget http://download.redis.io/releases/redis-4.0.6.tar.gz

tar -zxvf redis-4.0.6.tar.gz

yum install gcc

cd redis-4.0.6/deps/

make  hiredis jemalloc linenoise lua

cd ../src

make install

启服务 :redis-server.exe

客户端 redis-cli.exe -h 127.0.0.1 -p 6379

五种数据类型 String hash list set 有序set