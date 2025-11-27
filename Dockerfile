FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven descriptor
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# Pre-download dependencies
RUN mvn dependency:go-offline -B

# Copy project source
COPY src ./src

# Build shaded jar (fat jar)
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
