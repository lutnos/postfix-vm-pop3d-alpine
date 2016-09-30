FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add postfix rsyslog openssl spamassassin-client

ADD ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' /etc/rsyslog.conf && \
    touch /var/log/maillog

COPY postfix /etc/postfix

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]