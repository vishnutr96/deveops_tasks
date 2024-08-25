# System Resource Monitoring Script

This Bash script provides a comprehensive dashboard for monitoring various system resources on a server. It offers real-time insights into CPU and memory usage, network statistics, disk usage, system load, memory usage, processes, and essential services. You can view the entire dashboard or focus on specific parts using command-line switches.

## Features

- Top 10 Applications by CPU and Memory Usage
- Network Monitoring
  - Concurrent connections
  - Packet drops
  - Network traffic (MB in/out)
- Disk Usage
  - Disk space usage by mounted partitions
  - Highlight partitions using more than 80% of space
- System Load
  - Current system load average
  - CPU usage breakdown
- Memory Usage
  - Total, used, and free memory
  - Swap memory usage
- Process Monitoring
  - Number of active processes
  - Top 5 processes by CPU and memory usage
- Service Monitoring
  - Status of essential services (e.g., sshd, nginx, apache2, iptables)


### Running the Script

To use the script, make sure it’s executable:

chmod +x monitor.sh


You can then run the script to display the full dashboard or use specific command-line switches to view individual sections.

### Command-Line Switches

-cpu: Display the top 10 applications by CPU and memory usage.
-network: Monitor network statistics, including concurrent connections, packet drops, and network traffic.
-disk: Show disk usage and highlight partitions using more than 80%.
-load: Display system load and CPU usage breakdown.
-memory: Display memory and swap usage.
-process: Monitor the number of active processes and display the top 5 processes by CPU and memory usage.
-service: Monitor the status of essential services (sshd, nginx, apache2, iptables).
-all: Display the full dashboard with all the above information.

### Examples

1. Display the Full Dashboard:

    ./monitor.sh -all


2. View Top 10 Applications by CPU and Memory Usage:

    ./monitor.sh -cpu
    

3. Monitor Network Statistics:

    ./monitor.sh -network

4. Show Disk Usage:

    ./monitor.sh -disk

5. Display System Load:

    ./monitor.sh -load
   

6. Check Memory Usage:

    ./monitor.sh -memory
    

7. Monitor Processes:

    ./monitor.sh -process
    

8. Check Essential Services:

  
    ./monitor.sh -service


### Customization

You can extend or modify the script to include additional monitoring features or services as per your requirements.
