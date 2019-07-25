FROM alpine as builder
COPY bundle-ca-certificates.sh /usr/local/bin/
RUN apk add --no-cache --update ca-certificates && \
      /usr/local/bin/bundle-ca-certificates.sh

FROM scratch
COPY --from=builder /usr/share/ca-certificates /usr/share/ca-certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt \
      /etc/ssl/certs/ca-certificates.crt
