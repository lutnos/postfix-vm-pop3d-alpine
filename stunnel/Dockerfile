FROM alpine:3.10

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add openssl stunnel

COPY diff /diff

RUN patch -p 1 /etc/stunnel/stunnel.conf </diff/stunnel.conf.diff

RUN rm -rf /diff

RUN cd /etc/ssl && \
    openssl genrsa -des3 -passout pass:pass -out server.pass.key 2048 && \
    openssl rsa -passin pass:pass -in server.pass.key -out private/server.key && \
    rm server.pass.key && \
    openssl req -new -key private/server.key -nodes -out server.csr \
            -subj "/C=UK/O=lutnos/OU=home/CN=lutnos.com" && \
    openssl x509 -req -days 3650 -in server.csr -signkey private/server.key -out certs/server.pem

RUN mkdir -p /var/stunnel

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 995

ENTRYPOINT ["/entry.sh"]
