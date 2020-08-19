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

RUN cd /etc/ssl && \
    openssl genrsa -des3 -passout pass:pass -out server.pass.key 2048 && \
    openssl rsa -passin pass:pass -in server.pass.key -out private/server.key && \
    rm server.pass.key && \
    openssl req -new -key private/server.key -nodes -out server.csr \
            -subj "/C=UK/O=lutnos/OU=home/CN=lutnos.com" && \
    openssl x509 -req -days 3650 -in server.csr -signkey private/server.key -out certs/server.pem

RUN /usr/bin/newaliases

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]
