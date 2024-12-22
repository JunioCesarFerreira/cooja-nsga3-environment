FROM gradle:8.5-jdk21

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --recursive https://github.com/contiki-ng/contiki-ng.git

WORKDIR /opt/contiki-ng/tools/cooja
RUN ./gradlew build --no-daemon --stacktrace --info

WORKDIR /opt/contiki-ng/tools/cooja

COPY simulation/test.xml test.csc

EXPOSE 60001 60002

# Ponto de entrada
ENTRYPOINT ["java", "-Xms4g", "-Xmx4g", "-jar", "build/libs/cooja.jar", "--no-gui", "test.csc"]