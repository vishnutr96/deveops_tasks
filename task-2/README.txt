
# Security Audit and Hardening Script

## Overview

This script performs a comprehensive security audit and hardening of a Linux server. It checks user accounts, file permissions, running services, network settings, and applies basic hardening measures. The script logs all findings to a file and can optionally send a report via email.

## Features

- User and Group Audits: Lists all users and groups, identifies users with root privileges, and checks for weak or missing passwords.
- File and Directory Permissions: Scans for world-writable files, checks `.ssh` directories, and identifies files with SUID/SGID bits set.
- Service Audits: Lists all running services and checks the status of critical services like SSH and firewall.
- Firewall and Network Security: Verifies the firewall status, lists open ports, and checks IP forwarding settings.
- IP and Network Configuration Checks: Identifies public and private IP addresses.
- Security Updates and Patching: Checks for available updates.
- Log Monitoring: Searches for failed login attempts.
- Server Hardening: Disables root login via SSH, disables IPv6, secures the bootloader with a password, and configures automatic security updates.

## Prerequisites

- A Linux server (Debian/Ubuntu-based systems preferred).
- Root access or sudo privileges.

## Installation


1. Make the Script Executable:
   
   chmod +x security_audit.sh
   
2. Install Required Packages:
   The script uses some tools that might not be installed by default. Ensure these are installed:
   
   sudo apt-get update
   sudo apt-get install -y mailutils unattended-upgrades net-tools
   

## Configuration

1. Email Configuration:
   The script can send email reports to an administrator. Set the email address in the script:
   
   EMAIL="abc@example.com"
   

2. Log File Location:
   By default, the script logs to `/var/log/security_audit.log`. You can change this by modifying the `LOGFILE` variable:
   
   LOGFILE="/path/to/your/logfile.log"
   

