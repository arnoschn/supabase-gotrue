FROM golang:1.20-alpine as build
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux
# implementing github workflow to build docker image
RUN apk add --no-cache make git

WORKDIR /go/src/github.com/arnoschn/gotrue

# Pulling dependencies
COPY ./Makefile ./go.* ./
RUN make deps

# Building stuff
COPY . /go/src/github.com/arnoschn/gotrue
RUN make build

FROM alpine:3.17
RUN adduser -D -u 1000 supabase

RUN apk add --no-cache ca-certificates
COPY --from=build /go/src/github.com/arnoschn/gotrue/gotrue /usr/local/bin/gotrue
COPY --from=build /go/src/github.com/arnoschn/gotrue/migrations /usr/local/etc/gotrue/migrations/

ENV GOTRUE_DB_MIGRATIONS_PATH /usr/local/etc/gotrue/migrations

USER supabase
CMD ["gotrue"]
