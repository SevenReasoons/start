# Script para empaquetar el kit portable completo de Seven Reasoons
$workspaceRoot = (Get-Item "$PSScriptRoot/..").FullName
$desktopPath = [Environment]::GetFolderPath("Desktop")
$zipName = "sevenreasoons-starter-kit.zip"
$zipProjectDest = Join-Path $workspaceRoot $zipName
$zipDesktopDest = Join-Path $desktopPath $zipName

Write-Host "Iniciando empaquetado del kit portable..." -ForegroundColor Cyan

# Crear carpeta temporal limpia para armar el paquete
$tempDir = Join-Path $env:TEMP "sevenreasoons-pack-$(Get-Random)"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

# Archivos y carpetas a incluir
$itemsToCopy = @(
    ".agents",
    "scripts",
    ".vscode",
    ".github",
    "templates",
    "supabase",
    ".editorconfig",
    ".env.example",
    ".gitattributes",
    ".gitignore",
    "README.md"
)

foreach ($item in $itemsToCopy) {
    $src = Join-Path $workspaceRoot $item
    if (Test-Path $src) {
        $dest = Join-Path $tempDir $item
        if (Test-Path $src -PathType Container) {
            Copy-Item -Path $src -Destination $dest -Recurse -Force
        } else {
            Copy-Item -Path $src -Destination $dest -Force
        }
        Write-Host " [+] Incluido: $item" -ForegroundColor Green
    } else {
        Write-Host " [!] No encontrado: $item" -ForegroundColor Yellow
    }
}

# Agregar archivo LEEME_PORTABLE.md
$readmeContent = @"
# 🛸 Seven Reasoons - Kit Portable de Ingenieria y Skills

Este paquete contiene la suite completa y estandarizada de Seven Reasoons lista para usarse en cualquier computadora con **Google Antigravity IDE**.

## 📦 Contenido del Paquete:
1. **.agents/skills/**: Las 38 Skills Oficiales (`reasoons-*`) ordenadas por complejidad (18 arquetipos, 6 roles, 6 auditores, arrancador `reasoons-start`, documentador y UI/UX).
2. **.agents/standards/**: Los 15 Manuales y Estandares Normativos de Ingenieria (Arquitectura, Seguridad SHI, Mobile-First, RFC 7807, i18n, etc.).
3. **.agents/rules/**: Regla rectora `hello.md` para el ecosistema Antigravity IDE.
4. **.agents/archive/**: Playbooks historicos de marca y fundaciones.
5. **scripts/**: Scripts universales (PowerShell para Windows y Bash para Mac/Linux/WSL) para inicializar, arrancar, auditar y documentar.
6. **.vscode/**: Configuracion oficial y extensiones recomendadas.
7. **.github/workflows/**: Flujo de CI/CD para GitHub Actions.

## 🚀 Como usarlo en una computadora nueva:
1. Descomprime este archivo ZIP en la carpeta donde desees trabajar.
2. Abre la carpeta en **Google Antigravity IDE**.
3. En el chat de Antigravity escribe:
   - `@reasoons-start` para iniciar un nuevo proyecto.
   - `@reasoons-aud` para auditar cualquier componente.
4. (Opcional) Si deseas que las 38 skills esten disponibles de forma global en todos tus proyectos de esa maquina:
   Copia el contenido de `.agents/skills/` hacia:
   - En Windows: `C:\Users\<tu-usuario>\.gemini\config\skills\`
   - En Mac/Linux: `~/.gemini/config/skills/`

---
*Seven Reasoons Holding &bull; Engineering Standards 2026*
"@

Set-Content -Path (Join-Path $tempDir "LEEME_PORTABLE.md") -Value $readmeContent -Encoding UTF8
Write-Host " [+] Incluido: LEEME_PORTABLE.md" -ForegroundColor Green

# Generar el archivo ZIP
if (Test-Path $zipProjectDest) { Remove-Item -Force $zipProjectDest }
if (Test-Path $zipDesktopDest) { Remove-Item -Force $zipDesktopDest }

Write-Host "`nComprimiendo archivo ZIP..." -ForegroundColor Cyan
Add-Type -AssemblyName "System.IO.Compression.FileSystem"
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $zipProjectDest)

# Copiar tambien al escritorio del usuario para maximo acceso
Copy-Item -Path $zipProjectDest -Destination $zipDesktopDest -Force

# Limpiar temporal
Remove-Item -Recurse -Force $tempDir

$fileSizeMb = [math]::Round(((Get-Item $zipDesktopDest).Length / 1MB), 2)

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " ARCHIVO ZIP GENERADO CON EXITO!" -ForegroundColor Green
Write-Host " Ubicacion 1 (Proyecto): $zipProjectDest" -ForegroundColor White
Write-Host " Ubicacion 2 (Escritorio): $zipDesktopDest" -ForegroundColor Yellow
Write-Host " Tamano: $fileSizeMb MB" -ForegroundColor White
Write-Host "========================================================`n" -ForegroundColor Green
