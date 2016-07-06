#!/bin/sh

#/mkvirtual.sh

/usr/sbin/rsyslogd -n &
postfix start
vm-pop3d -d --user vmail
stunnel

touch /tail.target
tail -f /tail.target