FROM alpine:3.12

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add rsyslog postgrey perl-netaddr-ip patch
    
RUN mkdir /etc/volume && mv /etc/postfix/postgrey_whitelist_clients /etc/volume && \
    mv /etc/postfix/postgrey_whitelist_recipients /etc/volume

COPY diff /diff

RUN patch -p 1 /etc/rsyslog.conf </diff/rsyslog.conf.diff

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /etc/tuning

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]
