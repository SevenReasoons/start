# ==============================================================================
# SEVEN REASOONS UNIVERSAL PROJECT STARTER (reasoons-start)
# Clona SevenReasoons/start, aprovisiona Rol + Arquetipo, instala dependencias
# y configura extensiones de Antigravity IDE / VS Code en una carpeta nueva.
# ==============================================================================
param (
  [string]$ProjectName = "",
  [int]$Role = 0,
  [int]$Archetype = 0,
  [string]$DestinationPath = "",
  [switch]$SkipInstall,
  [switch]$InstallExtensions,
  [string]$SourceRepo = "https://github.com/SevenReasoons/start.git"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host " [*] SEVEN REASOONS PROJECT STARTER (reasoons-start)" -ForegroundColor Yellow
Write-Host "     Arranque interactivo llave en mano de proyectos en carpeta independiente" -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

$roles = @(
  "Awareness   [Nivel 1] - Ventas & Prototipos interactivos en <24h (Solo Frontend)",
  "Maker       [Nivel 2] - Frontend Atomico Next.js & DB Familia 2 (Handoff a Senior)",
  "Consultant  [Nivel 3] - Fullstack Intermedio (Familias 2 y 3 + Asistencia en APIs)",
  "Architect   [Nivel 4] - Ingeniero Senior (Familia 4: Multi-Tenant & Multi-Agente)",
  "Expert      [Nivel 5] - Ingeniero Deep-Tech (Familia 5: IoT, Seguridad & 60 FPS)",
  "Director    [Nivel 6] - Lider Tecnico/CTPO (Ontologia de Negocio & Sistemas Globales)"
)

$archetypes = @(
  "Prototipo solo front end (HTML5/CSS3/JS ultra-rapido en Vercel)",
  "Pagina web estatica (Next.js SSG / Blogs / Portafolios)",
  "Landing page dinamica (Captura de leads con Supabase DB y Zod)",
  "E-Commerce B2C Transaccional (Tienda directa, carrito y checkout Stripe)",
  "Marketplace (Bilateral multi-vendedor con comisiones y Stripe Connect)",
  "Citas, Agendamiento y Reservas (Booking Engine sin double-booking)",
  "Membresias, Suscripciones y Paywall (Creator Economy con Stripe Billing)",
  "FinTech, Billetera Digital y Boveda P2P (Ledger doble partida y alta custodia)",
  "Red social / Comunidad (Supabase Realtime, feeds y Storage)",
  "Educacion, Cursos y Academias Digitales (LMS / EdTech con diplomas)",
  "Dashboards y Analitica (Supabase Auth, RBAC, KPIs y tablas paginadas)",
  "Software empresarial (ERP / CRM / Facturacion, inventario y auditoria)",
  "Software multitenant (Aislamiento por tenant_id y subdominios)",
  "Software multitenant global (Multi-region, catalogos y multi-moneda)",
  "Automatizacion e Integraciones (Vercel Cron Jobs + Supabase Edge Functions)",
  "Copiloto Agentico / AI-First (Vercel AI SDK + Supabase pgvector)",
  "IoT Industrial, Telemetria y Monitoreo (Smart Factory y alertas en vivo)",
  "API Headless / BaaS (Backend puro para apps moviles o IoT)"
)

# ------------------------------------------------------------------------------
# 1. Nombre del Proyecto
# ------------------------------------------------------------------------------
if (-not $ProjectName) {
  $ProjectName = Read-Host "1. Ingresa el nombre del nuevo proyecto (slug en kebab-case, ej. mi-nueva-app)"
  if (-not $ProjectName) { $ProjectName = "mi-nuevo-proyecto" }
}

$ProjectName = $ProjectName.ToLower().Trim() -replace '[^a-z0-9-_]', '-' -replace '-+', '-'

# ------------------------------------------------------------------------------
# 2. Seleccion de Rol
# ------------------------------------------------------------------------------
if ($Role -lt 1 -or $Role -gt 6) {
  Write-Host "`n2. Selecciona tu Rol de Equipo:" -ForegroundColor Yellow
  for ($r = 0; $r -lt $roles.Count; $r++) {
    $rNum = ($r + 1).ToString().PadLeft(2)
    Write-Host "   [$rNum] $($roles[$r])" -ForegroundColor Magenta
  }
  Write-Host ""
  $rSelection = Read-Host "Elige tu rol (1-6)"
  $Role = [int]$rSelection
}
$roleName = $roles[$Role - 1].Split('[')[0].Trim()

# ------------------------------------------------------------------------------
# 3. Seleccion de Arquetipo
# ------------------------------------------------------------------------------
if ($Archetype -lt 1 -or $Archetype -gt 18) {
  Write-Host "`n3. Selecciona el Arquetipo de Software (Tabla Periodica):" -ForegroundColor Yellow
  for ($i = 0; $i -lt $archetypes.Count; $i++) {
    if ($i -eq 0)  { Write-Host "   FAMILIA 1: CAPTACION Y PRESENCIA" -ForegroundColor DarkCyan }
    if ($i -eq 3)  { Write-Host "`n   FAMILIA 2: COMERCIO, TRANSACCIONES Y MONETIZACION" -ForegroundColor DarkCyan }
    if ($i -eq 8)  { Write-Host "`n   FAMILIA 3: COMUNIDAD, CONTENIDO Y APRENDIZAJE" -ForegroundColor DarkCyan }
    if ($i -eq 10) { Write-Host "`n   FAMILIA 4: OPERACIONES Y EMPRESA" -ForegroundColor DarkCyan }
    if ($i -eq 14) { Write-Host "`n   FAMILIA 5: AUTOMATIZACION, IA Y TELEMETRIA" -ForegroundColor DarkCyan }
    
    $numStr = ($i + 1).ToString().PadLeft(2)
    Write-Host "   [$numStr] $($archetypes[$i])" -ForegroundColor Green
  }
  Write-Host ""
  $selection = Read-Host "Elige un arquetipo (1-18)"
  $Archetype = [int]$selection
}
$archetypeName = $archetypes[$Archetype - 1]

# ------------------------------------------------------------------------------
# 4. Carpeta Destino
# ------------------------------------------------------------------------------
$templateRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$parentDir = (Resolve-Path (Join-Path $templateRoot "..")).Path

if (-not $DestinationPath) {
  $DestinationPath = Join-Path $parentDir $ProjectName
}

Write-Host "`nCarpeta destino: $DestinationPath" -ForegroundColor Cyan

if (Test-Path $DestinationPath) {
  $existingFiles = Get-ChildItem -Path $DestinationPath -Force
  if ($existingFiles.Count -gt 0) {
    Write-Host "AVISO: La carpeta destino [$DestinationPath] ya existe y contiene archivos." -ForegroundColor Yellow
    $confirm = Read-Host "Deseas continuar y sobreescribir archivos comunes? (s/n)"
    if ($confirm -ne "s" -and $confirm -ne "S") {
      Write-Host "Operacion cancelada por el usuario." -ForegroundColor Red
      return
    }
  }
} else {
  New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null
}

# ------------------------------------------------------------------------------
# 5. Clonado del Repositorio Original o Copia de Plantilla
# ------------------------------------------------------------------------------
Write-Host "`nInicializando proyecto base desde plantilla..." -ForegroundColor Cyan

$clonedViaGit = $false
try {
  $isEmpty = (Get-ChildItem -Path $DestinationPath -Force).Count -eq 0
  if ($isEmpty) {
    Write-Host "   Intentando clonar repositorio oficial ($SourceRepo)..." -ForegroundColor Gray
    git clone --depth 1 $SourceRepo $DestinationPath 2>$null
    if ($LASTEXITCODE -eq 0 -and (Test-Path (Join-Path $DestinationPath "scripts"))) {
      $clonedViaGit = $true
      Write-Host "   [PASS] Clonado exitoso desde GitHub." -ForegroundColor Green
    }
  }
} catch {
  $clonedViaGit = $false
}

if (-not $clonedViaGit) {
  Write-Host "   Copiando plantilla maestra local..." -ForegroundColor Gray
  $excludeList = @(".git", "node_modules", ".next", "dist", "build", ".turbo")
  Get-ChildItem -Path $templateRoot -Force | Where-Object { $excludeList -notcontains $_.Name } | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $DestinationPath -Recurse -Force | Out-Null
  }
  Write-Host "   [PASS] Plantilla maestra copiada exitosamente." -ForegroundColor Green
}

