FROM docker.io/library/gradle:alpine-baselayout AS Builder
WORKDIR /app
COPY ./ /app/
RUN ./gradlew bootJar --no-daemon -x test

FROM docker.io/redhat/ubi9:latest
COPY --from=Builder /app/build/libs/portfolio-service.jar .
CMD ["java", "-jar", "./portfolio-service.jar"]
