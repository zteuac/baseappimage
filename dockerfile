FROM apphub.zte.com.cn/dev/centos:6.8
RUN yum install -y https://objectstorage.us-ashburn-1.oraclecloud.com/p/yWwR4Al81y-vMBMwHssK9dEaPIifBZPkdKLNCCdczr0/n/zte/b/artifacts-apps/o/jdk-7u55-linux-x64.rpm \
    redhat-lsb \
    crontabs  \
    && yum clean all
ADD ./tomcat.tar.gz /usr/local/
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
ADD ./nginx-1.11.6-1.el6.ngx.x86_64.rpm /usr/local/
RUN chmod 755 /usr/local/nginx-1.11.6-1.el6.ngx.x86_64.rpm && rpm -ivh /usr/local/nginx-1.11.6-1.el6.ngx.x86_64.rpm
COPY ./catalina.sh /usr/local/tomcat/bin/ 
COPY ./tomcat-users.xml  /usr/local/tomcat/conf/ 
COPY ./tomcat_cron /usr/local/tomcat/ 
COPY ./tomcat /usr/local/tomcat/logrotate/
COPY ./nginx/nginx.conf /etc/nginx/
ADD ./nginx/conf.d/tcp /etc/nginx/conf.d/tcp/
EXPOSE 8080
COPY ./run.sh /root/
RUN chmod 755 /root/run.sh \
    && chmod 755 /usr/local/tomcat/bin/catalina.sh \
    && mkdir /var/lib/rsyslog/work/ \
    && chkconfig iptables off \
CMD ["/root/run.sh"]
