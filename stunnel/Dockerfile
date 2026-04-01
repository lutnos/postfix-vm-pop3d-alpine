FROM alpine:3.22.0 AS build

LABEL org.opencontainers.image.authors="Dave English <dave@lutnos.com>"

RUN apk update && apk update && \
    apk add gcc libc-dev make autoconf openssl stunnel patch

COPY src /src

RUN cd /src && \
    autoconf && \
    ./configure --prefix=/usr CFLAGS="-fcommon" --build=arm-linux && \
    make install

RUN mkdir -p /dist/etc/stunnel && cp /etc/stunnel/stunnel.conf /dist/etc/stunnel

COPY config /config

RUN patch -u -p 1 </config/diff/etc/stunnel/stunnel.conf.diff

RUN cd /etc/stunnel && \
    openssl genrsa -des3 -passout pass:pass -out server.pass.key 2048 && \
    openssl rsa -passin pass:pass -in server.pass.key -out server.key && \
    openssl req -new -key server.key -nodes -out server.csr \
            -subj "/CN=mail.lutnos.com" && \
    openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.pem

RUN mkdir -p /var/stunnel

FROM scratch
COPY --from=build /usr/bin/stunnel /usr/bin/
COPY --from=build /lib/ld-musl-aarch64.so.1 /lib/
COPY --from=build /usr/lib/libssl.so.3 /usr/lib/
COPY --from=build /usr/lib/libcrypto.so.3 /usr/lib/
COPY --from=build /etc/stunnel/server.pem /etc/stunnel/stunnel.conf /etc/stunnel/
COPY --from=build /usr/bin/execwait /usr/bin/
# only when calculating new configuration diff:
COPY --from=build /dist /dist/

VOLUME /etc/stunnel
VOLUME /var/stunnel

EXPOSE 995

ENTRYPOINT ["/usr/bin/execwait"]
