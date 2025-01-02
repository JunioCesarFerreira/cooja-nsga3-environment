# Prepare VM Environment for Contiki-NG and Cooja

*Drafted on 2025-02-01*

This guide provides step-by-step instructions to set up Contiki-NG and use the Cooja simulator within a VirtualBox virtual machine (VM). You'll also learn how to run a basic RPL simulation.

## 1. Downloads and Purpose

To set up the environment, you’ll need two essential components:

### 1.1. Oracle VM VirtualBox
- **What is it?**  
  VirtualBox is an open-source virtualization platform that allows you to run multiple operating systems on your computer as virtual machines (VMs). This tool is essential for creating and managing the virtual environment required for Contiki-NG.

- **How to Use it?**  
  1. Download VirtualBox from [here](https://www.oracle.com/br/virtualization/technologies/vm/downloads/virtualbox-downloads.html).
  2. Install it on your system by following the on-screen instructions.
  3. Once installed, you'll use VirtualBox to create a VM where Contiki-NG will be executed.

### 1.2. Ubuntu 22.04 VM Image
- **What is it?**  
  A pre-configured Ubuntu 22.04 virtual machine image to serve as the base environment for installing and running Contiki-NG and the Cooja simulator.

- **How to Use it?**  
  1. Download the Ubuntu 22.04 VM image from [here](https://www.linuxvmimages.com/images/ubuntu-2204/).
  2. Extract the archive to access the `.vbox` file (VirtualBox machine configuration) and `.vdi` file (virtual disk image).
  3. Open the `.vbox` file in VirtualBox to import the VM.

### Why These Tools Are Important?
- **VirtualBox** provides the virtualization infrastructure to run the Contiki-NG environment on your host machine without affecting your primary OS.
- **Ubuntu 22.04 VM** provides a clean and compatible base system for setting up Contiki-NG and Cooja with modern tools and dependencies.

## 2. Setting Up the Virtual Machine

1. **Create the Virtual Machine**:
   - Extract the Ubuntu 22.04 VM image files from the downloaded archive.
   - Open VirtualBox and click **Add** to add the existing VM using the `.vbox` file.
   - Verify the following configurations:
     - **Name**: Contiki-NG VM
     - **Type**: Linux
     - **Version**: Ubuntu (64-bit)
     - **Memory**: 2048 MB (or higher if available).

2. **Start the VM**:
   - Boot the VM and log in with the provided credentials from the VM image documentation.
   - Ensure the system is updated:
     ```bash
     sudo apt-get update && sudo apt-get upgrade
     ```

3. **Prepare the System for Contiki-NG**:
   Install required packages, including the MSP430 toolchain:
   ```bash
   sudo apt-get install -y build-essential doxygen git git-lfs curl python3-serial srecord rlwrap wget \
      software-properties-common binutils-msp430 gcc-msp430 msp430-libc mspdebug libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386
   ```

4. **Install MSP430-GCC 4.7.2 (if needed):**
   Download and install MSP430-GCC 4.7.2:
   ```bash
   wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2
   tar xjf mspgcc-4.7.2-compiled.tar.bz2 -C /tmp/
   sudo cp -r /tmp/msp430/* /usr/local/
   rm -rf /tmp/msp430 mspgcc-4.7.2-compiled.tar.bz2
   ```

## 3. Installing Contiki-NG and Cooja

1. **Clone Contiki-NG Repository**:
   Open a terminal and run:
   ```bash
   git clone --recursive https://github.com/contiki-ng/contiki-ng.git
   cd contiki-ng/tools/cooja
   ```

2. **Build Cooja Simulator**:
   Use `gradlew` to build Cooja:
   ```bash
   ./gradlew build --no-daemon --stacktrace --info
   ```
   The first build might take a few minutes.

3. **Test Cooja**:
   Launch the simulator:
     ```bash
     ./gradlew run
     ```
   From the Cooja menu, go to **File** > **New Simulation**, and create a test simulation.

4. **Create a Desktop Shortcut for Cooja**:
   To simplify launching Cooja, create a startup script:
   ```bash
   echo '#!/bin/bash
   cd ~/contiki-ng/tools/cooja
   ./gradlew run' > ~/contiki-ng/tools/cooja/start-cooja.sh
   chmod +x ~/contiki-ng/tools/cooja/start-cooja.sh
   ```

   Then, create a desktop shortcut:
   ```bash
   echo '[Desktop Entry]
   Version=1.0
   Type=Application
   Name=Cooja
   Exec=/home/$USER/contiki-ng/tools/cooja/start-cooja.sh
   Icon=application-x-executable
   Terminal=true
   Categories=Development;' > ~/Desktop/Cooja.desktop
   chmod +x ~/Desktop/Cooja.desktop
   ```
   - Replace `/path/to/contiki-ng` with the full path to your Contiki-NG directory.
   - Make the shortcut executable:
     ```bash
     chmod +x ~/Desktop/Cooja.desktop
     ```

## 4. Setting Up a Basic RPL Simulation

1. **Add a Root Node (Uhub)**:
   - Go to **Motes** > **Add Motes** > **Create New Mote Type**.
   - Select **Sky Mote** and configure as follows:
     - **Description**: `Uhub`
     - **Source File**: Browse to `/examples/rpl-udp/udp-server.c`
   - Click **Compile** and then **Create**.
   - Place one instance of this mote in the network.

2. **Add Leaf Nodes (Uswitches)**:
   - Repeat the process above, but name the mote type `Uswitches`.
   - Use `/examples/rpl-udp/udp-client.c` as the source file.
   - Add multiple instances of `Uswitches` to the simulation.

3. **Arrange Nodes**:
   - Drag the `Uswitches` motes within the radio range of `Uhub`. Use the visual tool to confirm connectivity.

4. **Run the Simulation**:
   - Press the **Start** button in the **Simulation Control** window.
   - Observe the traffic between motes. Messages should propagate from leaf nodes to the root node (`Uhub`) using RPL.

## 5. SSH Access to the VM

1. **Install SSH Server**:
    ```bash
    sudo apt-get install openssh-server
    ```
    Check if it’s running:
    ```bash
    sudo service ssh status
    ```

2. **Configure Port Forwarding**:
   - In VirtualBox, go to **Settings** > **Network** > **Advanced** > **Port Forwarding**.
   - Add a rule:
     - **Host Port**: 2222
     - **Guest Port**: 22

3. **Connect via SSH**:
   Use the following command on the host machine:
   ```bash
   ssh user@127.0.0.1 -p 2222
   ```

## 6. [Using the Fetch XML File Script](fetch-csc-file.md)

This Python script connects to a remote host via SSH (using the Paramiko library) and executes the cat command to retrieve the content of a CSC file (Cooja simulation configuration), which is actually an XML-formatted file. It then removes any blank lines from the retrieved content and saves the cleaned data to a local file.

