#!/bin/sh

docker exec -u vmail postfixvmpop3dalpine_pop3_1 mkdir -p /var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - > /etc/virtual/vmaildomains'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /etc/virtual/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >/etc/virtual/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >>/etc/virtual/vmailbox'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /etc/virtual/vmailbox

docker exec postfixvmpop3dalpine_pop3_1 mkdir -p /etc/virtual/mydomain.com
docker exec -it postfixvmpop3dalpine_pop3_1 htpasswd -c -B /etc/virtual/mydomain.com/passwd me
docker exec -it postfixvmpop3dalpine_pop3_1 htpasswd -B /etc/virtual/mydomain.com/passwd another
