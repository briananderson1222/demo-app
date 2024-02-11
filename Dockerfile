# Use a base image with Java 21
FROM adoptopenjdk/openjdk21:alpine-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file of your Java application into the container
COPY build/libs/demo-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port that your application listens on (if necessary)
# EXPOSE <port>

# Command to run your application
CMD ["java", "-jar", "app.jar"]