############ STAGE:1 : build with maven builder image with native capabilities ############
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as CONSTRUCTOR

WORKDIR /build
WORKDIR /build/src

USER root
RUN chown -R quarkus /build
RUN chmod 775 /build && chown -R 1001 /build && chmod -R "g+rwX" /build && chown -R 1001:root /build

COPY --chown=1001:root src /build/src
COPY --chown=1001:root pom.xml /build

USER quarkus
RUN mvn clean package

############ STAGE:2 : create the docker final image ############
FROM registry.access.redhat.com/ubi8/ubi-minimal as RUNTIME 

COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 
EXPOSE 8080
USER 1001

ENTRYPOINT [ "java -jar app.jar" ]
#CMD ["java","-jar","./app.jar"]
