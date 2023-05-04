FROM alpine:3.17

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && apk upgrade && \
    apk add rsyslog spamassassin spamassassin-compiler razor curl gpg-agent patch

RUN adduser -D spamd

RUN mkdir -p /dist && mkdir /dist/etc && mkdir /dist/etc/mail && mkdir /dist/etc/mail/spamassassin && cp /etc/rsyslog.conf /dist/etc && cp /etc/mail/spamassassin/local.cf /dist/etc/mail/spamassassin && cp /etc/mail/spamassassin/v320.pre /dist/etc/mail/spamassassin

COPY config /config

RUN patch -u -p 1 </config/diff/etc/rsyslog.conf.diff && patch -u -p 1 </config/diff/etc/mail/spamassassin/local.cf.diff && patch -u -p 1 </config/diff/etc/mail/spamassassin/v320.pre.diff && mkdir /etc/volume && mv /etc/mail/spamassassin/local.cf /etc/volume

RUN /usr/bin/sa-update -v
RUN /usr/bin/sa-compile

RUN touch /var/log/messages

COPY sh /
RUN chmod +x /*.sh

VOLUME /etc/tuning

EXPOSE 783

ENTRYPOINT ["/entry.sh"]
