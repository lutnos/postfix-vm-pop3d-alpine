docker exec -u vmail postfix-vm-pop3d mkdir -p /data/var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfix-vm-pop3d sh -c 'cat - > /data/etc/postfix/vmaildomains'
docker exec -t postfix-vm-pop3d postmap /data/etc/postfix/vmaildomains

echo another@mydomain.com mydomain.com/another |docker exec -i postfix-vm-pop3d sh -c 'cat - >/data/etc/postfix/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfix-vm-pop3d sh -c 'cat - >>/data/etc/postfix/vmailbox'
docker exec -t postfix-vm-pop3d postmap /data/etc/postfix/vmailbox

docker exec postfix-vm-pop3d mkdir -p /data/etc/virtual/mydomain.com
docker exec -it postfix-vm-pop3d htpasswd -c -B /data/etc/virtual/mydomain.com/passwd me
docker exec -it postfix-vm-pop3d htpasswd -B /data/etc/virtual/mydomain.com/passwd another
