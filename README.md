# System Administration Tool

A comprehensive, cross-platform system administration toolkit with implementations for both Linux (Bash) and Windows (PowerShell). This modular tool provides essential system management capabilities through an intuitive menu-driven interface.

## 🌟 Features

- **Display System Users** - View all users with login information and statistics
- **Display Filesystem/Disk Information** - Monitor disk usage and available space
- **Find Largest Files** - Locate and list the largest files on your system
- **Memory and Swap Usage** - View real-time memory statistics and utilization
- **Backup Directory to USB** - Create backups with automatic catalog generation
- **Modular Architecture** - Clean, maintainable code structure with separated modules

## 📋 Table of Contents

- [Project Structure](#-project-structure)
- [Requirements](-#requirements)
- [Installation](#-installation)
- [Usage](#-usage)
  - [Linux (Bash)](#linux-bash)
  - [Windows (PowerShell)](#windows-powershell)
- [Module Documentation](#-module-documentation)

## 📁 Project Structure

```
final_project_so/
│
├── README.md                          # This file - Main project documentation
│
├── bash/                              # Linux/Unix implementation
│   ├── README.md                      # Bash-specific documentation
│   ├── system_admin_tool.sh           # Main entry point for Bash version
│   └── modules/                       # Bash modules directory
│       ├── show_menu.sh               # Menu display
│       ├── show_system_users.sh       # User management
│       ├── show_disk_information.sh   # Disk information
│       ├── find_largest_files.sh      # File search
│       ├── show_memory_usage.sh       # Memory statistics
│       └── backup_directory_to_usb.sh # Backup functionality
│
└── powershell/                        # Windows implementation
    ├── README.md                      # PowerShell-specific documentation
    ├── system_admin_tool.ps1          # Main entry point for PowerShell version
    └── modules/                       # PowerShell modules directory
        ├── Show-Menu.ps1              # Menu display
        ├── Show-SystemUsers.ps1       # User management
        ├── Show-DiskInformation.ps1   # Disk information
        ├── Find-LargestFiles.ps1      # File search
        ├── Show-MemoryUsage.ps1       # Memory statistics
        └── Backup-DirectoryToUSB.ps1  # Backup functionality
```

## 🔧 Requirements

### Linux (Bash Version)

- **Operating System**: Linux or Unix-based system (Ubuntu, Debian, CentOS, RHEL, etc.)
- **Shell**: Bash 4.0 or higher
- **Permissions**: Root or sudo access recommended for full functionality
- **Dependencies**:
  - Standard Unix utilities (`find`, `du`, `df`, `awk`, `grep`)
  - `rsync` (optional, for enhanced backup functionality)

### Windows (PowerShell Version)

- **Operating System**: Windows 10 or higher, Windows Server 2016 or higher
- **PowerShell**: PowerShell 5.1 or higher (PowerShell 7+ recommended)
- **Permissions**: Administrator privileges recommended for full functionality
- **Dependencies**: All required cmdlets are built into PowerShell

## 🚀 Installation

### Linux (Bash)

1. Clone or download the project to your system:

   ```bash
   cd ~/Desktop
   git clone <repository-url> final_project_so
   # Or extract from zip file
   ```

2. Navigate to the bash directory:

   ```bash
   cd final_project_so/bash
   ```

3. Make the main script executable:

   ```bash
   chmod +x system_admin_tool.sh
   ```

4. Make all module scripts executable (optional, for direct testing):

   ```bash
   chmod +x modules/*.sh
   ```

### Windows (PowerShell)

1. Clone or download the project to your system:

   ```powershell
   cd C:\Users\YourUsername\Desktop
   # Extract from zip or clone repository
   ```

2. Navigate to the powershell directory:

   ```powershell
   cd final_project_so\powershell
   ```

3. If you encounter execution policy restrictions, run:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## 💻 Usage

### Linux (Bash)

#### Standard Execution

```bash
cd ~/Desktop/final_project_so/bash
./system_admin_tool.sh
```

#### With Elevated Privileges (Recommended)

```bash
cd ~/Desktop/final_project_so/bash
sudo ./system_admin_tool.sh
```

#### From Any Location

```bash
sudo /path/to/final_project_so/bash/system_admin_tool.sh
```

### Windows (PowerShell)

#### Standard Execution

```powershell
cd C:\Users\YourUsername\Desktop\final_project_so\powershell
.\system_admin_tool.ps1
```

#### As Administrator (Recommended)

1. Right-click PowerShell and select "Run as Administrator"
2. Navigate to the script location:

   ```powershell
   cd C:\Users\YourUsername\Desktop\final_project_so\powershell
   ```

3. Execute the script:

   ```powershell
   .\system_admin_tool.ps1
   ```

## 📖 Module Documentation

### Main Script

Both versions (Bash and PowerShell) follow a similar architecture:

**Responsibilities:**

- Load and validate all module files
- Define color schemes for the UI
- Display the main menu
- Handle user input and route to appropriate modules
- Manage the program execution loop
- Error handling and validation

### Module Overview

#### 1. Show Menu

**Bash**: `modules/show_menu.sh` | **PowerShell**: `modules/Show-Menu.ps1`

Displays the main menu interface with all available options.

**Features:**

- Colorized output for better visibility
- Clear screen for clean presentation
- Lists all available operations

#### 2. Show System Users

**Bash**: `modules/show_system_users.sh` | **PowerShell**: `modules/Show-SystemUsers.ps1`

Displays comprehensive information about system users.

**Features:**

- Lists all users with UID ≥ 1000 and root user
- Shows username, UID, and last login information
- Displays total user count
- Filters out system service accounts

**Bash Commands Used:** `awk`, `lastlog`, reads `/etc/passwd`  
**PowerShell Cmdlets Used:** `Get-LocalUser`

#### 3. Show Disk Information

**Bash**: `modules/show_disk_information.sh` | **PowerShell**: `modules/Show-DiskInformation.ps1`

Provides detailed filesystem and disk usage statistics.

**Features:**

- Displays all mounted filesystems
- Shows total size, used space, and available space
- Calculates and displays usage percentages
- Excludes temporary filesystems (tmpfs, devtmpfs)

**Bash Commands Used:** `df`, `grep`, `awk`  
**PowerShell Cmdlets Used:** `Get-PSDrive`

#### 4. Find Largest Files

**Bash**: `modules/find_largest_files.sh` | **PowerShell**: `modules/Find-LargestFiles.ps1`

Searches and identifies the largest files on the system.

**Features:**

- Interactive path selection
- Lists available filesystems before search
- Displays top 10 largest files
- Shows rank, size, filename, and full path
- Suppresses permission errors for inaccessible directories

**Bash Commands Used:** `find`, `du`, `sort`  
**PowerShell Cmdlets Used:** `Get-ChildItem`, `Test-Path`

#### 5. Show Memory Usage

**Bash**: `modules/show_memory_usage.sh` | **PowerShell**: `modules/Show-MemoryUsage.ps1`

Displays real-time memory and swap usage statistics.

**Features:**

- Physical memory statistics (total, used, free)
- Swap/page file information
- Percentage calculations
- Formatted output in MB or GB

**Bash Commands Used:** `grep`, `awk`, reads `/proc/meminfo`  
**PowerShell Cmdlets Used:** `Get-CimInstance` (Win32_OperatingSystem, Win32_PageFileUsage)

#### 6. Backup Directory to USB

**Bash**: `modules/backup_directory_to_usb.sh` | **PowerShell**: `modules/Backup-DirectoryToUSB.ps1`

Creates comprehensive backups with automatic catalog generation.

**Features:**

- Interactive source and destination selection
- Displays available mount points/drives
- Creates destination directory if it doesn't exist
- Uses `rsync` (Bash) for efficient copying when available
- Generates detailed backup catalog with:
  - **File Name** - The name of each backed up file
  - **File Path** - Relative path from source directory
  - **Last Modified** - Timestamp of last modification
  - **Size** - File size in bytes
- Progress indication during backup
- Summary statistics upon completion

**Bash Commands Used:** `rsync`, `cp`, `stat`, `find`, `basename`  
**PowerShell Cmdlets Used:** `Copy-Item`, `New-Item`, `Get-ChildItem`, `Out-File`

**Catalog Format Example:**

```
============================================
BACKUP CATALOG
============================================
Backup Date: 2025-11-03 14:30:45
Source Directory: /home/user/documents
Total Files Backed Up: 156
============================================

File Name                      File Path                                                    Last Modified             Size (Bytes)
---------                      ---------                                                    -------------             -----------
report.pdf                     documents/reports/report.pdf                                 2025-11-03 10:15:22       2048576
image.png                      images/screenshots/image.png                                 2025-11-02 18:45:10       1024000
...
```
