![Bash](https://img.shields.io/badge/Bash-4.0%2B-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Termux%20%7C%20macOS%20%7C%20WSL-informational?style=for-the-badge&logo=linux&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

```
██╗      ██████╗  ██████╗      █████╗ ███╗   ██╗ █████╗ ██╗  ██╗   ██╗███████╗███████╗██████╗ 
██║     ██╔═══██╗██╔════╝     ██╔══██╗████╗  ██║██╔══██╗██║  ╚██╗ ██╔╝╚══███╔╝██╔════╝██╔══██╗
██║     ██║   ██║██║  ███╗    ███████║██╔██╗ ██║███████║██║   ╚████╔╝   ███╔╝ █████╗  ██████╔╝
██║     ██║   ██║██║   ██║    ██╔══██║██║╚██╗██║██╔══██║██║    ╚██╔╝   ███╔╝  ██╔══╝  ██╔══██╗
███████╗╚██████╔╝╚██████╔╝    ██║  ██║██║ ╚████║██║  ██║███████╗██║   ███████╗███████╗██║  ██║
╚══════╝ ╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚══════╝╚══════╝╚═╝  ╚═╝
```

> *"The quieter you become, the more you are able to hear."*

Security log analysis tool for detecting brute force attacks, SQL injection attempts, and suspicious IP addresses from system logs — all from your terminal, no GUI needed.

---

##  Features

-  SSH log analysis — track every failed login attempt
-  Web server log analysis — Apache & Nginx
-  Brute force attack detection
-  Suspicious IP identification
-  Automated security report generation

---

##  Supported Platforms

- Termux (Android)
- Linux
- macOS
- WSL

---

##  Requirements

- Bash 4.0+
- Read access to log files:
  - `/var/log/auth.log`
  - `/var/log/apache2/access.log`
  - `/var/log/nginx/access.log`

> On some systems you'll need `sudo` to read these files.

---

##  Installation

```bash
git clone https://github.com/hey-pro-108/log-analyzer7.git
cd log-analyzer7
chmod +x *.sh
```

---

##  Usage

```bash
./log-analyzer.sh
```



## 🗂️ Log File Locations

- **SSH** → `/var/log/auth.log`
- **Apache** → `/var/log/apache2/access.log`
- **Nginx** → `/var/log/nginx/access.log`
- **System** → `/var/log/syslog`

---

## 💾 Report Storage

Reports are saved automatically to:

```
~/.log-analyzer/reports/
```

---

## 📄 License

MIT — use it, break it, improve it.

---

<div align="center">

*built in the terminal, for the terminal*

**Hexa Dev** · [GitHub](https://github.com/hey-pro-108)

</div>
