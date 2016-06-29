# Postfix vm-pop3d Docker
#
# Installing Docker

https://docs.docker.com/engine/installation/

## Launch Kitematic terminal (OSX/Windows users)

Click `File` -> `Open Docker Command Linke Terminal`

Kitematic offers a GUI interface for docker


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
