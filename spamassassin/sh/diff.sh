#!/bin/sh

mkdir /config/diff.new/
mkdir /config/diff.new/diff
mkdir /config/diff.new/diff/etc
mkdir /config/diff.new/diff/etc/mail
mkdir /config/diff.new/diff/etc/mail/spamassassin
cp /config/tmp/new/etc/rsyslog.conf /etc
cp /config/tmp/new/etc/mail/spamassassin/local.cf /etc/mail/spamassassin
cp /config/tmp/new/etc/mail/spamassassin/v320.pre /etc/mail/spamassassin
diff -u /dist/etc/rsyslog.conf /etc/rsyslog.conf >/config/diff.new/diff/etc/rsyslog.conf.diff
diff -u /dist/etc/mail/spamassassin/local.cf /etc/mail/spamassassin/local.cf >/config/diff.new/diff/etc/mail/spamassassin/local.cf.diff
diff -u /dist/etc/mail/spamassassin/v320.pre /etc/mail/spamassassin/v320.pre >/config/diff.new/diff/etc/mail/spamassassin/v320.pre.diff
cd /config/diff.new/diff
tar c --numeric-owner . 2>/dev/null |base64