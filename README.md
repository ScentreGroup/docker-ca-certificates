# docker-ca-certificates

This image is intended for programs that use a distroless
`FROM` image (such as `scratch`) and use
`/etc/ssl/certs/ca-certificates.crt` as the trusted CA bundle.

Physically, it does not appear possible to copy a symlink to a scratch docker image.
For that reason we do not provide all the files checked in
https://golang.org/src/crypto/x509/root_linux.go as to not duplicate the CA bundle file.

The intent is to trust Alpine's `ca-certificates` package.
This should be kept up-to-date inline with upstream trust from Mozilla.
We can look at whether an alternate trust source such as Debian/GNU or Google
is a better option (feel free to raise a GitHub issue for discussion).

## Usage

Basic pattern for a `scratch` based image, assuming locally pre-built binary:

```
FROM scentregroup/ca-certificates as certs

FROM scratch
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY ./myclient /myclient
CMD ["/myclient"]
```

## Testing

Integration testing:

`make docker-test`

## License & Copyright

- Author: Chris Fordham (<chris@fordham.id.au>)

```text
Copyright 2019, Scentre Limited

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
