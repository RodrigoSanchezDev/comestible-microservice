# 1) STAGE: build with Maven
FROM maven:3.8.7-eclipse-temurin-17 as builder
WORKDIR /build

# copia sólo el pom para cachear dependencias
COPY pom.xml .
RUN mvn dependency:resolve

# copia el código y empaqueta
COPY src ./src
RUN mvn clean package -DskipTests

# 2) STAGE: runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# 2.1) Copya el fat-jar
COPY --from=builder /build/target/comestible-microservice-0.0.1-SNAPSHOT.jar app.jar

# 2.2) Copia manualmente los Oracle driver jars que no están en Maven Central

COPY oracle-drivers/ojdbc11.jar \
     oracle-drivers/oraclepki.jar \
     oracle-drivers/osdt_core.jar \
     oracle-drivers/osdt_cert.jar \
     /app/lib/

# 2.3) Configura el classpath para incluir todos
ENV CLASSPATH=/app/app.jar:/app/lib/*

EXPOSE 8080

# 2.4) Arranca la app
ENTRYPOINT ["java", "-cp", "/app/app.jar:/app/lib/*", "cl.duoc.comestible.ComestibleMicroserviceApplication"]