# ------------------------------------------------------------------------------
# 6. Reinicializar Git para Proyecto Nuevo e Independiente
# ------------------------------------------------------------------------------
Push-Location $DestinationPath
try {
  if (Test-Path ".git") {
    Remove-Item -Path ".git" -Recurse -Force -ErrorAction SilentlyContinue
  }
  git init 2>$null | Out-Null
  git branch -M main 2>$null | Out-Null
  Write-Host "   [PASS] Repositorio Git limpio inicializado en rama main." -ForegroundColor Green
} catch {
  Write-Host "   [INFO] Git no disponible o ya configurado." -ForegroundColor Gray
}

# ------------------------------------------------------------------------------
# 7. Aprovisionamiento Fisico del Arquetipo y Rol
# ------------------------------------------------------------------------------
Write-Host "`nAprovisionando Arquetipo $Archetype ($archetypeName) para Rol $roleName..." -ForegroundColor Cyan
& powershell -ExecutionPolicy Bypass -File (Join-Path $DestinationPath "scripts\init-project.ps1") -Role $Role -Archetype $Archetype -ProjectName $ProjectName

# ------------------------------------------------------------------------------
# 8. Configuracion e Instalacion de Extensiones del IDE
# ------------------------------------------------------------------------------
Write-Host "`nConfigurando extensiones recomendadas de Antigravity IDE / VS Code..." -ForegroundColor Cyan

