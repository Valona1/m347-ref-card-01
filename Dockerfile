# Java 17 schlankes Image
FROM eclipse-temurin:17-jdk-alpine

# Arbeitsverzeichnis
WORKDIR /app

# Maven-Build erzeugt später eine JAR --> wir kopieren die JAR ins Image
COPY target/*.jar app.jar

# Port freigeben
EXPOSE 8080

# Java-App starten
ENTRYPOINT ["java","-jar","/app/app.jar"]
