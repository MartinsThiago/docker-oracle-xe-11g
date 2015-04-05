#!/bin/bash

#Oracle first start
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
service oracle-xe start

#Container provision
echo "STARTING PROVISIONING..."
for SCRIPT in /provision/*; do
	if [ -f "$SCRIPT" ]; then
		sh "$SCRIPT"
	fi
done

#Future startups
echo "#!/bin/bash
service oracle-xe start
echo ORACLE XE 11G RUNNING...
tail -f" > /startup.sh

/startup.sh
