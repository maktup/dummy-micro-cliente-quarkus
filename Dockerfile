
#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as CONSTRUCTOR

#1. CREA DIRECTORIO 'build' & 'src': 
WORKDIR /build
WORKDIR /build/src

USER root
RUN chown -R quarkus /build
RUN chmod 775 /build && chown -R 1001 /build && chmod -R "g+rwX" /build && chown -R 1001:root /build

COPY --chown=1001:root src /build/src
COPY --chown=1001:root pom.xml /build

#USER quarkus

#1. EJECUTAR 'MAVEN' (Directamente el: pom.xml):  
RUN mvn -f /build/pom.xml clean package


#//----------------------------------------------------------------//#
#//-------------------------  [EJECUCION] -------------------------//#
#//----------------------------------------------------------------//#
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as RUNTIME 

#7. DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#8. EXPONER PUERTO '8080': 
EXPOSE 8080


#18. COPIAR .JAR 'LOCALMENTE' DEL DIRECTORIO EN 'COMPILACION' :  
COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 

#USER 1001


RUN which java
RUN whereis java

#RUN JAVA_HOME='/usr/java/jdk11'
#RUN export JAVA_HOME
#RUN PATH="$JAVA_HOME/bin:$PATH"
#RUN export PATH
 
#RUN echo "ANTES =>: $PATH" 
#RUN PATH=/usr/local/jdk1.8.0/bin:$PATH
#RUN export PATH
#RUN echo "DESPUES =>: $PATH" 

ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]
