FROM registry.access.redhat.com/ubi8/ubi-minim
WORKDIR /build
COPY target/quarkus-app/* /build/src
RUN chmod 775 /build
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
