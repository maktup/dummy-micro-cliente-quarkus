## Stage 1 : build with maven builder image with native capabilities
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as CONSTRUCTOR
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
USER root
RUN chown -R quarkus /usr/src/app
USER quarkus
RUN mvn -f /usr/src/app/pom.xml clean package


## Stage 2 : create the docker final image
FROM registry.access.redhat.com/ubi8/ubi-minimal as RUNTIME 
#WORKDIR /work/

ENV JAVA_OPTS=""

COPY --from=CONSTRUCTOR /usr/src/app/target/*runner.jar app.jar
#RUN chmod 777 /work
EXPOSE 8080

#CMD ["./app.jar", "-Dquarkus.http.host=0.0.0.0"]
#ENTRYPOINT ["java","-jar","/work/app.jar"]
#ENTRYPOINT [ "java -Djava.security.egd=file:/dev/./urandom -jar app.jar" ]

ENTRYPOINT [ "java -jar app.jar" ]
