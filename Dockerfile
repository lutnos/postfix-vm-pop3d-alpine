FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postfix && \
    mkdir -p /var/spool/postfix && \
    adduser -D -u 500 -G postfix -g postfix -h /var/spool/postfix -s /bin/false postfix && \
    addgroup -g 601 postdrop && \
    mkdir -p /data/var/spool/virtual && \
    adduser -D -u 501 -G postdrop -g vmail -h /data/var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /data/var/spool/virtual

RUN apk update && \
    apk add postfix rsyslog apache2-utils openssl

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && \
    apk add stunnel

RUN apk add wget gcc libc-dev make && \
    wget http://www.ibiblio.org/pub/Linux/system/mail/pop/vm-pop3d-1.1.6.tar.gz && \
    tar xzvf vm-pop3d-1.1.6.tar.gz && \
    cd vm-pop3d-1.1.6 && \
    ./configure --enable-virtual --prefix=/usr && \
    echo '#undef VIRTUAL_MAILPATH' >> vm-pop3d.h && \
    echo '#undef VIRTUAL_PASSWORDS_PATH' >>vm-pop3d.h && \
    echo '#define VIRTUAL_MAILPATH "/data/var/spool/virtual"' >> vm-pop3d.h && \
    echo '#define VIRTUAL_PASSWORDS_PATH "/data/etc/virtual"' >> vm-pop3d.h && \
    make install && \
    cd .. && \
    rm -rf vm-pop3d-1.1.6 && \
    rm vm-pop3d-1.1.6.tar.gz && \
    apk del --purge make libc-dev gcc wget && \
    rm /var/cache/apk/*

RUN echo virtual_mailbox_base = /data/var/spool/virtual >> /etc/postfix/main.cf && \
    echo virtual_mailbox_maps = hash:/data/etc/postfix/vmailbox >> /etc/postfix/main.cf && \
    echo virtual_mailbox_domains = hash:/data/etc/postfix/vmaildomains >> /etc/postfix/main.cf && \
    echo virtual_uid_maps = static:501 >> /etc/postfix/main.cf && \
    echo virtual_gid_maps = static:601 >> /etc/postfix/main.cf && \
    echo virtual_mailbox_lock = dotlock >> /etc/postfix/main.cf && \
    echo virtual_minimum_uid = 501 >> /etc/postfix/main.cf && \
    echo smtputf8_enable = no >> /etc/postfix/main.cf && \
    echo smtpd_tls_loglevel = 1 >> /etc/postfix/main.cf && \
    echo smtpd_tls_cert_file = /etc/ssl/certs/ssl-cert-snakeoil.pem >> /etc/postfix/main.cf && \
    echo smtpd_tls_key_file = /etc/ssl/private/ssl-cert-snakeoil.key >> /etc/postfix/main.cf && \
    echo "smtps     inet  n       -       n       -       -       smtpd" >> /etc/postfix/master.cf && \
    echo "  -o syslog_name=postfix/smtps" >> /etc/postfix/master.cf && \
    echo "  -o smtpd_tls_wrappermode=yes" >> /etc/postfix/master.cf && \
    echo "  -o smtpd_reject_unlisted_recipient=no" >> /etc/postfix/master.cf

ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           -e 's/\/var\/log\/maillog/\/data\/var\/log\/maillog/' \
           /etc/rsyslog.conf

RUN ls -lR /data && \
    mkdir -p /data/etc/virtual && \
    mkdir -p /data/etc/postfix && \
    mkdir -p /data/var/log && \
    mkdir -p /data/var/stunnel && \
    touch /data/var/log/stunnel.log && \
    ln -v /data/var/log/stunnel.log /data/var/stunnel/stunnel.log

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 0.7

VOLUME /data

EXPOSE 25 110 465 995

ENTRYPOINT ["/entry.sh"]