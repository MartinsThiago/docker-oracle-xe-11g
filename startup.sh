#!/bin/bash

echo "SETTING ORACLE UP"
cat /oracle-xe_11.2.0-1.0_amd64.deba* > /oracle-xe_11.2.0-1.0_amd64.deb
dpkg --install /oracle-xe_11.2.0-1.0_amd64.deb
mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
printf 8080\\n1521\\noracle\\noracle\\ny\\n | /etc/init.d/oracle-xe configure
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
service oracle-xe start

echo "STARTING PROVISION..."
for SCRIPT in /provision/*; do
	if [ -f "$SCRIPT" ]; then
		sh "$SCRIPT"
	fi
done
echo "PROVISION DONE... "

#Future startups
echo "#!/bin/bash
service oracle-xe start
echo ORACLE XE 11G RUNNING...
tail -f" > /startup.sh

/startup.sh