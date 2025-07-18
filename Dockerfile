# ------------ BUILD STAGE ------------
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ------------ RUNTIME STAGE ------------
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/discovery-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]
