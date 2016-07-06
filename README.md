# Postfix vm-pop3d Docker
#
# Installing Docker

https://docs.docker.com/engine/installation/

## Launch Kitematic terminal (OSX/Windows users)

Click `File` -> `Open Docker Command Linke Terminal`

Kitematic offers a GUI interface for docker

## Build image

## Tag images

## Start container

docker run --name postfix-vm-pop3d -d -P -v postfix-vm-pop3d:/virtual postfix-vm-pop3d-alpine

## Configure users

```
docker exec -it postfix-vm-pop3d mkdir -p /var/spool/virtual/lutnos.com

echo lutnos.com placeholder |docker exec -i postfix-vm-pop3d sh -c 'cat - > /etc/postfix/vmaildomains'
docker exec -it postfix-vm-pop3d postmap /etc/postfix/vmaildomains

echo lyn@lutnos.com lutnos.com/lyn |docker exec -i postfix-vm-pop3d sh -c 'cat - >/etc/postfix/vmailbox'
echo @lutnos.com lutnos.com/lyn |docker exec -i postfix-vm-pop3d sh -c 'cat - >>/etc/postfix/vmailbox'
docker exec -it postfix-vm-pop3d postmap /etc/postfix/vmailbox

docker exec -it postfix-vm-pop3d mkdir -p /etc/virtual/lutnos.com
docker exec -it postfix-vm-pop3d htpasswd -c -d /etc/virtual/lutnos.com/passwd dave
docker exec -it postfix-vm-pop3d htpasswd -d /etc/virtual/lutnos.com/passwd lyn
```

## Test

```

```
