FROM registry.cn-hangzhou.aliyuncs.com/alisre/sreworks-base AS build
COPY . /app
WORKDIR /app
COPY settings.xml /root/.m2/settings.xml
RUN mvn -Dmaven.test.skip=true clean package

FROM registry.cn-hangzhou.aliyuncs.com/alisre/openjdk:11.0.10-jre AS release
USER root
WORKDIR /root
COPY --from=build /app/app-start/target/app.jar /app/app.jar
ENTRYPOINT ["java", "-Xmx1g", "-Xms1g", "-XX:ActiveProcessorCount=2", "-jar", "/app/app.jar"]