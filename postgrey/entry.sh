#!/bin/sh

if [ -f /var/run/rsyslogd.pid ]; then rm /var/run/rsyslogd.pid; fi
/usr/sbin/rsyslogd -n &

/usr/sbin/postgrey --daemonize --inet=0.0.0.0:10023 --pidfile=/var/run/postgrey.pid --delay=50 \
  --syslog-facility postgrey --hostname=postgrey --greylist-text='Greylisted for %s seconds'

tail -f /var/log/messages