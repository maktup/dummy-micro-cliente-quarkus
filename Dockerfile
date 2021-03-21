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
RUN mvn -f /build/pom.xml clean package

############ STAGE:2 : create the docker final image ############
## FROM registry.access.redhat.com/ubi8/ubi-minimal as RUNTIME 
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as RUNTIME 

COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 
EXPOSE 8080
USER 1001

#RUN java -version
RUN which java
RUN whereis java

RUN JAVA_HOME='/usr/java/jdk11'
RUN export JAVA_HOME
RUN PATH="$JAVA_HOME/bin:$PATH"
RUN export PATH
 
RUN echo "ANTES =>: $PATH" 
RUN PATH=/usr/local/jdk1.8.0/bin:$PATH
RUN export PATH
RUN echo "DESPUES =>: $PATH" 

#ENTRYPOINT [ "java", "-jar", "app.jar" ]
CMD ["java", "-jar", "app.jar"]
