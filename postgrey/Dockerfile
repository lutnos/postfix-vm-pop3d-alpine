FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog postgrey perl-netaddr-ip

RUN touch /var/log/maillog

ADD rsyslog.conf /etc/rsyslog.conf

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]