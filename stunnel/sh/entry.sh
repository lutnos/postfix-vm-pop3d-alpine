#!/bin/sh

if [ ! -d /etc/volume/stunnel ]; then mkdir /etc/volume/stunnel && cp /etc/entry/* /etc/volume/stunnel; fi
ln -sf /etc/volume/stunnel /etc

stunnel

tail -f /var/stunnel/stunnel.log