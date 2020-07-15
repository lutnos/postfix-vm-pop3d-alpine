FROM alpine:3.12

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add postfix rsyslog openssl spamassassin-client patch

RUN adduser -D -H spamc

COPY diff /diff

RUN patch -p 1 /etc/rsyslog.conf </diff/rsyslog.conf.diff
RUN patch -p 1 /etc/postfix/main.cf </diff/main.cf.diff
RUN patch -p 1 /etc/postfix/master.cf </diff/master.cf.diff

RUN rm -rf /diff

COPY new /

RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN /usr/bin/newaliases

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]
