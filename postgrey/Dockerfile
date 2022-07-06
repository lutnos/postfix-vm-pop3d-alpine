FROM alpine:3.16

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add rsyslog perl perl-db perl-net-dns perl-net-server perl-io-multiplex\
            perl-net-rblclient perl-parse-syslog perl-netaddr-ip patch

RUN apk add wget && \
    wget https://postgrey.schweikert.ch/pub/postgrey-1.37.tar.gz && \
    apk del --purge wget && \
    rm /var/cache/apk/*

RUN tar xzvf postgrey-1.37.tar.gz && \
    rm postgrey-1.37.tar.gz && \
    cp postgrey-1.37/postgrey /usr/sbin && \
    cp postgrey-1.37/postgreyreport /usr/sbin && \
    mkdir /etc/volume && \
    cp postgrey-1.37/postgrey_whitelist_clients /etc/volume && \
    cp postgrey-1.37/postgrey_whitelist_recipients /etc/volume && \
    rm -rf postgrey-1.37

RUN addgroup -S postgrey && \
    mkdir -p /var/spool/postfix/postgrey && chown postgrey:postgrey /var/spool/postfix/postgrey && chmod 770 /var/spool/postfix/postgrey && \
    chmod 644 /etc/volume/postgrey_whitelist_clients && ln -s /etc/volume/postgrey_whitelist_clients /etc/postfix && \
    chmod 644 /etc/volume/postgrey_whitelist_recipients && ln -s /etc/volume/postgrey_whitelist_recipients /etc/postfix

COPY src /

RUN cp /src/postgrey.initd /etc/init.d && chmod 0755 /etc/init/d/postgrey && \
    cp /src/postgrey.confd /etc/conf.d && chmod 644 /etc/conf.d/postgrey.confd && \
    rm -rf /src

RUN mkdir -p /dist && mkdir /dist/etc && cp /etc/rsyslog.conf /dist/etc

COPY config /config

RUN patch -p 1  </config/diff/etc/rsyslog.conf.diff && rm -rf /diff

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /etc/tuning

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]
