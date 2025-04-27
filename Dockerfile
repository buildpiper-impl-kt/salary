FROM maven:3.6.3-openjdk-17 AS builder

WORKDIR /workspace

COPY pom.xml .
COPY src/ src/

RUN mvn clean package -DskipTests

FROM alpine:3.18.0

RUN apk update && \
    apk add openjdk17

COPY --from=builder /workspace/target/salary-0.1.0-RELEASE.jar /app/salary.jar
EXPOSE 8080
ENTRYPOINT ["/usr/bin/java", "-jar", "/app/salary.jar"]
