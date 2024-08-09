FROM alpine:3.20.2

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk update && \
    apk add rsyslog perl perl-net-dns perl-net-server perl-io-multiplex perl-net-rblclient perl-parse-syslog perl-netaddr-ip patch

RUN apk add wget gcc libc-dev perl-dev db-dev make && \
    wget https://cpan.metacpan.org/authors/id/P/PM/PMQS/BerkeleyDB-0.65.tar.gz && \
    tar xzvf BerkeleyDB-0.65.tar.gz && \
    cd BerkeleyDB-0.65 && \
    export CFLAGS=$(perl -MConfig -E 'say $Config{ccflags}') && \
    perl Makefile.PL && \
    make && \
    make install && \
    cd .. && \
    rm -rf BerkeleyDB-0.65 && \
    rm BerkeleyDB-0.65.tar.gz && \
    wget https://postgrey.schweikert.ch/pub/postgrey-1.37.tar.gz && \
    tar xzvf postgrey-1.37.tar.gz && \
    cd postgrey-1.37 && \
    cp postgrey /usr/sbin && \
    chmod 0755 /usr/sbin/postgrey && \
    mkdir -p /var/spool/postfix/postgrey && \
    addgroup -S postgrey && \
    adduser -S -D -H -h /dev/null -s /sbin/nologin -G postgrey -g postgrey postgrey && \
 	chown postgrey:postgrey /var/spool/postfix/postgrey && \
 	chmod 770 /var/spool/postfix/postgrey && \
    mkdir -p /etc/postfix && \
    chmod 0644 /etc/postfix && \
    cp postgrey_whitelist_recipients /etc/postfix && \
    chmod 0644 /etc/postfix/postgrey_whitelist_recipients && \
    wget https://postgrey.schweikert.ch/pub/postgrey_whitelist_clients && \
    cp postgrey_whitelist_clients /etc/postfix && \
    chmod 0644 /etc/postfix/postgrey_whitelist_clients && \
    cd .. && \
    rm -rf postgrey-1.37 && \
    rm postgrey-1.37.tar.gz && \
    apk del --purge make perl-dev db-dev libc-dev gcc wget && \
    rm /var/cache/apk/*

RUN mkdir /etc/volume && mv /etc/postfix/postgrey_whitelist_clients /etc/volume && \
    mv /etc/postfix/postgrey_whitelist_recipients /etc/volume

RUN mkdir -p /dist && mkdir /dist/etc && cp /etc/rsyslog.conf /dist/etc

COPY config /config

RUN patch -u -p 1 </config/diff/etc/rsyslog.conf.diff && rm -rf /diff

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /etc/tuning

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]
