#!/bin/bash
#Fix Oracle Listener
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora

echo "STARTING ORACLE..."
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
