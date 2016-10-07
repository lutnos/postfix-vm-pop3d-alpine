#!/bin/sh

if [ -f /var/run/rsyslogd.pid ]; then rm /var/run/rsyslogd.pid; fi
/usr/sbin/rsyslogd -n &

postconf -e myorigin=$(cat /etc/virtual/mailname)

postfix start

tail -f /var/log/maillog