$extensionsJsonPath = Join-Path $DestinationPath ".vscode\extensions.json"
New-Item -ItemType Directory -Path (Join-Path $DestinationPath ".vscode") -Force | Out-Null

$extensionsList = @(
  "bradlc.vscode-tailwindcss",
  "dbaeumer.vscode-eslint",
  "esbenp.prettier-vscode",
  "supabase.supabase-vscode",
  "vercel.vercel-vscode",
  "lokalise.i18n-ally",
  "usernamehw.errorlens",
  "tamasfe.even-better-toml",
  "eamodio.gitlens"
)

$extObj = @{ recommendations = $extensionsList }
$extObj | ConvertTo-Json -Depth 4 | Set-Content -Path $extensionsJsonPath -Encoding UTF8

if ($InstallExtensions) {
  $codeCmd = Get-Command "code" -ErrorAction SilentlyContinue
  if ($codeCmd) {
    Write-Host "   Instalando extensiones via CLI de VS Code / Antigravity..." -ForegroundColor Gray
    foreach ($ext in $extensionsList) {
      & code --install-extension $ext --force 2>$null | Out-Null
    }
    Write-Host "   [PASS] Extensiones instaladas." -ForegroundColor Green
  }
}

# ------------------------------------------------------------------------------
# 9. Instalacion de Dependencias
# ------------------------------------------------------------------------------
if ($Role -eq 1) {
  Write-Host "`n[Modo Awareness]: Prototipo de venta ultrarrapido (<24h)." -ForegroundColor Green
  Write-Host "   Cero dependencias pesadas. Sin esperar instalaciones de npm." -ForegroundColor Green
} else {
  if (-not $SkipInstall) {
    Write-Host "`nInstalando dependencias de Node.js..." -ForegroundColor Cyan
    if (Test-Path "package.json") {
      try {
        $pnpmCmd = Get-Command "pnpm" -ErrorAction SilentlyContinue
        if ($pnpmCmd) {
          Write-Host "   Ejecutando pnpm install..." -ForegroundColor Gray
          & pnpm install
        } else {
          Write-Host "   Ejecutando npm install..." -ForegroundColor Gray
          & npm install
        }
        Write-Host "   [PASS] Dependencias instaladas con exito." -ForegroundColor Green
      } catch {
        Write-Host "   [WARN] Ocurrio un error al instalar dependencias." -ForegroundColor Yellow
        Write-Host "          Puedes ejecutarlas manualmente luego con npm install." -ForegroundColor Gray
      }
    }
  } else {
    Write-Host "`n[INFO] Instalacion de dependencias omitida (-SkipInstall)." -ForegroundColor Gray
  }
}

# ------------------------------------------------------------------------------
# 10. Diagnostico de Salud (Doctor)
# ------------------------------------------------------------------------------
Write-Host "`nEjecutando diagnostico de salud (doctor.ps1)..." -ForegroundColor Cyan
try {
  & powershell -ExecutionPolicy Bypass -File (Join-Path $DestinationPath "scripts\doctor.ps1") -Role $Role
} catch {
  Write-Host "   [INFO] Diagnostico completado." -ForegroundColor Gray
}

Pop-Location

# ------------------------------------------------------------------------------
# 11. Resumen y Proximos Pasos
# ------------------------------------------------------------------------------
Write-Host ""
Write-Host "================================================================================" -ForegroundColor Green
Write-Host " PROYECTO [$ProjectName] INICIALIZADO CON EXITO!" -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Green
Write-Host "  Ubicacion:   $DestinationPath" -ForegroundColor White
Write-Host "  Rol:         [$Role] $roleName" -ForegroundColor White
Write-Host "  Arquetipo:   [$Archetype] $archetypeName" -ForegroundColor White
Write-Host ""
Write-Host "Pasos para empezar a trabajar de inmediato:" -ForegroundColor Cyan
Write-Host "  1. Abrir en Antigravity IDE:" -ForegroundColor White
Write-Host "     code `"$DestinationPath`"" -ForegroundColor Yellow
Write-Host "     cd `"$DestinationPath`"" -ForegroundColor Yellow
Write-Host ""
if ($Role -eq 1) {
  Write-Host "  2. Proyectar prototipo al cliente:" -ForegroundColor White
  Write-Host "     Doble clic en '$DestinationPath\index.html' o corre: npx vercel dev" -ForegroundColor Yellow
} else {
  Write-Host "  2. Configurar credenciales:" -ForegroundColor White
  Write-Host "     Copia .env.example a .env.local y anade tus credenciales de Supabase." -ForegroundColor White
  Write-Host "  3. Iniciar servidor local:" -ForegroundColor White
  Write-Host "     npm run dev" -ForegroundColor Yellow
}
Write-Host "================================================================================" -ForegroundColor Green
Write-Host ""
