#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as the root user or with sudo."
  exit
fi

# Set up a log file 
LOGFILE="/var/log/security_audit.log"
EMAIL="abc@example.com"

echo "Security Audit and Hardening Script - $(date)" > $LOGFILE

# 1. Check Users and Groups
echo "1. Checking Users and Groups" | tee -a $LOGFILE
echo "Listing all users and groups on the system..." | tee -a $LOGFILE
cat /etc/passwd | tee -a $LOGFILE
cat /etc/group | tee -a $LOGFILE

echo "Finding users with root privileges (UID 0)..." | tee -a $LOGFILE
awk -F: '($3 == 0) {print}' /etc/passwd | tee -a $LOGFILE

echo "Looking for users with weak or no passwords..." | tee -a $LOGFILE
awk -F: '($2 == "" || length($2) < 6) {print $1}' /etc/shadow | tee -a $LOGFILE

# 2. Check File and Directory Permissions
echo "2. Checking File and Directory Permissions" | tee -a $LOGFILE
echo "Searching for files that anyone can write to..." | tee -a $LOGFILE
find / -perm -002 -type f -print | tee -a $LOGFILE

echo "Checking .ssh folders for proper permissions..." | tee -a $LOGFILE
find /home -name ".ssh" -exec ls -ld {} \; | tee -a $LOGFILE

echo "Looking for files with special permissions (SUID/SGID)..." | tee -a $LOGFILE
find / -perm /6000 -type f -exec ls -l {} \; | tee -a $LOGFILE

# 3. Check Running Services
echo "3. Checking Running Services" | tee -a $LOGFILE
echo "Listing all currently running services..." | tee -a $LOGFILE
service --status-all | tee -a $LOGFILE

echo "Checking if critical services like SSH and firewall are running..." | tee -a $LOGFILE
for service in sshd iptables; do
    systemctl is-active --quiet $service && echo "$service is running" | tee -a $LOGFILE || echo "$service is NOT running" | tee -a $LOGFILE
done

# 4. Check Firewall and Network Security
echo "4. Checking Firewall and Network Security" | tee -a $LOGFILE
echo "Checking the firewall status..." | tee -a $LOGFILE
iptables -L | tee -a $LOGFILE

echo "Listing open network ports..." | tee -a $LOGFILE
netstat -tuln | grep LISTEN | tee -a $LOGFILE

echo "Checking if IP forwarding is enabled..." | tee -a $LOGFILE
sysctl net.ipv4.ip_forward | tee -a $LOGFILE

# 5. Check IP and Network Configurations
echo "5. Checking IP and Network Configurations" | tee -a $LOGFILE
echo "Identifying public and private IP addresses..." | tee -a $LOGFILE
ip addr | grep "inet " | tee -a $LOGFILE

# 6. Check for Security Updates
echo "6. Checking for Security Updates" | tee -a $LOGFILE
echo "Looking for available updates..." | tee -a $LOGFILE
apt-get update && apt-get upgrade -s | tee -a $LOGFILE

# 7. Monitor Logs
echo "7. Monitoring Logs" | tee -a $LOGFILE
echo "Searching for failed login attempts..." | tee -a $LOGFILE
grep "Failed password" /var/log/auth.log | tee -a $LOGFILE

# 8. Harden the Server
echo "8. Hardening the Server" | tee -a $LOGFILE

echo "Disabling root login via SSH..." | tee -a $LOGFILE
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

echo "Disabling IPv6 to improve security..." | tee -a $LOGFILE
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

echo "Securing the bootloader with a password..." | tee -a $LOGFILE
echo "Follow the instructions to set a password for GRUB" | tee -a $LOGFILE
grub-mkpasswd-pbkdf2 | tee -a $LOGFILE
# Add the password you create to /etc/grub.d/40_custom

echo "Setting up automatic security updates..." | tee -a $LOGFILE
apt-get install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades

# 9. Placeholder for Custom Checks
echo "9. Custom Security Checks (Not Implemented)" | tee -a $LOGFILE

# 10. Reporting and Alerts
echo "10. Reporting and Alerts" | tee -a $LOGFILE
echo "Security audit is done. You can see the details in $LOGFILE." | tee -a $LOGFILE

# Send an email if there are critical issues
# mail -s "Security Audit Report" $EMAIL < $LOGFILE
