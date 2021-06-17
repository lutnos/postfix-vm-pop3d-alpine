FROM alpine:3.14

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add rsyslog postgrey perl-netaddr-ip patch
    
RUN mkdir /etc/volume && mv /etc/postfix/postgrey_whitelist_clients /etc/volume && \
    mv /etc/postfix/postgrey_whitelist_recipients /etc/volume

RUN mkdir -p /dist && mkdir /dist/etc && cp /etc/rsyslog.conf /dist/etc

COPY config /config

RUN patch -p 1  </config/diff/etc/rsyslog.conf.diff && rm -rf /diff

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /etc/tuning

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]
