FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog postgrey supervisor perl-netaddr-ip

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           /etc/rsyslog.conf && \
    touch /var/log/maillog

ADD supervisord.ini /etc/supervisord.d/supervisord.ini

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]