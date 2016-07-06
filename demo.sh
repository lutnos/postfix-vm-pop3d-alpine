docker exec postfix-vm-pop3d mkdir -p /var/spool/virtual/mydomain.com
docker exec postfix-vm-pop3d chown vmail:postdrop /var/spool/virtual/mydomain.com
docker exec postfix-vm-pop3d chmod 0775 /var/spool/virtual/mydomain.com
echo mydomain.com placeholder |docker exec -i postfix-vm-pop3d sh -c 'cat - > /etc/postfix/vmaildomains'
docker exec -t postfix-vm-pop3d postmap /etc/postfix/vmaildomains
echo another@mydomain.com mydomain.com/another |docker exec -i postfix-vm-pop3d sh -c 'cat - >/etc/postfix/vmailbox'
echo @mydomain.com mydomain.com/me |docker exec -i postfix-vm-pop3d sh -c 'cat - >>/etc/postfix/vmailbox'
docker exec -t postfix-vm-pop3d postmap /etc/postfix/vmailbox
docker exec postfix-vm-pop3d mkdir -p /etc/virtual/mydomain.com
docker exec -it postfix-vm-pop3d htpasswd -c -d /etc/virtual/mydomain.com/passwd me
docker exec -it postfix-vm-pop3d htpasswd -d /etc/virtual/mydomain.com/passwd another
