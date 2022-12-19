FROM alpine:3.16

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postdrop && \
    mkdir -p /var/spool/virtual && \
    adduser -D -u 500 -G postdrop -g vmail -h /var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /var/spool/virtual

RUN apk update && apk update && \
    apk add apache2-utils rsyslog patch

COPY patches /

COPY tar /

RUN apk update && \
    apk add gcc libc-dev make && \
    tar xzvf /da_vm-pop3d-1.1.7f.tar.gz && \
    cd da_vm-pop3d-1.1.7f && \
    patch -i /vm-pop3d.diff vm-pop3d.h && \
    patch -i /retr.diff retr.c && \
    patch -i /dele.diff dele.c && \
    rm /*.diff && \
    ./configure --enable-virtual --prefix=/usr CFLAGS="-fcommon" && \
    make install && \
    cd .. && \
    rm -rf da_vm-pop3d-1.1.7f && \
    rm da_vm-pop3d-1.1.7f.tar.gz && \
    apk del --purge make libc-dev gcc wget && \
    rm /var/cache/apk/*

RUN mkdir -p /dist && mkdir /dist/etc && cp /etc/rsyslog.conf /dist/etc

COPY config /config

RUN patch -p 1  </config/diff/etc/rsyslog.conf.diff && rm -rf /diff

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 110

ENTRYPOINT ["/entry.sh"]
