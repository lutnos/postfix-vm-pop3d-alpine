FROM alpine:3.4

MAINTAINER Dave English <dave@lutnos.com>

RUN apk update && \
    apk add rsyslog spamassassin razor curl

RUN adduser -D -H spamd

COPY etc /etc
COPY share /usr/share/spamassassin

RUN /usr/bin/sa-update -v

RUN touch /var/log/messages

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh

RUN echo 1.1

EXPOSE 783

ENTRYPOINT ["/entry.sh"]