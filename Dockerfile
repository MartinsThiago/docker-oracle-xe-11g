FROM ubuntu:14.04.1

MAINTAINER Martins Thiago <rogue.thiago@gmail.com>

ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
ENV ORACLE_SID=XE
ENV PATH=$ORACLE_HOME/bin:$PATH

ADD chkconfig /sbin/
ADD init.ora /
ADD initXETemp.ora /
ADD oracle-xe_11.2.0-1.0_amd64.deba /
ADD oracle-xe_11.2.0-1.0_amd64.debb /
ADD oracle-xe_11.2.0-1.0_amd64.debc /
ADD startup.sh /

# Install Oracle dependencies
RUN apt-get install -y libaio1 net-tools bc && \
    ln -s /usr/bin/awk /bin/awk && \
    mkdir /var/lock/subsys && \
    chmod 755 /sbin/chkconfig && \
    chmod +x /startup.sh

EXPOSE 1521
EXPOSE 8080

ENTRYPOINT ["/startup.sh"]