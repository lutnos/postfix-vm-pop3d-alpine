#!/bin/sh

touch /var/run/rsyslogd.pid
rm /var/run/rsyslogd.pid
/usr/sbin/rsyslogd -n &

postfix start

tail -f /data/var/log/maillog