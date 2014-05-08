#!/bin/bash
file="/tmp/mysql-server-setup.pid"
if [ -f $file ]; then
        echo "mysql server setup already completed"
else 
        echo "setting up mysql-server"
        /etc/init.d/mysqld start
	/sbin/chkconfig mysqld on
	/usr/bin/mysql -u root < /tmp/setuphiveusers.sql
        /usr/bin/mysql -u root < /tmp/setupoozieusers.sql
	/bin/touch '/tmp/mysql-server-setup.pid'
fi
