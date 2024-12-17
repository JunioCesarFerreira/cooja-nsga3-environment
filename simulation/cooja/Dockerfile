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

# Navegar para a pasta do Cooja
WORKDIR /opt/contiki-ng/tools/cooja

# Copiar o script de simulação
COPY simulation/test.xml test.csc

# Expor as portas necessárias (caso precise usá-las depois)
EXPOSE 60001 60002

ENTRYPOINT ["java", "-Xms4g", "-Xmx4g", "-jar", "build/libs/cooja.jar", "-nogui=true", "test.csc"]