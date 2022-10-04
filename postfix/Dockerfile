FROM alpine:3.18.3

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add postfix rsyslog openssl spamassassin-client patch

RUN adduser -D -H spamc

RUN mkdir -p /dist && mkdir /dist/etc && mkdir /dist/etc/postfix && cp /etc/rsyslog.conf /dist/etc && cp /etc/postfix/main.cf /dist/etc/postfix && cp /etc/postfix/master.cf /dist/etc/postfix

COPY config /config

RUN patch -u -p 1 </config/diff/etc/rsyslog.conf.diff && patch -u -p 1 </config/diff/etc/postfix/main.cf.diff && patch -u -p 1 </config/diff/etc/postfix/master.cf.diff && rm -rf /diff

RUN cd /etc/ssl && \
    openssl genrsa -des3 -passout pass:pass -out server.pass.key 2048 && \
    openssl rsa -passin pass:pass -in server.pass.key -out private/server.key && \
    rm server.pass.key && \
    openssl req -new -key private/server.key -nodes -out server.csr \
            -subj "/C=UK/O=lutnos/OU=home/CN=lutnos.com" && \
    openssl x509 -req -days 3650 -in server.csr -signkey private/server.key -out certs/server.pem

RUN /usr/bin/newaliases

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 25 465

ENTRYPOINT ["/entry.sh"]
