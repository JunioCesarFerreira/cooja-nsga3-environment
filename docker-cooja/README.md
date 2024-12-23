# Docker-Cooja Example

This directory contains a Dockerfile designed for terminal-based testing. Its purpose is to validate configurations and dependencies required to set up a Docker image for running Cooja with a `.csc` file that contains simulation data.

## How to Use

1. **Build the Docker Image**  
   Navigate to this directory and run the following command to build the Docker image:

   ```sh
   docker build -t docker-cooja .
   ```

   Note: The first build may take a few minutes to complete.

2. **Run the Docker Container**  
   After the image is built, start the container by executing:

   ```sh
   docker run -it --rm docker-cooja
   ```

   This will launch an interactive session where you can execute commands within the container. Once you exit, the container will be automatically removed.

Feel free to modify the Dockerfile or add additional configurations as needed for your simulations.

## Log

*This section contains commands and links used during development.*

```sh
java -Xms4g -Xmx4g -jar build/libs/cooja.jar --no-gui test.csc
```

https://medium.com/@mirzaakhi/how-to-install-contikios-and-run-cooja-simulator-on-windows-11-with-oracle-vm-virtualbox-2691fce267af

https://slogix.in/source-code/contiki-cooja-samples-for-IoT/

```sh
apt-get update
apt-get install -y software-properties-common
```

```sh
apt-get install binutils-msp430 gcc-msp430 msp430-libc mspdebug
```

https://docs.contiki-ng.org/en/develop/doc/getting-started/Toolchain-installation-on-Linux.html

```sh
dpkg --add-architecture i386
apt-get update
apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
```

```sh
apt-get install -y zlib1g:i386
```

```sh
ls -l /lib/i386-linux-gnu/libz.so.1
```

```sh
java -jar build/libs/cooja.jar --version
```


