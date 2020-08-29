FROM alpine:3.10

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog spamassassin spamassassin-compiler razor curl patch

RUN adduser -D spamd

COPY diff /diff

RUN patch -p 1 /etc/rsyslog.conf </diff/rsyslog.conf.diff

RUN mkdir /etc/volume && mv /etc/mail/spamassassin/local.cf /etc/volume && patch -p 1 /etc/volume/local.cf </diff/local.cf.diff

RUN patch -p 1 /etc/mail/spamassassin/v320.pre </diff/v320.pre.diff

RUN rm -rf /diff

RUN /usr/bin/sa-update -v
RUN /usr/bin/sa-compile

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

VOLUME /etc/tuning

EXPOSE 783

ENTRYPOINT ["/entry.sh"]
