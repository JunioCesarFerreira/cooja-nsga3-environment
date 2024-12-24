# Cooja Simulation Environment

This directory provides a Docker-based setup for running **Cooja simulations** with a multi-container architecture, including services for simulation data processing using Python and MySQL.

## Features

- **Cooja Simulator**: Contiki-NG's Cooja simulator with support for MSP430.
- **Python Processor**: *In development*. A container for post-simulation data processing with scripts in Python.
- **MySQL Database**: A MySQL service to store and manage simulation results.

## Prerequisites

Before using this setup, ensure you have the following installed:

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Directory Structure

```
project-root/
├── cooja/
│   ├── Dockerfile            # Cooja Dockerfile
│   ├── simulation/
│   │   ├── simulation_config.xml # Simulation configuration
├── python/
│   ├── Dockerfile            # Python Processor Dockerfile
│   ├── scripts/              # Python scripts for processing
├── mysql/
│   ├── init.sql              # MySQL initialization script
├── logs/                     # Shared directory for logs
├── docker-compose.yml        # Multi-container configuration
```

## How to Use

### Step 1: Build and Start Containers
Run the following commands to build and start the Docker containers:

```bash
docker compose build
docker compose up -d
```

### Step 2: Connect to the Cooja Simulator
After the containers are running, connect to the Cooja simulator using SSH:

```bash
ssh root@localhost -p 2223
```

The root password is set to `root`.

### Step 3: Run a Simulation
Run the following command inside the Cooja container to start a simulation:

```bash
java -Xms4g -Xmx4g -jar build/libs/cooja.jar --no-gui sim-config.csc
```

## Services Overview

- **Cooja Simulator**: Manages simulation execution. Exposes ports `60001` and `60002`.
- **Python Processor**: *In development*.
- **MySQL Database**: Stores simulation data. Accessible at `localhost:3306` with the default credentials:
  - User: `root`
  - Password: `rootpass`

## Customizing Configurations

- **Simulation Configuration**: Edit `cooja/simulation/simulation_config.xml` to modify the simulation parameters.
- **Python Scripts**: Add or edit scripts in the `python/scripts/` directory for custom processing.
- **MySQL Initialization**: Update the `mysql/init.sql` file for database initialization.

## Stopping and Cleaning Up

To stop the containers:

```bash
docker compose down
```

To remove all containers, volumes, and images:

```bash
docker compose down --rmi all --volumes
```

---

## Troubleshooting

- **Java Not Found in SSH Session**: Ensure the `PATH` variable includes the Java binary path. This is set automatically in the provided Dockerfile.
- **Simulation Errors**: Verify the simulation configuration file `sim-config.csc` and ensure the necessary plugins are correctly defined.

Feel free to customize this setup as per your requirements!