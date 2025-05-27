# Simple Monitoring with Netdata

This project demonstrates how to set up a basic system health monitoring dashboard using [NetData](https://github.com/netdata/netdata). It introduces system performance monitoring, alert configuration, and simple automation using shell scripts. 

---
## Project Overview
> This Project is inspired by [roadmap.sh](https://roadmap.sh/projects/simple-monitoring-dashboard)
The goal is to understand the fundamentals of monitoring by:
- Installing Netdata on a Linux system.
- Viewing real-time metrics through a web interface.
- Customizing the dashboard and setting alerts.
- Automating setup and teardown with Bash scripts.

---
## Requirements
- A Linux system (e.g., Ubuntu, Amazon Linux, Rock Linux).
- Internet access to install Netdata.
- Access to port `19999` (Netdata Web UI).

---
## Instructions
> If necessary, update system packages and install required dependencies.
> 
> `sudo apt update && sudo apt install curl -y`

### Setup
Run the setup script to install and start Netdata:
```BASH
sudo bash setup.sh
```

Then open a browser and go to:
`http://<your-server-ip>:19999`

### Testing
To simulate CPU load and test dashboard resonsivness, run:
```BASH
sudo bash test_dashboard.sh
```
Monitor the dashboard and verify alert behavior. 
> Lowered the threhold to 20% for warm, 40% for critical for easier testing.
> 
> Example configuration located at `/etc/netdata/health.d/cpu_usage.conf`.

### Clean Up
To remove Netdata and restore the system:
```BASH
sudo bash cleanup.sh
```

