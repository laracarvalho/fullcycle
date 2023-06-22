FROM golang:alpine as builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o main .

FROM scratch
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]