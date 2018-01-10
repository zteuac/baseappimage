#!/bin/bash
set -e

#Modify /usr/local/tomcat/webapps/conf/config.xml
#sed -i 's#\$\$httpsClient\$\$#'${httpsClient}'#g' /usr/local/tomcat/conf/config.xml
#sed -i 's#\$\$httpsKeyStore\$\$#'${httpsKeyStore}'#g' /usr/local/tomcat/conf/config.xml

export TZ=Asia/Shanghai
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

cd /usr/local/tomcat/bin
./startup.sh

#mkdir /var/lib/rsyslog/work/
#service rsyslog start

#service flume start

crontab /usr/local/tomcat/tomcat_cron
crontab -l
service crond start

echo "start sleep........."
while [ 1 ]
do
        sleep 300
done
