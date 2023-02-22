FROM maven:3.8.5-ibm-semeru-17-focal as build
COPY . /home/app
WORKDIR /home/app
RUN mvn clean package

FROM openjdk:19-jdk-alpine3.15 as production
EXPOSE 3002:3002
COPY --from=build /home/app/target/movie-info-service.jar /opt/app/movie-info-service.jar
WORKDIR /opt/app
ENTRYPOINT ["java","-jar","movie-info-service.jar"]
