# System Administration Tool - Bash Version

Este módulo implementa la versión para sistemas Linux y entornos compatibles (como WSL) de la herramienta de administración de sistemas multiplataforma.

**Para información global y arquitectura general del proyecto, revisa el README principal.  
Este README cubre especificaciones técnicas, dependencias y buenas prácticas para la versión Bash.**

## 🌟 Funcionalidades principales

- Mostrar usuarios del sistema (UID ≥ 1000 y root) y última sesión registrada
- Estadísticas completas de filesystems y discos montados
- Buscar y enumerar los archivos más grandes en cualquier ruta
- Visualización de memoria física y swap en tiempo real
- Copias de seguridad recursivas y generación automática de catálogos detallados

## 🚀 Compatibilidad y requisitos

- **Sistema operativo**: Linux/Unix moderno (Ubuntu, Debian, CentOS, Fedora, etc.)  
  Funciona perfectamente en WSL (Windows Subsystem for Linux)
- **Shell**: Bash 4.0 o superior
- **Permisos**: Para el funcionamiento completo se recomienda ejecutar con sudo o como root
- **Dependencias**:  
  - Utilidades estándar (`awk`, `find`, `du`, `df`, `stat`, `grep`)
  - `rsync` (opcional, para backups eficientes)

## 💻 Ejecución básica

### Instalación

1. Descarga o clona el proyecto:

   ```bash
   cd ~/Desktop
   git clone <repository-url> system-admin-tool
   # O extrae desde archivo zip
   ```

2. Navega al directorio de Bash:

   ```bash
   cd system-admin-tool/bash
   ```

3. Da permisos de ejecución al script principal y módulos:

   ```bash
   chmod +x system_admin_tool.sh
   chmod +x modules/*.sh
   ```

### Ejecución

**Ejecución estándar:**

```bash
./system_admin_tool.sh
```

**Con privilegios elevados (recomendado):**

```bash
sudo ./system_admin_tool.sh
```

**Desde cualquier ubicación:**

```bash
sudo /ruta/completa/a/system-admin-tool/bash/system_admin_tool.sh
```

## 🗂️ Ejemplo de rutas

- En Linux clásico:  
  `/home/usuario/documentos`
- En WSL (Windows), usa rutas tipo:  
  `/mnt/c/Users/YourUsername/Desktop/carpeta_destino`
- Puedes adaptar las rutas a tu entorno; lo importante es que sean absolutas y accesibles por Bash.

## 📋 Estructura del directorio

```
bash/
├── system_admin_tool.sh           # Script principal
└── modules/                       # Módulos funcionales (uno por cada operación del menú)
    ├── show_menu.sh
    ├── show_system_users.sh
    ├── show_disk_information.sh
    ├── find_largest_files.sh
    ├── show_memory_usage.sh
    └── backup_directory_to_usb.sh
```

## 🔧 Buenas prácticas

- Revisa siempre los permisos y existencia de las rutas antes de ejecutar acciones críticas como backups.
- Asegúrate de tener instaladas las dependencias básicas (`sudo apt install coreutils findutils rsync` en Ubuntu/Debian) si falta alguna.
- Lee los mensajes y advertencias del menú, pues validan errores comunes de permisos y rutas.

## 🛠 Notas técnicas

- Los módulos usan herramientas estándar de Unix/Linux (`find`, `df`, `du`, `awk`, `grep`, `stat`).
- El script principal carga y valida todos los módulos automáticamente.
- El catálogo de backups incluye: nombre de archivo, ruta, fecha de modificación y tamaño en bytes.
- Formato del catálogo: texto plano con columnas alineadas para fácil lectura y auditoría.

### Comandos principales por módulo

| Módulo | Comandos Clave | Detalles |
|--------|----------------|----------|
| **Show System Users** | `awk`, `lastlog` | Lee `/etc/passwd`, filtra UID ≥ 1000 |
| **Show Disk Information** | `df -B1` | Tamaños en bytes, excluye tmpfs |
| **Find Largest Files** | `find`, `du -b`, `sort -rn` | Top 10 por tamaño |
| **Show Memory Usage** | `grep`, `awk` | Lee `/proc/meminfo`, convierte KB→bytes |
| **Backup to USB** | `rsync`/`cp`, `stat` | Genera catálogo automático |

---

**¿Dudas, personalización o problemas? Consulta primero el README principal o contacta al equipo del proyecto.**
