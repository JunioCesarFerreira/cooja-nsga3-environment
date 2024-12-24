FROM gradle:8.5-jdk21

# Instalar dependências básicas
RUN apt-get update && apt-get install -y \
    build-essential \
    doxygen \
    git \
    git-lfs \
    curl \
    python3-serial \
    srecord \
    rlwrap \
    wget \
    software-properties-common \
    binutils-msp430 \
    gcc-msp430 \
    msp430-libc \
    mspdebug \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Baixar e instalar o msp430-gcc 4.7.2
RUN wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2 && \
    tar xjf mspgcc*.tar.bz2 -C /tmp/ && \
    cp -f -r /tmp/msp430/* /usr/local/ && \
    rm -rf /tmp/msp430 mspgcc*.tar.bz2

# Ajuste para compatibilidade 32 bits
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Configurar o OpenSSH
RUN mkdir /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Clonar o repositório Contiki-NG
WORKDIR /opt
RUN git clone --recursive https://github.com/contiki-ng/contiki-ng.git

# Compilar o Cooja
WORKDIR /opt/contiki-ng/tools/cooja
RUN ./gradlew build --no-daemon --stacktrace --info

# Configurar o diretório de trabalho para o Cooja
WORKDIR /opt/contiki-ng/tools/cooja

# Copiar o arquivo de simulação
COPY /simulation/simulation_config.xml sim-config.csc

# Expor portas
EXPOSE 22 60001 60002

# Forçar variável de ambiente para uso do java
RUN echo 'export PATH=$PATH:/opt/java/openjdk/bin' >> /root/.bashrc

# Iniciar o OpenSSH e manter o container ativo
CMD ["/usr/sbin/sshd", "-D"]
