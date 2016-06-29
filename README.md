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

docker run -d -P -v virtual:postfix-vm-pop3d postfix-vm-pop3d-alpine
8f41

## Configure users

```
Dave:personal dave$ docker exec -it 8f41 mkdir -p /etc/virtual/lutnos.com
Dave:personal dave$ docker exec -it 8f41 sh -c 'cd /etc/virtual/lutnos.com; htpasswd -c -d passwd dave'
New password:
Re-type new password:
Adding password for user dave
Dave:personal dave$ docker exec -it 8f41 sh -c 'cd /etc/virtual/lutnos.com; htpasswd -d passwd lyn'
New password:
Re-type new password:
Adding password for user lyn
Dave:personal dave$
```
