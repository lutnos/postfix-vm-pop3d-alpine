#!/bin/sh

mkdir -p /virtual/var/log
ln -s /virtual/var/log/maillog /var/log/maillog
ln -s /virtual/var/log/stunnel.log /var/stunnel/stunnel.log
mkdir -p /virtual/etc/virtual
ln -s /virtual/etc/virtual /etc/virtual
mkdir -p /virtual/var/spool/virtual
ln -s /virtual/var/spool/virtual /var/spool/virtual
chown vmail:postdrop /var/spool/virtual