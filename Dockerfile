FROM ubuntu:14.04.1

MAINTAINER Martins Thiago <rogue.thiago@gmail.com>

ADD chkconfig /sbin/chkconfig
ADD init.ora /
ADD initXETemp.ora /
ADD oracle-xe_11.2.0-1.0_amd64.debaa /
ADD oracle-xe_11.2.0-1.0_amd64.debab /
ADD oracle-xe_11.2.0-1.0_amd64.debac /
# ADD oracle-xe_11.2.0-1.0_amd64.deb /
RUN cat /oracle-xe_11.2.0-1.0_amd64.deba* > /oracle-xe_11.2.0-1.0_amd64.deb

# Prepare to install Oracle
RUN apt-get install -y libaio1 net-tools bc
RUN ln -s /usr/bin/awk /bin/awk
RUN mkdir /var/lock/subsys
RUN chmod 755 /sbin/chkconfig

# Install Oracle
RUN dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
RUN mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure

ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
ENV ORACLE_SID=XE
ENV PATH=$ORACLE_HOME/bin:$PATH

ADD startup.sh /startup.sh
RUN chmod +x /startup.sh
RUN mkdir /provision

# Remove installation files
RUN rm /oracle-xe_11.2.0-1.0_amd64.deb*

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/startup.sh"]
