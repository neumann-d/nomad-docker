FROM alpine:3.7

ENV NOMAD_VERSION=0.8.6

RUN apk update \
 && apk add -t build go1.10 make musl-dev bash git \
 && apk add ca-certificates \
 && wget https://github.com/hashicorp/nomad/archive/v$NOMAD_VERSION.tar.gz -O /tmp/nomad.tar.gz \
 && mkdir -p /go/src/github.com/hashicorp/nomad/ \
 && tar xvf /tmp/nomad.tar.gz --strip-components 1 -C /go/src/github.com/hashicorp/nomad/ \
 && cd /go/src/github.com/hashicorp/nomad/ \
 && GOPATH=/go make GO_TAGS=ui pkg/linux_amd64/nomad \
 && mv /go/src/github.com/hashicorp/nomad/pkg/linux_amd64/nomad /usr/bin/ \
 && rm -rf /go /tmp/nomad.tar.gz /root/.cache \
 && apk del build 

ENTRYPOINT ["nomad"]
