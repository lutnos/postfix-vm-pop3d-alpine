#!/bin/sh

# remote syslog server to docker host
SYSLOG=`netstat -rn|grep ^0.0.0.0|awk '{print $2}'`
echo "*.*	@$SYSLOG" > /etc/rsyslog.d/50-default.conf

/usr/bin/supervisord -c /etc/supervisord.d/supervisord.ini