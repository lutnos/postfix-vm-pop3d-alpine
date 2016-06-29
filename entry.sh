#!/bin/sh

/usr/sbin/rsyslogd -n &
postfix start
vm-pop3d -d
stunnel

tail -f /tail.target