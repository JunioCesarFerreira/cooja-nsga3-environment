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
COPY simulation/cenario_6x6_15min.xml /opt/contiki-ng/metrica/cenario_6x6_15min.csc

# Expor as portas necessárias (caso precise usá-las depois)
EXPOSE 60001 60002

# Definir o comando padrão como bash, assim quando rodar o contêiner interativamente você terá acesso ao shell
CMD ["/bin/bash"]

#ENTRYPOINT ["java", "-Xms4g", "-Xmx4g", "-jar", "build/libs/cooja.jar", "-nogui=/opt/contiki-ng/metrica/cenario_6x6_15min.csc", "-contiki=/opt/contiki-ng"]