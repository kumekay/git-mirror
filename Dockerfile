FROM golang:1.17-alpine3.14 as builder
WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./
RUN go build -o /git-mirror

FROM alpine/git
WORKDIR /
COPY --from=builder /git-mirror git-mirror
ENTRYPOINT [ "/git-mirror" ]