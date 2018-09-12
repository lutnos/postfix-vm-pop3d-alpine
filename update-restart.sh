#!/bin/sh

docker update postfix-vm-pop3d-alpine_spamassassin_1 --restart unless-stopped postfix-vm-pop3d-alpine_spamassassin_1
docker update postfix-vm-pop3d-alpine_pop3_1 --restart unless-stopped postfix-vm-pop3d-alpine_pop3_1
docker update postfix-vm-pop3d-alpine_postgrey_1 --restart unless-stopped postfix-vm-pop3d-alpine_postgrey_1
docker update postfix-vm-pop3d-alpine_stunnel_1 --restart unless-stopped postfix-vm-pop3d-alpine_stunnel_1
docker update postfix-vm-pop3d-alpine_smtp_1 --restart unless-stopped postfix-vm-pop3d-alpine_smtp_1