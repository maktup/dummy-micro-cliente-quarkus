#-------------- [PESOS DE IMAGENES] -----------#
#  maven:3-jdk-8                        500MB 
#  maven:3-jdk-8-alpine                 122MB 
#  openjdk:8                            488MB
#  openjdk:8-slim                       284MB
#  openjdk:8-alpine                     105MB
#  openjdk:8-jdk-slim                   284MB 
#  openjdk:8-jdk-alpine                 105MB 
#  adoptopenjdk/openjdk8:alpine-slim    90.2MB
#  oracle/graalvm-ce                    1.7GB [PARA QUE FUNCIONE CON 'graalvm-ce']
#  findepi/graalvm                      968MB [PARA QUE FUNCIONE CON 'graalvm-ce']
#-------------- [PESOS DE IMAGENES] -----------#

#---------> [VERSION-MANEJADA: V4.0]#

#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
#FROM maven:3-jdk-8-alpine as CONSTRUCTOR 
FROM findepi/graalvm as CONSTRUCTOR 

#1. CREA DIRECTORIO 'build':  
RUN mkdir -p /build

#2. DEFINIR UBICACION: 
WORKDIR /build

#3. COPIAR 'pom.xml' A DIRECTORIO 'build': 
COPY pom.xml /build

#4. DESCARGAR DEPENDENCIAS 'MAVEN': 
RUN mvn -B dependency:resolve dependency:resolve-plugins

#5. COPIAR 'src' A DIRECTORIO '/build/src': 
COPY src /build/src

#6. EJECUTAR 'MAVEN': 
RUN mvn clean package


#//----------------------------------------------------------------//#
#//-------------------------  [EJECUCION] -------------------------//#
#//----------------------------------------------------------------//#
#FROM adoptopenjdk/openjdk8:alpine-slim as RUNTIME
FROM findepi/graalvm as RUNTIME 

#7. DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#8. EXPONER PUERTO '8080': 
EXPOSE 8080

#9. CREAR 'VARIABLE DE ENTORNO' 'APP_HOME': 
ENV APP_HOME /app


#10. CREAR 'VARIABLE DE ENTORNO' [ADICIONALES], PARA EL 'MICROSERVICIO': 
#--------------------------------------------------------------------------------------------#
ENV NOMBRE_MICROSERVICIO=dummy-micro-cliente
#--------------------------------------------------------------------------------------------#


#11. CREAR 'VARIABLE DE ENTORNO' 'JAVA_OPTS':  
ENV JAVA_OPTS=""

#12. CREANDO DIRECTORIO 'BASE': 
RUN mkdir $APP_HOME

#13. CREANDO DIRECTORIO PARA 'ARCHIVOS DE CONFIGURACION': 
RUN mkdir $APP_HOME/config

#14. CREANDO DIRECTORIO PARA 'LOGs': 
RUN mkdir $APP_HOME/log

#15. CREANDO 'VOLUME' PARA 'ARCHIVOS DE CONFIGURACION': 
VOLUME $APP_HOME/config

#16. CREANDO 'VOLUME' PARA 'LOGs':  
VOLUME $APP_HOME/log


#17. CREANDO 'VARIABLE DE ENTORNO' PARA 'VOLUME' DE 'LOGs' PARA EL 'MICROSERVICIO':
#--------------------------------------------------------------------#
ENV RUTA_LOG=$APP_HOME/log
#--------------------------------------------------------------------#


#18. COPIAR .JAR DE LA IMAGEN:  
COPY --from=CONSTRUCTOR /build/target/quarkus-app/*.jar app.jar

#19. INSTALANDO 'SUDO, NANO, CURL':
RUN apk add -u sudo 
RUN apk add -u nano
RUN apk add -u curl

#20. EJECUTAR 'JAR': 
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar" ]

