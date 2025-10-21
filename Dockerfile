# ---- Build stage: JAR üret ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY . .
# WebGoat çok modüllü, sunucu modülü 'webgoat-server'
RUN mvn -q -DskipTests -pl webgoat-server -am package

# ---- Runtime stage: hafif JRE ile çalıştır ----
FROM eclipse-temurin:17-jre
WORKDIR /app
# Üretilen jar'ı al ve tek bir isimle kopyala
COPY --from=build /src/webgoat-server/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
