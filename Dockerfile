FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && \
    apk add stunnel postfix rsyslog apache2-utils cyrus-sasl

RUN apk add wget gcc libc-dev make && \
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

ADD main.cf.extra /etc/postfix/main.cf.extra
RUN cat /etc/postfix/main.cf.extra >>/etc/postfix/main.cf
ADD stunnel.conf /etc/stunnel/stunnel.conf
ADD ssl-cert-snakeoil.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
ADD ssl-cert-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           -e 's/log\/maillog/virtual\/log\/maillog/' /etc/rsyslog.conf

RUN chmod 0400 /etc/ssl/private/ssl-cert-snakeoil.key

ADD mkvirtual.sh /mkvirtual.sh
RUN chmod +x /mkvirtual.sh && \
    touch /var/log/maillog && \
    mkdir -p /var/stunnel && \
    touch /var/stunnel/stunnel.log && \
    mkdir -p /virtual && \
    mkdir -p /var/spool/virtual && \
    /mkvirtual.sh

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh && \
    touch /tail.target

RUN echo 0.3

VOLUME /virtual

EXPOSE 25 465 110 995

ENTRYPOINT ["/entry.sh"]