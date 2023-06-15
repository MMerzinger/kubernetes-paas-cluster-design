FROM alpine:3.17

RUN apk update; apk add openssl && \
    openssl genrsa -out private.key 1024