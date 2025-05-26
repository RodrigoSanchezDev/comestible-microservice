# Etapa de compilación
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Etapa de ejecución
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copiamos el JAR
COPY --from=build /app/target/*.jar app.jar

# ¡Importante! Copiamos tu wallet a /wallet dentro del contenedor
COPY wallet /wallet

# Exponemos el puerto
EXPOSE 8080

# Arrancamos la app; el URL JDBC ya incluye TNS_ADMIN=/wallet
ENTRYPOINT ["java", "-jar", "app.jar"]
