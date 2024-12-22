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
