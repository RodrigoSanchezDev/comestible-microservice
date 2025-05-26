# 1) build stage
FROM maven:3.8.7-eclipse-temurin-17 AS builder
WORKDIR /build

COPY pom.xml .
RUN mvn dependency:resolve

COPY src ./src
RUN mvn clean package -DskipTests

# 2) runtime stage
FROM eclipse-temurin:17-jre
WORKDIR /app

# tu fat-jar
COPY --from=builder /build/target/comestible-microservice-0.0.1-SNAPSHOT.jar app.jar

# los drivers Oracle + PKI
COPY oracle-drivers/*.jar /app/lib/

# ajusta el classpath
ENV CLASSPATH=/app/app.jar:/app/lib/*

EXPOSE 8080

ENTRYPOINT ["java","-cp","/app/app.jar:/app/lib/*","cl.duoc.comestible.ComestibleMicroserviceApplication"]
