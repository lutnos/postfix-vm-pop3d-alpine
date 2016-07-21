#!/bin/sh

touch /var/run/rsyslogd.pid
rm /var/run/rsyslogd.pid
/usr/sbin/rsyslogd -n &

vm-pop3d -d --user vmail

tail -f /data/var/log/pop3log