FROM registry.access.redhat.com/ubi8/ubi-minimal:8.3
WORKDIR /build
RUN chown 1001 /build && chmod "g+rwX" /build && chown 1001:root /build
COPY target /build/target

EXPOSE 8080
USER 1001

CMD ["./target", "-Dquarkus.http.host=0.0.0.0"]
