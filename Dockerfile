FROM openjdk:8-jdk-alpine
VOLUME /user/shape
COPY shape.jar /user/shape/app.jar
ENTRYPOINT ["java","-jar","/user/shape/app.jar"]
