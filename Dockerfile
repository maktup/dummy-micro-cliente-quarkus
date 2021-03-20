## Stage 1 : build with maven builder image with native capabilities
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
USER root
RUN chown -R quarkus /usr/src/app
USER quarkus
RUN mvn -f /usr/src/app/pom.xml clean package


## Stage 2 : create the docker final image
FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /work/

ENV JAVA_OPTS=""

COPY --from=build /usr/src/app/target/*runner.jar /work/app.jar
RUN chmod 775 /work
EXPOSE 8080

#CMD ["./app.jar", "-Dquarkus.http.host=0.0.0.0"]
#ENTRYPOINT ["java","-jar","/work/app.jar"]
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /work/app.jar" ]

