FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog postgrey perl-netaddr-ip

COPY etc /etc

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 10023

ENTRYPOINT ["/entry.sh"]