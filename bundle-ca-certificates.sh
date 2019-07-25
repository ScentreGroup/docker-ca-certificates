#!/bin/sh -e

touch /etc/ssl/certs/ca-certificates.crt
:> /etc/ssl/certs/ca-certificates.crt

for f in /usr/share/ca-certificates/mozilla/*.crt
do
  echo "add $f"
  cat "$f" >> /etc/ssl/certs/ca-certificates.crt
done
