#!/bin/sh

if [ -f /var/run/rsyslogd.pid ]; then rm /var/run/rsyslogd.pid; fi
/usr/sbin/rsyslogd -n &

# /usr/bin/sa-update --verbose

/usr/sbin/spamd --daemonize --listen=0.0.0.0:783 --allowed-ips=172.16.0.0/12 --pidfile /var/run/spamd.pid \&
  --syslog=mail --username=spamd --nouser-config --max-children=5 --create-prefs --helper-home-dir &

tail -f /var/log/maillog