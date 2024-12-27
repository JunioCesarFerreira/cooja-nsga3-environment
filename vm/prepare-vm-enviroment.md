# Prepare VM Environment for ContikiOS and Cooja

*Drafted on 2024-12-27*

This guide provides step-by-step instructions to set up ContikiOS and use the Cooja simulator within a VirtualBox virtual machine (VM). You'll also learn how to run a basic RPL simulation.

## 1. Downloads and Purpose

To set up the environment, you’ll need two essential components:

### 1.1. Oracle VM VirtualBox
- **What is it?**  
  VirtualBox is an open-source virtualization platform that allows you to run multiple operating systems on your computer as virtual machines (VMs). This tool is essential for creating and managing the virtual environment required for ContikiOS.

- **How to Use it?**  
  1. Download VirtualBox from [here](https://www.oracle.com/br/virtualization/technologies/vm/downloads/virtualbox-downloads.html).
  2. Install it on your system by following the on-screen instructions.
  3. Once installed, you'll use VirtualBox to create a VM where ContikiOS will be executed.

### 1.2. Instant Contiki (Version 3.0)
- **What is it?**  
  Instant Contiki is a pre-configured virtual machine containing the ContikiOS operating system. ContikiOS is an open-source OS tailored for low-power IoT devices. Instant Contiki includes tools like Cooja, which is a powerful simulator for testing and visualizing IoT networks.

- **How to Use it?**  
  1. Download the **Instant Contiki 2.7** archive from [here](https://sourceforge.net/projects/contiki/).
  2. Extract the archive to access the `.vmdk` file, which is the virtual disk image for the VM.
  3. This file will be used to set up the VM in VirtualBox.

- **Note**: The external file indicates version 2.7 but in fact the version is 3.0.

### Why These Tools Are Important?
- **VirtualBox** provides the virtualization infrastructure to run the ContikiOS environment on your host machine without affecting your primary OS.
- **Instant Contiki** simplifies the setup process by providing a ready-to-use environment with all necessary tools, saving you the hassle of manually installing ContikiOS and its dependencies.

## 2. Setting Up the Virtual Machine

1. **Create the Virtual Machine**:
   - Extract the `InstantContiki2.7` file from the Instant Contiki archive.
   - Open VirtualBox and click **New** to create a new VM.
   - Use the following configurations:
     - **Name**: Instant Contiki
     - **Type**: Linux
     - **Version**: Ubuntu (32-bit)
     - **Memory**: 2048 MB (or higher if available).
     - **Hard Disk**: Select **Use an existing virtual hard disk file**, and browse to the extracted `.vmdk` file.

2. **Start the VM**:
   - Boot the VM and log in with the default credentials (`user`/`user` for username/password, unless specified otherwise).
   - Wait for the system to stabilize, and if prompted, update Ubuntu to version 14.04.

3. **Prepare the System**:
   - Update package repositories:
     ```bash
     sudo apt-get update
     ```
   - Adjust the screen resolution:
     ```bash
     sudo xrandr -s 1280x800
     ```

## 3. Running the Cooja Simulator

1. **Navigate to the Cooja Directory**:
   Use the desktop shortcut or open a terminal and run:
   ```bash
   cd contiki/tools/cooja
   ant run
   ```

2. **Test an Example Simulation**:
   - From the Cooja menu, go to **File** > **New Simulation**.
   - Name your simulation (e.g., `Simple-RPL`) and proceed with default settings.
   - See next topic.

## 4. Setting Up a Basic RPL Simulation

1. **Add a Root Node (Uhub)**:
   - Go to **Motes** > **Add Motes** > **Create New Mote Type**.
   - Select **Sky Mote** and configure as follows:
     - **Description**: `Uhub`
     - **Source File**: Browse to `/examples/ipv6/simple-udp-rpl/unicast-receiver.c`
   - Click **Compile** and then **Create**.
   - Place one instance of this mote in the network.

2. **Add Leaf Nodes (Uswitches)**:
   - Repeat the process above, but name the mote type `Uswitches`.
   - Use `/examples/ipv6/simple-udp-rpl/unicast-sender.c` as the source file.
   - Add multiple instances of `Uswitches` to the simulation.

3. **Arrange Nodes**:
   - Drag the `Uswitches` motes within the radio range of `Uhub`. Use the visual tool to confirm connectivity.

4. **Run the Simulation**:
   - Press the **Start** button in the **Simulation Control** window.
   - Observe the traffic between motes. Messages should propagate from leaf nodes to the root node (`Uhub`) using RPL.

## 5. SSH Access to the VM

1. **Install SSH Server**:
    install
    ```bash
    sudo apt-get install openssh-server
    ```
    check if running
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

