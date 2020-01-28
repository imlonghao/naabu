# Build Container
FROM golang:1.13.4-alpine3.10 AS build-env
MAINTAINER Ice3man (nizamul@projectdiscovery.io)
RUN apk add --no-cache build-base libpcap-dev
COPY . /builder
WORKDIR /builder/cmd/naabu
RUN go build -o /naabu

FROM alpine:3.10
RUN apk add --no-cache libpcap-dev
COPY --from=build-env /naabu /naabu
ENTRYPOINT ["/naabu"]