FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postdrop && \
    mkdir -p /var/spool/virtual && \
    adduser -D -u 500 -G postdrop -g vmail -h /var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /var/spool/virtual

RUN apk update && \
    apk add apache2-utils rsyslog

RUN apk update && \
    apk add wget gcc libc-dev make && \
    wget http://www.ibiblio.org/pub/Linux/system/mail/pop/vm-pop3d-1.1.6.tar.gz && \
    tar xzvf vm-pop3d-1.1.6.tar.gz && \
    cd vm-pop3d-1.1.6 && \
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

RUN echo 1.1

VOLUME /var/spool/virtual
VOLUME /etc/virtual

EXPOSE 110

ENTRYPOINT ["/entry.sh"]