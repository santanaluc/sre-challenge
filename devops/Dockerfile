FROM maven:3.8.6-openjdk-11-slim as builder
# Environment Variable
ENV HOME=/usr/src/mvn
# Copy only app folder
COPY app/ $HOME/
# Build app
WORKDIR $HOME/
RUN mvn clean package && \
    mv target/app-0.0.1-SNAPSHOT.jar app.jar

# Multi-stage for better performance
FROM openjdk:18-ea-11-jdk-alpine3.15
# Environment Variable
ENV HOME=/usr/src/
# Copy from first stage the file app.jar
COPY --from=builder /usr/src/mvn/app.jar . 
# Parameters
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]
# Port
EXPOSE 8080