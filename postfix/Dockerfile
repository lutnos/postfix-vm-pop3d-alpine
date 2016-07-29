FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add postfix rsyslog openssl

RUN echo virtual_mailbox_base = /var/spool/virtual >> /etc/postfix/main.cf && \
    echo virtual_mailbox_maps = hash:/etc/virtual/vmailbox >> /etc/postfix/main.cf && \
    echo virtual_mailbox_domains = hash:/etc/virtual/vmaildomains >> /etc/postfix/main.cf && \
    echo virtual_uid_maps = static:500 >> /etc/postfix/main.cf && \
    echo virtual_gid_maps = static:600 >> /etc/postfix/main.cf && \
    echo virtual_mailbox_lock = dotlock >> /etc/postfix/main.cf && \
    echo virtual_minimum_uid = 500 >> /etc/postfix/main.cf && \
    echo smtputf8_enable = no >> /etc/postfix/main.cf && \
    echo smtpd_tls_loglevel = 1 >> /etc/postfix/main.cf && \
    echo smtpd_tls_cert_file = /etc/ssl/certs/ssl-cert-snakeoil.pem >> /etc/postfix/main.cf && \
    echo smtpd_tls_key_file = /etc/ssl/private/ssl-cert-snakeoil.key >> /etc/postfix/main.cf && \
    echo "smtps     inet  n       -       n       -       -       smtpd" >> /etc/postfix/master.cf && \
    echo "  -o syslog_name=postfix/smtps" >> /etc/postfix/master.cf && \
    echo "  -o smtpd_tls_wrappermode=yes" >> /etc/postfix/master.cf && \
    echo "  -o smtpd_reject_unlisted_recipient=no" >> /etc/postfix/master.cf

ADD ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           /etc/rsyslog.conf && \
    touch /var/log/maillog

RUN mkdir -p /etc/virtual

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 0.9

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]