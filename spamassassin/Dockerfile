FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog spamassassin razor supervisor curl

RUN sed -i -e 's/\$ModLoad imklog.so/#\$ModLoad imklog.so/' \
           /etc/rsyslog.conf && \
    touch /var/log/maillog && \
    mkdir -p /etc/rsyslog.d
RUN echo '$IncludeConfig /etc/rsyslog.d/*.conf' >> /etc/rsyslog.conf

RUN mkdir -p /etc/virtual

COPY etc /etc/spamassassin
COPY share /usr/share/spamassassin
ADD supervisord.ini /etc/supervisord.d/supervisord.ini

RUN adduser -D -u 701 spamd
RUN /usr/bin/sa-update -v

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 783

ENTRYPOINT ["/entry.sh"]