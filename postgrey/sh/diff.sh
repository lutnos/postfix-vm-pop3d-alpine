#!/bin/sh

mkdir /config/diff.new/
mkdir /config/diff.new/diff
mkdir /config/diff.new/diff/etc
cp /config/tmp/new/etc/rsyslog.conf /etc
diff -u /dist/etc/rsyslog.conf /etc/rsyslog.conf >/config/diff.new/diff/etc/rsyslog.conf.diff
cd /config/diff.new/diff
tar c --numeric-owner . 2>/dev/null |base64