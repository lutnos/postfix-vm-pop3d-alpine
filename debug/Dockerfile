FROM alpine:3.23.0

LABEL org.opencontainers.image.authors="Dave English <dave@lutnos.com>"

RUN apk update && apk upgrade

COPY sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entry.sh"]