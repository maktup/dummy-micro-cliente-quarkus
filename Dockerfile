############ STAGE:1 : build with maven builder image with native capabilities ############
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as CONSTRUCTOR

RUN mkdir -p /build 
WORKDIR /build
RUN chmod 777 /build
COPY src /build/src
COPY pom.xml /build
RUN mvn clean package

############ STAGE:2 : create the docker final image ############
FROM registry.access.redhat.com/ubi8/ubi-minimal as RUNTIME 
COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 
EXPOSE 8080
ENTRYPOINT [ "java -jar app.jar" ]
