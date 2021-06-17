#!/bin/sh

mkdir /config/diff.new/
mkdir /config/diff.new/diff
mkdir /config/diff.new/diff/etc
mkdir /config/diff.new/diff/etc/stunnel
cp /config/tmp/new/etc/stunnel/stunnel.conf /etc/stunnel
diff -u /dist/etc/stunnel/stunnel.conf /etc/stunnel/stunnel.conf >/config/diff.new/diff/etc/stunnel/stunnel.conf.diff
cd /config/diff.new/diff
tar c --numeric-owner . 2>/dev/null |base64