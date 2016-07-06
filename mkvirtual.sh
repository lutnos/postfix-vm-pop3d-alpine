#!/bin/sh

mkdir -p /virtual/etc/virtual
 ls -al /virtual/etc/virtual
ln -s -v /virtual/etc/virtual /etc/
 ls -al /etc/virtual
mkdir -p /virtual/var/log
touch /virtual/var/log/maillog
 ls -al /virtual/var/log/maillog
ln -s -v /virtual/var/log/maillog /var/log/maillog
mkdir -p /virtual/var/stunnel
 ls -al /virtual/var/stunnel
ln -s -v /virtual/var/stunnel /var/
 ls -al /var/stunnel
mkdir -p /virtual/var/spool/virtual
 ls -al /virtual/var/spool/virtual
ln -s -b -v /virtual/var/spool/virtual /var/spool/
  ls -al /var/spool/virtual
chown vmail:postdrop /virtual/var/spool/virtual
  ls -al /virtual/var/spool/virtual
