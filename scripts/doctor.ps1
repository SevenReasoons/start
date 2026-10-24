# ==============================================================================
# 🩺 Antigravity Environment Doctor (Diagnostico de Salud y Alineacion)
# ==============================================================================
param (
  [int]$Role = 0
)

$ErrorActionPreference = "Continue"Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host " [DOCTOR] ANTIGRAVITY ENVIRONMENT & TEAM ALIGNMENT" -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------------------------
# 1. Seleccion de Rol para calibrar diagnostico
# ------------------------------------------------------------------------------
$roles = @(
  "Awareness   [Nivel 1] - Ventas & Prototipos interactivos (<24h)",
  "Maker       [Nivel 2] - Frontend Atómico Next.js & DB Familia 2 (Handoff a Senior)",
  "Consultant  [Nivel 3] - Fullstack Intermedio (APIs, Stripe & LMS)",
  "Architect   [Nivel 4] - Ingeniero Senior (Multi-Tenant & Multi-Agente)",
  "Expert      [Nivel 5] - Deep-Tech (IoT, Ciberseguridad & 60 FPS)",
  "Director    [Nivel 6] - Lider Tecnico/CTPO (Ontologia & Global)"
)

if ($Role -lt 1 -or $Role -gt 6) {
  Write-Host "Para calibrar el diagnostico segun tu nivel de equipo:" -ForegroundColor White
  for ($r = 0; $r -lt $roles.Count; $r++) {
    $rNum = ($r + 1).ToString().PadLeft(2)
    Write-Host " [$rNum] $($roles[$r])" -ForegroundColor Magenta
  }
  Write-Host ""
  $rSelection = Read-Host "Ingresa tu rol (1-6) [Presiona Enter para Diagnostico Completo]"
  if ($rSelection) { $Role = [int]$rSelection } else { $Role = 0 }
}

$issuesFound = 0
$warningsFound = 0

Write-Host ""
Write-Host "[*] Iniciando escaneo de herramientas y entorno..." -ForegroundColor White
Write-Host ""

# ------------------------------------------------------------------------------
# CHECK 1: IDE Oficial Antigravity
# ------------------------------------------------------------------------------
$antigravityPaths = @(
  "$env:USERPROFILE\.gemini\antigravity-ide",
  "$env:USERPROFILE\.gemini\antigravity",
  "$env:LOCALAPPDATA\Programs\Antigravity",
  "$env:APPDATA\Antigravity"
)
$antigravityDetected = $false
foreach ($p in $antigravityPaths) {
  if (Test-Path $p) { $antigravityDetected = $true; break }
}
# Tambien comprobar proceso activo
$agProcess = Get-Process -Name "*antigravity*" -ErrorAction SilentlyContinue
if ($agProcess) { $antigravityDetected = $true }

if ($antigravityDetected) {
  Write-Host " [PASS] IDE Oficial: Google Antigravity IDE detectado correctamente." -ForegroundColor Green
} else {
  Write-Host " [INFO] IDE Oficial: Antigravity IDE (Verifica que este proyecto se ejecute dentro de Antigravity)." -ForegroundColor Cyan
}

# ------------------------------------------------------------------------------
# ROL AWARENESS SHORT-CIRCUIT (Cero friccion)
# ------------------------------------------------------------------------------
if ($Role -eq 1) {
  Write-Host ""
  Write-Host "========================================================" -ForegroundColor Green
  Write-Host " [ROL 1: AWARENESS] EVALUACION DE ENTORNO" -ForegroundColor Yellow
  Write-Host "========================================================" -ForegroundColor Green
  Write-Host " Entorno 100% LISTO para trabajar y vender sin friccion." -ForegroundColor Green
  Write-Host " Como Awareness, tu mision es discovery y prototipado visual en menos de 24 horas." -ForegroundColor White
  Write-Host " NO necesitas configurar Docker, ni Node.js, ni bases de datos complejas." -ForegroundColor White
  Write-Host " Solo necesitas Antigravity para editar texto y tu navegador para proyectar." -ForegroundColor White
  Write-Host " Comando para arrancar tu prototipo: .\scripts\init-project.ps1 -Role 1" -ForegroundColor Cyan
  Write-Host "========================================================" -ForegroundColor Green
  Write-Host ""
  return
}

# ------------------------------------------------------------------------------
# CHECK 2: Node.js (v20+ LTS Obligatorio)
# ------------------------------------------------------------------------------
try {
  $nodeVerRaw = node -v 2>$null
  if ($nodeVerRaw) {
    $nodeVer = [version]($nodeVerRaw.TrimStart('v'))
    if ($nodeVer.Major -ge 20) {
      Write-Host " [PASS] Node.js: $nodeVerRaw (Cumple con version LTS v20+ obligatoria)." -ForegroundColor Green
    } else {
      Write-Host " [FAIL] Node.js: $nodeVerRaw instalado. SE REQUIERE Node.js v20 LTS o superior." -ForegroundColor Red
      Write-Host "        Solucion: Instala NVM for Windows (https://github.com/coreybutler/nvm-windows) y corre: nvm install 20" -ForegroundColor Yellow
      $issuesFound++
    }
  } else {
    Write-Host " [FAIL] Node.js no encontrado en PATH." -ForegroundColor Red
    Write-Host "        Solucion: Descarga Node v20 LTS desde https://nodejs.org" -ForegroundColor Yellow
    $issuesFound++
  }
} catch {
  Write-Host " [FAIL] Error al verificar Node.js." -ForegroundColor Red
  $issuesFound++
}

