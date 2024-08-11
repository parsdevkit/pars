FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY src/ .

RUN go build -o pars ./src/pars.go

FROM scratch

COPY --from=builder /app/pars /pars

ENTRYPOINT ["/pars"]
