FROM golang:1.24-bullseye AS build

ENV GOTOOLCHAIN=local
ENV GOENV=off
ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH

RUN rm -rf /go/toolchains || true
RUN rm -rf /root/.cache/go-build || true

WORKDIR /develop
COPY . .

RUN go clean -modcache
RUN go mod tidy

RUN go version
RUN go env | grep -E "GO|GOROOT|GOTOOLD"

RUN grep -R "package errors" -n /go/pkg/mod | head -n 50
RUN go build -o docker-flow-swarm-listener -ldflags "-w"