# ------------------------------------------------------------------------------
# CHECK 3: Git e Identidad de Desarrollador
# ------------------------------------------------------------------------------
try {
  $gitVer = git --version 2>$null
  if ($gitVer) {
    $gitUser = git config user.name 2>$null
    $gitEmail = git config user.email 2>$null
    if ($gitUser -and $gitEmail) {
      Write-Host " [PASS] Git: $gitVer (Configurado para '$gitUser' ($gitEmail))." -ForegroundColor Green
    } else {
      Write-Host " [WARN] Git instalado pero faltan credenciales (user.name o user.email)." -ForegroundColor Yellow
      Write-Host "        Solucion: Corre: git config --global user.name 'Tu Nombre' ; git config --global user.email 'tu@empresa.com'" -ForegroundColor Yellow
      $warningsFound++
    }
  } else {
    Write-Host " [FAIL] Git no esta instalado o no se encuentra en el PATH." -ForegroundColor Red
    $issuesFound++
  }
} catch {
  Write-Host " [FAIL] Error al verificar Git." -ForegroundColor Red
  $issuesFound++
}

# ------------------------------------------------------------------------------
# CHECK 4: Aislamiento Anti-Cloud Sync (OneDrive / Dropbox Check)
# ------------------------------------------------------------------------------
$currentPath = (Get-Location).Path
if ($currentPath -match "OneDrive" -or $currentPath -match "Dropbox" -or $currentPath -match "Google Drive") {
  Write-Host " [FAIL] VIOLACION ANTI-CLOUD SYNC: El proyecto esta en una carpeta sincronizada en la nube ($currentPath)." -ForegroundColor Red
  Write-Host "        Regla 02: Mueve tu proyecto a una ruta local aislada (ej. C:\dev\ o WSL2) para evitar corrupcion de dependencias." -ForegroundColor Red
  $issuesFound++
} else {
  Write-Host " [PASS] Ubicacion de Disco: Ruta local limpia y aislada de sincronizadores cloud." -ForegroundColor Green
}

# ------------------------------------------------------------------------------
# CHECK 5: Docker (Obligatorio para Supabase Local en Maker / Architect / Expert)
# ------------------------------------------------------------------------------
try {
  $dockerVer = docker --version 2>$null
  if ($dockerVer) {
    # Comprobar si el demonio responde
    $dockerInfo = docker info 2>$null
    if ($LASTEXITCODE -eq 0) {
      Write-Host " [PASS] Docker: En ejecucion activa ($dockerVer) listo para Supabase local." -ForegroundColor Green
    } else {
      Write-Host " [WARN] Docker esta instalado pero el motor (daemon) no esta corriendo." -ForegroundColor Yellow
      Write-Host "        Solucion: Inicia Docker Desktop antes de ejecutar 'npx supabase start'." -ForegroundColor Yellow
      $warningsFound++
    }
  } else {
    Write-Host " [WARN] Docker Desktop no detectado." -ForegroundColor Yellow
    Write-Host "        Nota: Solo se requiere si vas a correr Supabase en modo local offline. Puedes usar Supabase Cloud directamente." -ForegroundColor Gray
  }
} catch {
  Write-Host " [WARN] Docker no detectado (opcional si usas Supabase Cloud)." -ForegroundColor Gray
}

# ------------------------------------------------------------------------------
# CHECK 6: Vercel CLI
# ------------------------------------------------------------------------------
try {
  $vercelVer = vercel --version 2>$null
  if ($vercelVer) {
    Write-Host " [PASS] Vercel CLI: $vercelVer detectado." -ForegroundColor Green
  } else {
    Write-Host " [INFO] Vercel CLI: No detectado globalmente. Puedes instalarlo con 'npm i -g vercel' o usar 'npx vercel'." -ForegroundColor Gray
  }
} catch {
  Write-Host " [INFO] Vercel CLI: Disponible via 'npx vercel'." -ForegroundColor Gray
}

# ------------------------------------------------------------------------------
# CHECK 7: Supabase CLI
# ------------------------------------------------------------------------------
try {
  $supabaseVer = supabase --version 2>$null
  if ($supabaseVer) {
    Write-Host " [PASS] Supabase CLI: $supabaseVer detectado." -ForegroundColor Green
  } else {
    Write-Host " [INFO] Supabase CLI: Disponible via 'npx supabase'." -ForegroundColor Gray
  }
} catch {
  Write-Host " [INFO] Supabase CLI: Disponible via 'npx supabase'." -ForegroundColor Gray
}

# ------------------------------------------------------------------------------
# RESUMEN FINAL
# ------------------------------------------------------------------------------
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
if ($issuesFound -eq 0) {
  Write-Host " [100% OK] ESTADO DEL ENTORNO: SALUDABLE Y ALINEADO" -ForegroundColor Green
  if ($warningsFound -gt 0) {
    Write-Host " Se detectaron $warningsFound advertencias menores no bloqueantes." -ForegroundColor Yellow
  }
  Write-Host " Todo tu equipo puede compilar, probar y desplegar sin sorpresas en Antigravity." -ForegroundColor White
} else {
  Write-Host " [ALERTA] SE ENCONTRARON $issuesFound PROBLEMAS BLOQUEANTES" -ForegroundColor Red
  Write-Host " Resuelve los puntos marcados en [FAIL] para garantizar compatibilidad total." -ForegroundColor Yellow
}
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
