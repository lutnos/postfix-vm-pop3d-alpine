#!/bin/sh

docker update postfix-vm-pop3d-alpine-spamassassin-1 --restart unless-stopped postfix-vm-pop3d-alpine-spamassassin-1
docker update postfix-vm-pop3d-alpine-pop3-1 --restart unless-stopped postfix-vm-pop3d-alpine-pop3-1
docker update postfix-vm-pop3d-alpine-postgrey-1 --restart unless-stopped postfix-vm-pop3d-alpine-postgrey-1
docker update postfix-vm-pop3d-alpine-stunnel-1 --restart unless-stopped postfix-vm-pop3d-alpine-stunnel-1
docker update postfix-vm-pop3d-alpine-smtp-1 --restart unless-stopped postfix-vm-pop3d-alpine-smtp-1