FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add openssl

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && \
    apk add stunnel

COPY etc /etc
RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

RUN mkdir -p /var/stunnel

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 995

ENTRYPOINT ["/entry.sh"]