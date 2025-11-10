# System Administration Tool - PowerShell Version

Este módulo implementa la versión para sistemas Windows de la herramienta de administración de sistemas multiplataforma usando PowerShell.

**Para la visión global y estructura del proyecto revisa el README principal.  
Aquí se detallan aspectos técnicos, requisitos y recomendaciones específicas para PowerShell.**

## 🌟 Funcionalidades principales

- Listado detallado de usuarios locales con estado habilitado y última sesión
- Estadísticas completas de unidades lógicas y filesystems, con espacio y porcentajes
- Exploración recursiva y listado de los 10 archivos más grandes en una ruta especificada
- Visualización de memoria física y virtual (página de archivo/Swap) con detalles y porcentaje
- Copias de seguridad completas a directorios o unidades con creación automática de catálogo

## 🚀 Compatibilidad y requisitos

- **Sistema operativo**: Windows 10/11 o Windows Server 2016/2019/2022
- **PowerShell**: 5.1 o superior (recomendado PowerShell 7+)
- **Permisos**: Ejecutar PowerShell como administrador para acceso completo
- **Dependencias**: Solo cmdlets nativos; no requiere módulos externos

## 💻 Instalación y ejecución

### Instalación

1. Descarga o clona el proyecto:

   ```powershell
   cd C:\Users\YourUsername\Desktop
   # Extrae desde zip o clona el repositorio
   ```

2. Navega al directorio de PowerShell:

   ```powershell
   cd system-admin-tool\powershell
   ```

3. Si aparece advertencia de política de ejecución, habilita la ejecución de scripts:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

### Ejecución

**Ejecución estándar:**

```powershell
cd C:\Users\YourUsername\Desktop\system-admin-tool\powershell
.\system_admin_tool.ps1
```

**Como administrador (recomendado):**

1. Clic derecho en PowerShell → "Ejecutar como administrador"
2. Navega al directorio y ejecuta:

   ```powershell
   cd C:\Users\YourUsername\Desktop\system-admin-tool\powershell
   .\system_admin_tool.ps1
   ```

3. Usa el menú interactivo para seleccionar opciones

## 🗂️ Ejemplo de rutas

- Para usar con las funciones, ingresa rutas con formato Windows, como:  
  `C:\Users\YourUsername\Desktop\carpeta_respaldo` o `D:\Backup`

## 📋 Estructura de archivos

```
powershell/
├── system_admin_tool.ps1          # Script principal
└── modules/                       # Módulos independientes
    ├── Show-Menu.ps1
    ├── Show-SystemUsers.ps1
    ├── Show-DiskInformation.ps1
    ├── Find-LargestFiles.ps1
    ├── Show-MemoryUsage.ps1
    └── Backup-DirectoryToUSB.ps1
```

## 🔧 Buenas prácticas

- Ejecuta PowerShell con privilegios de administrador para evitar problemas de permisos.
- Usa rutas absolutas en formato Windows para evitar errores de acceso o path.
- Revisa que la política de ejecución permita correr scripts locales (`RemoteSigned` es recomendado).

## 🛠 Notas técnicas

- Utiliza únicamente cmdlets nativos de PowerShell (no requiere módulos externos).
- La función `Wait-ForKeyPress` garantiza compatibilidad con Console, ISE y VS Code.
- El catálogo de backup incluye: ruta relativa, fecha de modificación y tamaño en bytes.
- Formato del catálogo: texto UTF-8 con columnas alineadas para fácil lectura.

### Cmdlets principales por módulo

| Módulo | Cmdlets Clave | Detalles |
|--------|---------------|----------|
| **Show-SystemUsers** | `Get-LocalUser` | Muestra estado y última sesión |
| **Show-DiskInformation** | `Get-PSDrive`, `Get-Volume` | Tamaños en bytes con porcentajes |
| **Find-LargestFiles** | `Get-ChildItem -Recurse` | Top 10 ordenados por tamaño |
| **Show-MemoryUsage** | `Get-CimInstance` | Win32_OperatingSystem, Win32_PageFileUsage |
| **Backup-DirectoryToUSB** | `Copy-Item`, `Get-ChildItem` | Copia recursiva con progreso |

---

**Consulta el README principal para info global o contacta al equipo para soporte específico.**
