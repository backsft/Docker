# Build Stage
FROM gradle:8.7.0-jdk21 AS builder
COPY --chown=gradle:gradle . /home/gradle/project
WORKDIR /home/gradle/project
RUN gradle bootJar

# Run Stage
FROM openjdk:21-jdk-slim
VOLUME /tmp
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
