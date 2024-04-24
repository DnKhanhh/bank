# Build stage
FROM golang:1.22-alpine3.19 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.0/migrate.linux-amd64.tar.gz | tar xvz


# Run stage
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY start.sh .
COPY db/migration ./migration

EXPOSE 8082

#CMD set -e && echo "Running database migration..." && echo "DB_SOURCE before: $DB_SOURCE" && source /app/app.env && echo "DB_SOURCE after: $DB_SOURCE" && /app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up && echo "Database migration complete." && /app/main
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]

