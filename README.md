# Postfix vm-pop3d Docker
#
# Installing Docker

https://docs.docker.com/engine/installation/

## Launch Kitematic terminal (OSX/Windows users)

Click `File` -> `Open Docker Command Linke Terminal`

Kitematic offers a GUI interface for docker

## Start container

```
docker compose up
```

## Configure users

This example configures me@mydomain.com and another@mydomain.com .  The me@mydomain.com mailbox will also
receive any other mail fpor mydomain.com not exp[licitly configured.

./demo.sh from the host will do this, just enter a pw1 and a pw2 .

```
docker exec -u vmail postfixvmpop3dalpine_pop3_1 mkdir -p /var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - > /etc/virtual/vmaildomains'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /etc/virtual/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >/etc/virtual/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >>/etc/virtual/vmailbox'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /etc/virtual/vmailbox

docker exec postfixvmpop3dalpine_smtp_1 mkdir -p /etc/virtual/mydomain.com
docker exec -it postfixvmpop3dalpine_pop3_1 htpasswd -c -B /etc/virtual/mydomain.com/passwd me
docker exec -it postfixvmpop3dalpine_pop3_1 htpasswd -B /etc/virtual/mydomain.com/passwd another
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
user another@mydomain.com
pass pw2
stat
retr 1
dele 1
quit
^C

openssl s_client -connect 127.0.0.1:995
user another@mydomain.com
pass pw2
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
