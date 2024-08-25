#!/bin/bash

# Function to display top 10 most used applications by CPU and memory
function show_top_apps() {
    echo "Top 10 Applications by CPU and Memory Usage:"
    
    ps aux --sort=-%cpu | head -n 11
    echo ""
}

# Function to monitor network statistics
function show_network_stats() {
    echo "Network Monitoring:"
    echo "Concurrent Connections:"
    ss -tun | grep -v State | wc -l

    echo "Packet Drops:"   
     netstat -i | awk 'NR==1 {next} {print $1, "RX Drops:", $4, "TX Drops:", $8}'
    echo " "
    echo " Network Traffic (MB in/out):"
    ifstat -t 1 1 | awk 'NR==3 {print "In: " $1 " KB/s, Out: " $2 " KB/s"}'
    echo ""
}

# Function to show disk usage and highlight partitions using more than 80%
function show_disk_usage() {
    echo "Disk space usage by mounted partitions:"
    df -h
    echo "partitions using more than 80%:"
    df -h | awk '{if(NR==1 || $5+0 > 80) print $0}'
    echo ""
}

# Function to show system load
function show_system_load() {
    echo "System Load:"
    uptime

    echo "CPU Usage Breakdown:"
    mpstat | grep -A 5 "%idle"
    echo ""
}

# Function to show memory usage
function show_memory_usage() {
    echo "Memory Usage:"
    free -m

    echo "Swap Memory Usage:"
    swapon --show
    echo ""
}

# Function to monitor processes
function show_process_stats() {
    echo "Process Monitoring:"
    echo "Number of active processes:"
    ps aux | wc -l

    echo "Top 5 Processes by CPU and Memory Usage:"
    ps aux --sort=-%cpu | head -n 6
    echo ""
}

# Function to monitor services
function show_service_status() {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done
    echo ""
}

function show_dashboard() {
    clear
    show_top_apps
    show_network_stats
    show_disk_usage
    show_system_load
    show_memory_usage
    show_process_stats
    show_service_status
}

# Command-line switches
while [ "$1" != "" ]; do
    case $1 in
        -cpu) show_top_apps ;;
        -network) show_network_stats ;;
        -disk) show_disk_usage ;;
        -load) show_system_load ;;
        -memory) show_memory_usage ;;
        -process) show_process_stats ;;
        -service) show_service_status ;;
        -all) show_dashboard ;;
        *) echo "Invalid option: $1" ;;
    esac
    shift
done


