## 下载安装java JDK
[官网地址](http://www.oracle.com/)

下载安装包jdk-8u11-linux-x64.tar.gz

mkdir -p /usr/local/services

tar zxvf jdk-8u11-linux-x64.tar.gz
(2)配置环境变量 vim /etc/profile
JAVA_HOME=/usr/local/services/jdk1.8.0_11
CLASSPATH=$JAVA_HOME/lib/
PATH=$PATH:$JAVA_HOME/bin
export PATH JAVA_HOME CLASSPATH
重启机器或执行命令 ：source /etc/profile

##  安装zookeeper

wget http://mirrors.cnnic.cn/apache/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz -P /usr/local/services

mkdir -p /usr/local/services/zookeeper-3.4.13/{logs,data}

修改zoo.cfg

dataLogDir=/usr/local/services/zookeeper-3.4.13/logs
dataDir=/usr/local/services/zookeeper-3.4.13/data
server.1= 192.168.63.10:2888:3888
server.2= 192.168.63.11:2888:3888
server.3= 192.168.63.12:2888:3888

echo -e "# append zk_env\nexport PATH=$PATH:/usr/local/services/zookeeper-3.4.13/bin" >> /etc/profile
echo "1" > /usr/local/services/zookeeper-3.4.13/data/myid





/usr/local/services/zookeeper-3.4.13/bin/zkServer.sh start





注意关闭防火墙

service iptables stop
chkconfig  iptables off

