# syntax=docker/dockerfile:1

FROM golang:1.16-alpine as build_base

WORKDIR /usr/src/app

RUN go mod init go-lang
RUN go mod download

COPY fullcycle.go .

RUN go build -o ./go-fullcycle

FROM scratch
WORKDIR /usr/src/app

COPY --from=build_base /usr/src/app/* /usr/src/app/

ENTRYPOINT [ "./go-fullcycle" ]