# System Administration Tool

A comprehensive, cross-platform system administration toolkit with implementations for both Linux (Bash) and Windows (PowerShell).  
This modular tool provides essential system management capabilities through an intuitive menu-driven interface.

## 📋 Table of Contents

- [Features](#-features)
- [Project Structure](#-project-structure)
- [Requirements](#-requirements)
- [Installation & Usage](#-installation--usage)
- [Module Documentation](#-module-documentation)

## 🌟 Features

- **Display System Users** - View all users with login/connection information and statistics
- **Display Filesystem/Disk Information** - Monitor disk usage and available space
- **Find Largest Files** - Locate and list the largest files under any path
- **Memory and Swap Usage** - View real-time memory statistics and utilization
- **Backup Directory to USB** - Create backups with automatic, detailed catalog generation
- **Modular Architecture** - Maintainable, easy-to-extend code structure with separated modules

## � Project Structure

```
SYSTEM-ADMIN-TOOL/
│
├── README.md                          # This file – Main project documentation (overview, structure)
│
├── bash/                              # Linux/Unix implementation
│   ├── README.md                      # Bash-specific documentation
│   ├── system_admin_tool.sh           # Bash main script
│   └── modules/                       # Bash modules directory
│       ├── show_menu.sh
│       ├── show_system_users.sh
│       ├── show_disk_information.sh
│       ├── find_largest_files.sh
│       ├── show_memory_usage.sh
│       └── backup_directory_to_usb.sh
│
└── powershell/                        # Windows implementation
    ├── README.md                      # PowerShell-specific documentation
    ├── system_admin_tool.ps1          # PowerShell main script
    └── modules/                       # PowerShell modules directory
        ├── Show-Menu.ps1
        ├── Show-SystemUsers.ps1
        ├── Show-DiskInformation.ps1
        ├── Find-LargestFiles.ps1
        ├── Show-MemoryUsage.ps1
        └── Backup-DirectoryToUSB.ps1
```

## 🔧 Requirements

### Linux (Bash Version)

- **Operating System**: Linux or Unix-based system (Ubuntu, Debian, CentOS, RHEL, etc.) or WSL (Windows Subsystem for Linux)
- **Shell**: Bash 4.0 or higher
- **Permissions**: Root or sudo access recommended for full functionality
- **Dependencies**:
  - Standard Unix utilities (`find`, `du`, `df`, `awk`, `grep`, `stat`)
  - `rsync` (optional, for enhanced backup functionality)

### Windows (PowerShell Version)

- **Operating System**: Windows 10 or higher, Windows Server 2016 or higher
- **PowerShell**: PowerShell 5.1 or higher (PowerShell 7+ recommended)
- **Permissions**: Administrator privileges recommended for full functionality
- **Dependencies**: All required cmdlets are built into PowerShell (no external modules needed)

## 🚀 Installation & Usage

**For detailed installation instructions and platform-specific steps, see:**
- **Linux/Bash**: [`bash/README.md`](bash/README.md)
- **Windows/PowerShell**: [`powershell/README.md`](powershell/README.md)

### Quick Start

**Linux (Bash):**
```bash
cd system-admin-tool/bash
chmod +x system_admin_tool.sh modules/*.sh
sudo ./system_admin_tool.sh
```

**Windows (PowerShell):**
```powershell
cd system-admin-tool\powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  # If needed
.\system_admin_tool.ps1  # Run as Administrator
```

## 📖 Module Documentation

Both versions provide 6 core modules with equivalent functionality:

### 1. Show System Users
Lists all user accounts with last login information.
- **Bash**: Filters UID ≥ 1000 + root, uses `lastlog`
- **PowerShell**: Uses `Get-LocalUser` with LastLogon

### 2. Show Disk Information
Displays filesystem statistics with sizes in bytes and usage percentages.
- **Bash**: Uses `df -B1` (excludes tmpfs/devtmpfs)
- **PowerShell**: Uses `Get-PSDrive` and `Get-Volume`

### 3. Find Largest Files
Searches and ranks the top 10 largest files in a specified path.
- **Bash**: Uses `find`, `du -b`, `sort`
- **PowerShell**: Uses `Get-ChildItem` with recursive search

### 4. Show Memory Usage
Displays physical memory and swap/page file statistics in bytes and percentages.
- **Bash**: Reads `/proc/meminfo`
- **PowerShell**: Uses `Get-CimInstance` (Win32 classes)

### 5. Backup Directory to USB
Creates full backups with automatic catalog generation.
- **Bash**: Prefers `rsync`, falls back to `cp`
- **PowerShell**: Uses `Copy-Item` with progress indication

**Catalog includes**: File name, path, modification date, and size in bytes.

### 6. Show Menu
Interactive menu interface with color-coded options for all operations.

---

**For detailed technical documentation, commands/cmdlets used, and troubleshooting:**
- **Bash Version**: [`bash/README.md`](bash/README.md)
- **PowerShell Version**: [`powershell/README.md`](powershell/README.md)
