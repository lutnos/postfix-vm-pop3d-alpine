# Postfix vm-pop3d Docker
#
# Installing Docker

https://docs.docker.com/engine/installation/

## Launch Kitematic terminal (OSX/Windows users)

Click `File` -> `Open Docker Command Linke Terminal`

Kitematic offers a GUI interface for docker

## Build image

```
docker build postfix-vm-pop3d-alpine
```

## Tag images

For some image ID 0123abc
```
docker images
docker tag 0123abc postfix-vm-pop3d-alpine:latest
```

## Start container

```
docker run --name postfix-vm-pop3d -d -p 25:25 -p 110:110 -p 465:465 -p 995:995 -v postfix-vm-pop3d-data:/data postfix-vm-pop3d-alpine
```

## Configure users

This example configures me@mydomain.com and another@mydomain.com .  The me@mydomain.com mailbox will also
receive any other mail fpor mydomain.com not exp[licitly configured.

./demo.sh from the host will do this, just enter a pw1 and a pw2 .

```
docker exec -u vmail postfix-vm-pop3d mkdir -p /data/var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfix-vm-pop3d sh -c 'cat - > /data/etc/postfix/vmaildomains'
docker exec -t postfix-vm-pop3d postmap /data/etc/postfix/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfix-vm-pop3d sh -c 'cat - >/data/etc/postfix/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfix-vm-pop3d sh -c 'cat - >>/data/etc/postfix/vmailbox'
docker exec -u vmail postfix-vm-pop3d touch /data/var/spool/virtual/mydomain.com/me

docker exec postfix-vm-pop3d mkdir -p /data/etc/virtual/mydomain.com
docker exec -it postfix-vm-pop3d htpasswd -c -B /data/etc/virtual/mydomain.com/passwd me
docker exec -it postfix-vm-pop3d htpasswd -B /data/etc/virtual/mydomain.com/passwd another
```

## Test

```
ncat 127.0.0.1 25
ehlo test.com
mail from: test@test.com
rcpt to: another@mydomain.com
data
Subject: Test

test
.
quit
^C

ncat 127.0.0.1 110
user another
pass pw1
stat
retr 1
dele 1
quit
^C

openssl s_client -connect 127.0.0.1:995
user me@mydomain.com
pass pw1
quit

openssl s_client -connect 127.0.0.1:465
ehlo test.com
mail from: test@test.com
rcpt to: another@mydomain.com
data
Subject: Test

test
.
quit

```
