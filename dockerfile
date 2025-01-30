FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /practicum_sprint_12_project

FROM alpine:latest

COPY --from=builder /practicum_sprint_12_project /practicum_sprint_12_project
COPY tracker.db /tracker.db

CMD ["/practicum_sprint_12_project"]