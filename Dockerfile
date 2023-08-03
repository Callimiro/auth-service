FROM golang:1.19-alpine as builder 
# Create app directory
WORKDIR /app
# Copy go mod and sum files
COPY go.mod go.sum ./
# Download all dependencies
RUN go mod download
# Copy source code into the container
COPY . .

# Build the Go app
RUN go build -o auth-service ./main.go

FROM alpine:latest  

WORKDIR /app 

COPY --from=builder /app/auth-service ./

# Command to run the executable
CMD ["./auth-service"]



