## Using the Fetch XML File Script

This script connects to a remote host via SSH (using the Paramiko library) and executes the cat command to retrieve the content of a CSC file (Cooja simulation configuration), which is actually an XML-formatted file. It then removes any blank lines from the retrieved content and saves the cleaned data to a local file.

### Requirements
- **Python 3.6+** installed on your local machine.
- **Paramiko** library (install with `pip install paramiko`).

### How It Works
1. The script **establishes an SSH connection** to the specified host using the provided port, username, and password.  
2. It **runs a `cat` command** on the remote file to capture its content.  
3. It **filters out all blank lines** from the content.  
4. Finally, it **writes** the cleaned data to a local file.

### Usage
1. Edit the variables near the end of the script:
   - `HOST`: The IP or hostname of the remote machine (e.g., `127.0.0.1` if using NAT + port forwarding, or a local IP if using a bridged network).
   - `PORT`: The SSH port (e.g., `22` for a direct connection or `2222` if using port forwarding).
   - `USERNAME` and `PASSWORD`: Credentials for the remote machine.
   - `REMOTE_PATH`: The full path to the remote XML file.
   - `LOCAL_PATH`: The path and filename where you want the cleaned file saved locally.
2. **Run** the script:
   ```bash
   python3 fetch-csc-file.py
   ```
3. **Check** the console output for confirmation that the file was retrieved and saved successfully.

### Troubleshooting
- If you get **Connection Refused**, ensure the SSH service is running on the remote host and that you have the correct port forwarding or IP address.
- If you get **Permission Denied**, verify that the `USERNAME` has access to the file and directories in question.
- If you get **No Such File or Directory**, check the `REMOTE_PATH` for typos or the correct path.