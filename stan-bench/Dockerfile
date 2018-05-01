FROM alpine:latest
RUN apk --no-cache add ca-certificates

FROM scratch
WORKDIR /root
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY stan-bench /
ENTRYPOINT [ "/stan-bench" ]
