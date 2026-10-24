# ==============================================================================
# SEVEN REASOONS DOCUMENTATION ENGINE (reasoons-documentar)
# Escanea el proyecto, descubre todas las rutas y paginas, y genera la estructura
# de la "Documentacion Oficial" para el cliente final y equipo de soporte.
# ==============================================================================
param (
  [string]$ProjectPath = ".",
  [string]$DocsDirName = "documentacion-oficial"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host " [*] SEVEN REASOONS DOCUMENTATION ENGINE (reasoons-documentar)" -ForegroundColor Yellow
Write-Host "     Generador de Documentacion Oficial del Proyecto Ruta por Ruta" -ForegroundColor White
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

$resolvedProject = (Resolve-Path $ProjectPath).Path
$targetDocsDir = Join-Path $resolvedProject $DocsDirName
$routesDir = Join-Path $targetDocsDir "rutas"

New-Item -ItemType Directory -Path $targetDocsDir -Force | Out-Null
New-Item -ItemType Directory -Path $routesDir -Force | Out-Null

Write-Host "[*] Escaneando proyecto en: $resolvedProject" -ForegroundColor White

# 1. Buscar paginas y rutas
$pageFiles = @()
$searchPaths = @("src/app", "app", "apps/web/app", "pages", "src/pages")

foreach ($sp in $searchPaths) {
  $fullPath = Join-Path $resolvedProject $sp
  if (Test-Path $fullPath) {
    $found = Get-ChildItem -Path $fullPath -Recurse -File -Include "page.tsx", "page.jsx", "page.js", "page.ts"
    if ($found) { $pageFiles += $found }
  }
}

# Caso prototipo HTML plano
$isPrototype = $false
if ($pageFiles.Count -eq 0 -and (Test-Path (Join-Path $resolvedProject "index.html"))) {
  $isPrototype = $true
  $pageFiles += (Get-Item (Join-Path $resolvedProject "index.html"))
}

Write-Host "   Rutas/Paginas encontradas: $($pageFiles.Count)" -ForegroundColor Green

# 2. Generar Documento por cada Ruta
$routeList = @()

foreach ($file in $pageFiles) {
  $relPath = $file.FullName.Substring($resolvedProject.Length).TrimStart('\', '/')
  
  if ($isPrototype) {
    $routeUrl = "/"
    $docSlug = "01_inicio_prototipo"
    $pageTitle = "Pagina Principal / Demostracion Interactiva"
  } else {
    $dirPart = (Split-Path $relPath -Parent) -replace '^(src[\\/])?app[\\/]?', '' -replace '^(src[\\/])?pages[\\/]?', '' -replace 'apps[\\/]web[\\/]app[\\/]?', ''
    $urlSegments = $dirPart -split '[\\/]' | Where-Object { $_ -and $_ -notmatch '^\(.*\)$' }
    if ($urlSegments.Count -eq 0) {
      $routeUrl = "/"
      $docSlug = "01_inicio"
      $pageTitle = "Pagina de Inicio (Home)"
    } else {
      $routeUrl = "/" + ($urlSegments -join "/")
      $docSlug = ($urlSegments -join "_") -replace '[^a-zA-Z0-9_-]', '-'
      $pageTitle = ($urlSegments[-1] -replace '[-_]', ' ').ToUpper()
    }
  }

  $routeList += [PSCustomObject]@{
    Url = $routeUrl
    Title = $pageTitle
    File = $relPath
    DocSlug = $docSlug
  }

  $routeDocPath = Join-Path $routesDir "$docSlug.md"
  
  if (-not (Test-Path $routeDocPath)) {
    $docLines = @(
      "# Pantalla: $pageTitle",
      "> **Ruta en la Aplicacion:** ``$routeUrl``",
      "> **Archivo Fuente:** ``$relPath``",
      "> **Estado:** Documentado oficialmente para el cliente",
      "",
      "---",
      "",
      "## 1. Proposito de esta Pantalla",
      "Describe aqui la mision principal de esta pantalla dentro de la experiencia del usuario y del modelo de negocio del cliente.",
      "",
      "---",
      "",
      "## 2. Funcionalidades Disponibles para el Usuario",
      "Detalla cada una de las acciones que el usuario puede realizar en esta vista:",
      "- **Accion Principal:** (Ej. Registrarse, Comprar, Agendar, Filtrar datos).",
      "- **Interacciones Secundarias:** (Ej. Navegar a otras vistas, descargar comprobantes, editar perfil).",
      "- **Botones y Llamados a la Accion (CTA):** Comportamiento al hacer clic.",
      "",
      "---",
      "",
      "## 3. Formularios y Datos Solicitados",
      "Si esta pantalla recopila informacion:",
      "- **Campos del Formulario:** Lista de campos, formatos requeridos y obligatoriedad.",
      "- **Validaciones en Tiempo Real:** Reglas aplicadas (longitud minima, formato de email, RFC, etc.).",
      "- **Mensajes de Confirmacion / Error:** Que se le muestra al usuario al enviar exitosamente o si hay un fallo.",
      "",
      "---",
      "",
      "## 4. Informacion Conectada al Sistema (Backend)",
      "- **Datos que Muestra:** De donde proviene la informacion proyectada en la pantalla (Tablas de Supabase / Base de datos).",
      "- **Datos que Guarda o Modifica:** Que registros crea o actualiza al confirmar una accion.",
      "- **Seguridad y Permisos:** Quien puede acceder a esta pantalla (Publico, Usuario autenticado, Administrador).",
      "",
      "---",
      "",
      "## 5. Flujo Paso a Paso del Usuario (User Journey)",
      "1. El usuario entra a ``$routeUrl``.",
      "2. Observa la informacion principal y los indicadores.",
      "3. Realiza la accion deseada.",
      "4. El sistema valida los datos y responde de forma inmediata.",
      "5. El usuario recibe confirmacion visual.",
      "",
      "---",
      "*Documentacion generada con amor por Seven Reasoons -- Soporte oficial: 5649328703*"
    )
    $docLines -join "`r`n" | Set-Content -Path $routeDocPath -Encoding UTF8
    Write-Host "   [+] Creado documento de ruta: rutas/$docSlug.md" -ForegroundColor Gray
  }
}

# 3. Generar Indice General (00_indice_general.md)
$indiceDocPath = Join-Path $targetDocsDir "00_indice_general.md"

$tableRows = @()
foreach ($r in $routeList) {
  $tableRows += "| ``$($r.Url)`` | **$($r.Title)** | ``$($r.File)`` | [Ver Detalle](rutas/$($r.DocSlug).md) |"
}
$tableContent = $tableRows -join "`r`n"

$indiceLines = @(
  "# Documentacion Oficial del Proyecto -- Manual de Funcionalidades",
  "",
  "> **Documentacion ejecutiva y funcional entregable al cliente.**",
  "> Este manual describe de forma clara y exhaustiva cada una de las paginas, rutas y capacidades que componen la plataforma.",
  "",
  "---",
  "",
  "## Mapa de Navegacion del Sistema (Rutas Activas)",
  "",
  "A continuacion se presenta el inventario completo de pantallas desarrolladas en esta aplicacion:",
  "",
  "| Ruta (URL) | Nombre de Pantalla | Archivo Fuente | Documento de Detalle |",
  "|---|---|---|---|",
  $tableContent,
  "",
  "---",
  "",
  "## Stack Tecnologico y Arquitectura Base",
  "- **Alojamiento y Computacion:** Vercel (Edge Network de alta velocidad y 99.99% disponibilidad).",
  "- **Base de Datos y Autenticacion:** Supabase PostgreSQL con seguridad estricta a nivel de fila (Row Level Security).",
  "- **Diseno e Interfaz:** Tema Claro de alto impacto, mobile-first y optimizado a 60 FPS.",
  "- **Soporte Bilingue:** Arquitectura preparada para Espanol e Ingles nativo.",
  "",
  "---",
  "",
  "## Soporte y Atencion al Cliente",
  "- **Canal Oficial de Atencion:** WhatsApp ``5649328703`` (https://wa.me/525649328703)",
  "- **Compromiso de Respuesta:** Menos de una hora.",
  "- **Holding:** *Made with love by Seven Reasoons*"
)
$indiceLines -join "`r`n" | Set-Content -Path $indiceDocPath -Encoding UTF8
Write-Host "   [PASS] Indice general generado: 00_indice_general.md" -ForegroundColor Green

# 4. Generar Guia de Administracion del Negocio
$adminDocPath = Join-Path $targetDocsDir "99_guia_de_administracion.md"
if (-not (Test-Path $adminDocPath)) {
  $adminLines = @(
    "# Guia de Administracion y Operacion del Negocio",
    "",
    "> **Manual de operacion para el dueno del producto y administradores.**",
    "",
    "---",
    "",
    "## 1. Como Monitorear tu Plataforma",
    "- **Acceso a la Base de Datos:** A traves del panel oficial de Supabase.",
    "- **Revision de Metricas:** Visualizacion de visitas, conversiones y tiempos de carga en Vercel Analytics.",
    "",
    "## 2. Gestion de Usuarios y Seguridad",
    "- Todas las contrasenas estan cifradas y los accesos protegidos por politicas RLS (Row Level Security).",
    "- Los administradores pueden visualizar altas de clientes y registros en tiempo real.",
    "",
    "## 3. Protocolo ante Incidencias",
    "En caso de requerir soporte tecnico o actualizaciones:",
    "1. Contactar a soporte Seven Reasoons por WhatsApp al **5649328703**.",
    "2. Indicar la ruta o pantalla donde se detecto el detalle.",
    "3. Tiempo de respuesta garantizado: **Menos de una hora**."
  )
  $adminLines -join "`r`n" | Set-Content -Path $adminDocPath -Encoding UTF8
  Write-Host "   [PASS] Guia de administracion creada: 99_guia_de_administracion.md" -ForegroundColor Green
}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Green
Write-Host " [PASS] DOCUMENTACION OFICIAL GENERADA EN: $targetDocsDir" -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Green
Write-Host ""
