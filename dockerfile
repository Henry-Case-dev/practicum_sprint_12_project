FROM golang:1.22.4 AS builder

WORKDIR /app

COPY go.mod go.sum ./

# Установить прокси на случай проблем с зависимостями
ENV GOPROXY=https://proxy.golang.org,direct

RUN go clean -modcache && go mod download || { echo "go mod download failed with exit code $?"; exit 1; }

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /practicum_sprint_12_project

FROM alpine:latest

COPY --from=builder /practicum_sprint_12_project /practicum_sprint_12_project
COPY tracker.db /tracker.db

CMD ["/practicum_sprint_12_project"]
