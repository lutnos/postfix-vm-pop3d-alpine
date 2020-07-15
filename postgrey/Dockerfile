FROM alpine:3.12

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog postgrey perl-netaddr-ip patch

RUN mkdir /e && cp -r /etc/* /e

COPY diff /diff

RUN patch -p 1 /etc/rsyslog.conf </diff/rsyslog.conf.diff

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]
