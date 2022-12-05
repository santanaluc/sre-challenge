FROM maven:3.8.6-openjdk-11-slim 
# Environment Variable
ENV HOME=/usr/src/mvn
# Copy only app folder
COPY app/ $HOME/
# Build app
WORKDIR $HOME/
RUN mvn clean package && \
    mv target/app-0.0.1-SNAPSHOT.jar app.jar
# Parameters
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]
# Port
EXPOSE 8080