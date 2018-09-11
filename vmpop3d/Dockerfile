FROM alpine:3.8

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postdrop && \
    mkdir -p /var/spool/virtual && \
    adduser -D -u 500 -G postdrop -g vmail -h /var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /var/spool/virtual

RUN apk update && \
    apk add apache2-utils rsyslog

COPY patches /

RUN apk update && \
    apk add wget gcc libc-dev make && \
    wget http://www.ibiblio.org/pub/Linux/system/mail/pop/vm-pop3d-1.1.6.tar.gz && \
    tar xzvf vm-pop3d-1.1.6.tar.gz && \
    cd vm-pop3d-1.1.6 && \
    patch -i /vm-pop3d.diff vm-pop3d.h && \
    patch -i /retr.diff retr.c && \
    patch -i /dele.diff dele.c && \
    rm /*.diff && \
    ./configure --enable-virtual --prefix=/usr && \
    make install && \
    cd .. && \
    rm -rf vm-pop3d-1.1.6 && \
    rm vm-pop3d-1.1.6.tar.gz && \
    apk del --purge make libc-dev gcc wget && \
    rm /var/cache/apk/*

COPY etc /etc

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.2

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 110

ENTRYPOINT ["/entry.sh"]
