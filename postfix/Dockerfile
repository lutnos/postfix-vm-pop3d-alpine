FROM alpine:3.8

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add postfix rsyslog openssl spamassassin-client

RUN adduser -D -H spamc

COPY etc /etc
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN /usr/bin/newaliases

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.2

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]