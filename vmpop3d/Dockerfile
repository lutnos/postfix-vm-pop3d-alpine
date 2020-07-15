FROM alpine:3.12

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postdrop && \
    mkdir -p /var/spool/virtual && \
    adduser -D -u 500 -G postdrop -g vmail -h /var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /var/spool/virtual

RUN apk update && \
    apk add apache2-utils rsyslog patch

COPY patches /

RUN apk update && \
    apk add wget gcc libc-dev make && \
    wget http://files.directadmin.com/services/da_vm-pop3d-1.1.7f.tar.gz && \
    tar xzvf da_vm-pop3d-1.1.7f.tar.gz && \
    cd da_vm-pop3d-1.1.7f && \
    patch -i /vm-pop3d.diff vm-pop3d.h && \
    patch -i /retr.diff retr.c && \
    patch -i /dele.diff dele.c && \
    rm /*.diff && \
    ./configure --enable-virtual --prefix=/usr && \
    make install && \
    cd .. && \
    rm -rf da_vm-pop3d-1.1.7f && \
    rm da_vm-pop3d-1.1.7f.tar.gz && \
    apk del --purge make libc-dev gcc wget && \
    rm /var/cache/apk/*

COPY diff /diff

RUN patch -p 1 /etc/rsyslog.conf </diff/rsyslog.conf.diff

RUN rm -rf /diff

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 110

ENTRYPOINT ["/entry.sh"]
