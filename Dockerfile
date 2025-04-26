# First stage: build
FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk maven
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Second stage: run
FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
