#!/bin/sh

if [ -f /var/run/rsyslogd.pid ]; then rm /var/run/rsyslogd.pid; fi
/usr/sbin/rsyslogd -n &

if [ -f /etc/virtual/mailname ]; then postconf -e myorigin=$(cat /etc/virtual/mailname); fi
postfix start

tail -f /var/log/maillog