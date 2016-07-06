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
docker tag 0123abc postfix-vm-pop3d:latest
```

## Start container

```
docker run --name postfix-vm-pop3d -d -P -v postfix-vm-pop3d:/virtual postfix-vm-pop3d-alpine
```

## Configure users

./demo.sh from the host will do this, just enter a pw1 and a pw2 .

```
docker exec -it postfix-vm-pop3d mkdir -p /var/spool/virtual/mydomain.com

echo mydomain.com placeholder |docker exec -i postfix-vm-pop3d sh -c 'cat - > /etc/postfix/vmaildomains'
docker exec -it postfix-vm-pop3d postmap /etc/postfix/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfix-vm-pop3d sh -c 'cat - >/etc/postfix/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfix-vm-pop3d sh -c 'cat - >>/etc/postfix/vmailbox'
docker exec -it postfix-vm-pop3d postmap /etc/postfix/vmailbox

docker exec -it postfix-vm-pop3d mkdir -p /etc/virtual/mydomain.com
docker exec -it postfix-vm-pop3d htpasswd -c -d /etc/virtual/mydomain.com/passwd me
docker exec -it postfix-vm-pop3d htpasswd -d /etc/virtual/mydomain.com/passwd another
```

## Test

For some post mapped port 25 say 32789 and some mapped port 110, say 32788

```
docker ps
ncat 127.0.0.1 32789
ehlo test.com
mail from: test@test.com
rcpt to: another@mydomain.com
data
Subject: Test

test
.
^C
ncat 127.0.0.1 32788
user another
pass pw1
stat
retr 1
dele 1
quit
^C
```
