#!/bin/sh

mkdir -p /virtual/var/log
ln -s /var/log/maillog /virtual/var/log/maillog
ln -s /var/stunnel/stunnel.log /virtual/var/log/stunnel.log
mkdir -p /virtual/etc/virtual
ln -s /etc/virtual /virtual/etc/virtual
mkdir -p /virtual/var/spool/virtual
ln -s /var/spool/virtual /virtual/var/spool/virtual
chown vmail:postdrop /var/spool/virtual