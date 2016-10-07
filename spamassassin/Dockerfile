FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog spamassassin razor curl

RUN touch /var/log/maillog

RUN mkdir -p /etc/virtual

ADD rsyslog.conf /etc/rsyslog.conf

COPY etc /etc/spamassassin
COPY share /usr/share/spamassassin

RUN adduser -D -u 701 spamd
RUN /usr/bin/sa-update -v

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 783

ENTRYPOINT ["/entry.sh"]