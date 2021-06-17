#!/bin/sh

mkdir /config/diff.new/
mkdir /config/diff.new/diff
mkdir /config/diff.new/diff/etc
mkdir /config/diff.new/diff/etc/postfix
cp /config/tmp/new/etc/rsyslog.conf /etc
cp /config/tmp/new/etc/postfix/main.cf /etc/postfix
cp /config/tmp/new/etc/postfix/master.cf /etc/postfix
diff -u /dist/etc/rsyslog.conf /etc/rsyslog.conf >/config/diff.new/diff/etc/rsyslog.conf.diff
diff -u /dist/etc/postfix/main.cf /etc/postfix/main.cf >/config/diff.new/diff/etc/postfix/main.cf.diff
diff -u /dist/etc/postfix/master.cf /etc/postfix/master.cf >/config/diff.new/diff/etc/postfix/master.cf.diff
cd /config/diff.new/diff
tar c --numeric-owner . 2>/dev/null |base64