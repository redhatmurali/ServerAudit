# 🖥️ ServerAudit

A lightweight Bash script for collecting server configuration, software, service, and networking information on Linux servers.

The script gathers system details into a single text report to help with server auditing, troubleshooting, inventory management, and maintenance.

## ✨ Features

- 🖥️ **System information** — OS version, kernel, CPU, memory, disk usage, and uptime
- 🌐 **Network information** — listening ports and public IP information
- ⚙️ **Running services** — systemd services currently running
- 🛠️ **Control panels** — detects common hosting and server management directories
- 🌍 **Web servers** — checks Nginx, Apache, and Caddy versions and configuration
- 🗄️ **Database software** — checks PostgreSQL and MySQL/MariaDB installations
- 🐘 **PostgreSQL details** — attempts to collect version, port, listener, and related configuration information
- 💎 **Runtime environments** — checks Ruby, Node.js, and related tools
- 🔴 **Redmine** — checks for existing installations and service files
- 📦 **Build packages** — checks selected development and compilation dependencies
- 🔐 **Certificates** — checks certificate information and common certificate locations
- 🧱 **Firewall** — checks available firewall tools and their status
- 🌐 **DNS checks** — checks configured hostnames and public IP information

The information collected depends on which software and utilities are installed on the server and which commands the executing user is permitted to run.

## 📋 Requirements

- Linux server
- Bash shell
- Standard Linux utilities
- `systemd` for service inventory
- Optional tools for additional checks, such as `nginx`, `psql`, `mysql`, `certbot`, `ufw`, and `firewalld`

Root privileges may be required to access some configuration files and service details. Run with appropriate permissions for your environment.

## 📥 Installation

### Option 1: Download and run

```bash
wget -O serveraudit.sh https://raw.githubusercontent.com/redhatmurali/ServerAudit/main/serveraudit.sh

chmod +x serveraudit.sh

sudo bash serveraudit.sh
```

### Option 2: Clone the repository

```bash
git clone https://github.com/redhatmurali/ServerAudit.git
cd ServerAudit

chmod +x serveraudit.sh
sudo bash serveraudit.sh
```

## ▶️ Usage

Run the audit script:

```bash
sudo ./serveraudit.sh
```

The script collects information and writes the report to:

```text
/root/server-audit.txt
```

Review the generated report:

```bash
sudo less /root/server-audit.txt
```

To copy the report to your current user's home directory:

```bash
sudo cp /root/server-audit.txt "$HOME/server-audit.txt"
sudo chown "$(id -u):$(id -g)" "$HOME/server-audit.txt"
```

## 🔍 Information Collected

| Category | Examples |
|---|---|
| Operating system | Distribution and kernel version |
| Hardware and resources | CPU count, RAM, disk usage, uptime |
| Network | Listening ports and public IP |
| Services | Running systemd services |
| Web servers | Nginx, Apache, Caddy |
| Databases | PostgreSQL, MySQL, MariaDB |
| Development tools | Ruby, Node.js, compilers |
| Applications | Redmine and selected service files |
| Security tools | Firewall utilities and certificate information |
| DNS | Hostname resolution checks |

## 🔒 Security and Privacy

The report may contain sensitive operational information, including IP addresses, listening ports, service names, hostnames, and configuration details.

- Store the report securely.
- Restrict access to authorized administrators.
- Review the report before sharing it publicly.
- Avoid collecting or publishing passwords, tokens, private keys, or other secrets.
- Run the script only on servers you own or are authorized to audit.

This script is an information-gathering utility. It is not a complete vulnerability scanner, penetration-testing tool, or compliance certification system.

## 🧰 Troubleshooting

**Permission denied**

Run the script with appropriate privileges:

```bash
sudo bash serveraudit.sh
```

**Some information is missing**

Some checks depend on optional utilities or installed services. Missing software may result in blank or unavailable fields.

**Report not found**

Check whether the script completed successfully and whether `/root/server-audit.txt` was created.

## 🔗 Repository

[View ServerAudit on GitHub](https://github.com/redhatmurali/ServerAudit)

## 📄 License

Add a `LICENSE` file if you intend to distribute this project for reuse.
