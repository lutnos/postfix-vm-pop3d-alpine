FROM alpine:3.18

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add openssl stunnel patch

RUN mkdir -p /dist && mkdir /dist/etc && mkdir /dist/etc/stunnel && cp /etc/stunnel/stunnel.conf /dist/etc/stunnel

COPY config /config

RUN patch -u -p 1 </config/diff/etc/stunnel/stunnel.conf.diff && rm -rf /diff && mkdir /etc/entry && mv /etc/stunnel/* /etc/entry && rmdir /etc/stunnel

RUN cd /etc/entry && \
    openssl genrsa -des3 -passout pass:pass -out server.pass.key 2048 && \
    openssl rsa -passin pass:pass -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -nodes -out server.csr \
            -subj "/CN=mail.lutnos.com" && \
    openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.pem && \
    rm server.csr && cat server.key server.pem >stunnel.pem && rm server.key && rm server.pem

RUN mkdir -p /var/stunnel

COPY sh /
RUN chmod +x /*.sh

EXPOSE 995

ENTRYPOINT ["/entry.sh"]
