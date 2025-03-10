FROM golang:1.20-alpine AS build-env

ENV PACKAGES make git

RUN apk add --no-cache $PACKAGES

WORKDIR /go/src/github.com/strangelove-ventures/horcrux

ADD . .

RUN make build

FROM alpine:edge

RUN apk add --no-cache ca-certificates

WORKDIR /root

COPY --from=build-env /go/src/github.com/strangelove-ventures/horcrux/build/horcrux  /usr/bin/horcrux

CMD ["horcrux"]
