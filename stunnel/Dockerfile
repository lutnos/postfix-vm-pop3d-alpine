FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add openssl

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && \
    apk add stunnel

ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN mkdir -p /data/var/log && \
    mkdir -p /data/var/stunnel && \
    touch /data/var/log/stunnel.log && \
    ln -v /data/var/log/stunnel.log /data/var/stunnel/stunnel.log

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 0.8

VOLUME /data

EXPOSE 995

ENTRYPOINT ["/entry.sh"]