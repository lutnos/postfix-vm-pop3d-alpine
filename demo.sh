docker exec -u vmail postfixvmpop3dalpine_smtp_1 mkdir -p /data/var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - > /data/etc/postfix/vmaildomains'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /data/etc/postfix/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >/data/etc/postfix/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfixvmpop3dalpine_smtp_1 sh -c 'cat - >>/data/etc/postfix/vmailbox'
docker exec -t postfixvmpop3dalpine_smtp_1 postmap /data/etc/postfix/vmailbox

docker exec postfixvmpop3dalpine_smtp_1 mkdir -p /data/etc/virtual/mydomain.com
docker exec -it postfixvmpop3dalpine_smtp_1 htpasswd -c -B /data/etc/virtual/mydomain.com/passwd me
docker exec -it postfixvmpop3dalpine_smtp_1 htpasswd -B /data/etc/virtual/mydomain.com/passwd another
