FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN addgroup -g 600 postfix && \
    mkdir -p /var/spool/postfix && \
    adduser -D -u 500 -G postfix -g postfix -h /var/spool/postfix -s /bin/false postfix && \
    addgroup -g 601 postdrop && \
    mkdir -p /data/var/spool/virtual && \
    adduser -D -u 501 -G postdrop -g vmail -h /data/var/spool/virtual -s /sbin/nologin vmail && \
    chown vmail:postdrop /data/var/spool/virtual

RUN apk update && \
    apk add rsyslog

RUN apk update && \
    apk add wget gcc libc-dev make && \
    wget http://www.ibiblio.org/pub/Linux/system/mail/pop/vm-pop3d-1.1.6.tar.gz && \
    tar xzvf vm-pop3d-1.1.6.tar.gz && \
    cd vm-pop3d-1.1.6 && \
    ./configure --enable-virtual --prefix=/usr && \
    echo '#undef VIRTUAL_MAILPATH' >> vm-pop3d.h && \
    echo '#undef VIRTUAL_PASSWORDS_PATH' >>vm-pop3d.h && \
    echo '#define VIRTUAL_MAILPATH "/data/var/spool/virtual"' >> vm-pop3d.h && \
    echo '#define VIRTUAL_PASSWORDS_PATH "/data/etc/virtual"' >> vm-pop3d.h && \
    make install && \
    cd .. && \
    rm -rf vm-pop3d-1.1.6 && \
    rm vm-pop3d-1.1.6.tar.gz && \
    apk del --purge make libc-dev gcc wget && \
    rm /var/cache/apk/*

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           /etc/rsyslog.conf

RUN mkdir -p /data/etc/virtual

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 0.8

VOLUME /data

EXPOSE 110

ENTRYPOINT ["/entry.sh"]