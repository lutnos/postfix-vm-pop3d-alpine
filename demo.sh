#!/bin/sh

docker exec -u vmail postfix-vm-pop3d-alpine-pop3-1 mkdir -p /var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfix-vm-pop3d-alpine-smtp-1 sh -c 'cat - > /etc/virtual/vmaildomains'
docker exec -t postfix-vm-pop3d-alpine-smtp-1 postmap /etc/virtual/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfix-vm-pop3d-alpine-smtp-1 sh -c 'cat - >/etc/virtual/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfix-vm-pop3d-alpine-smtp-1 sh -c 'cat - >>/etc/virtual/vmailbox'
docker exec -t postfix-vm-pop3d-alpine-smtp-1 postmap /etc/virtual/vmailbox

docker exec postfix-vm-pop3d-alpine-pop3-1 mkdir -p /etc/virtual/mydomain.com
docker exec -it postfix-vm-pop3d-alpine-pop3-1 htpasswd -c -B /etc/virtual/mydomain.com/passwd me
docker exec -it postfix-vm-pop3d-alpine-pop3-1 htpasswd -B /etc/virtual/mydomain.com/passwd another
