## 下载安装java JDK
[官网地址](http://www.oracle.com/)

mkdir -p /usr/local/services

cd /usr/local/services

(1)下载安装包jdk-8u11-linux-x64.tar.gz,并解压

tar -zxvf jdk-8u11-linux-x64.tar.gz

(2)配置环境变量

vim /etc/profile
```
JAVA_HOME=/usr/local/services/jdk1.8.0_11
CLASSPATH=$JAVA_HOME/lib/
PATH=$PATH:$JAVA_HOME/bin
export PATH JAVA_HOME CLASSPATH
```

重启机器或执行命令 ：source /etc/profile

##  安装zookeeper
```
wget http://mirrors.cnnic.cn/apache/zookeeper/zookeeper-3.4.8/zookeeper-3.4.13.tar.gz -P /usr/local/services
tar -zxvf zookeeper-3.4.13.tar.gz
mkdir -p /usr/local/services/zookeeper-3.4.13/{logs,data}
cd /usr/local/services/zookeeper-3.4.13/conf
cp zoo_sample.cfg   zoo.cfg
```

vim zoo.cfg

```
dataLogDir=/usr/local/services/zookeeper-3.4.13/logs
dataDir=/usr/local/services/zookeeper-3.4.13/data
server.1= 192.168.63.10:2888:3888
server.2= 192.168.63.11:2888:3888
server.3= 192.168.63.12:2888:3888
```

echo -e "# append zk_env\nexport PATH=$PATH:/usr/local/services/zookeeper-3.4.13/bin" >> /etc/profile

重启机器或执行命令 ：source /etc/profile



192.168.63.10主机：echo "1" > /usr/local/services/zookeeper-3.4.13/data/myid

192.168.63.11主机：echo "2" > /usr/local/services/zookeeper-3.4.13/data/myid

192.168.63.12主机：echo "3" > /usr/local/services/zookeeper-3.4.13/data/myid

每台主机分别启动 /usr/local/services/zookeeper-3.4.13/bin/zkServer.sh start

查看启动状态 /usr/local/services/zookeeper-3.4.13/bin/zkServer.sh status

zkServer.sh start-foreground


注意关闭防火墙

service iptables stop
chkconfig  iptables off