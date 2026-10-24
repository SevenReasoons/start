# ==============================================================================
# Universal Project Scaffolder (Vercel + Supabase) - PowerShell
# 6 Roles Acumulativos de Equipo & 18 Arquetipos Maestros
# ==============================================================================
param (
  [int]$Role = 0,
  [int]$Archetype = 0,
  [string]$ProjectName = ""
)

$ErrorActionPreference = "Stop"

$roles = @(
  "Awareness   [Nivel 1] - Ventas & Prototipos interactivos en <24h (Solo Frontend)",
  "Maker       [Nivel 2] - Fullstack Junior (Familia 1: Captacion + Asistencia en DB)",
  "Consultant  [Nivel 3] - Fullstack Intermedio (Familias 2 y 3 + Asistencia en APIs)",
  "Architect   [Nivel 4] - Ingeniero Senior (Familia 4: Multi-Tenant & Multi-Agente)",
  "Expert      [Nivel 5] - Ingeniero Deep-Tech (Familia 5: IoT, Seguridad & 60 FPS)",
  "Director    [Nivel 6] - Lider Tecnico/CTPO (Ontologia de Negocio & Sistemas Globales)"
)

$archetypes = @(
  # FAMILIA 1: CAPTACION Y PRESENCIA
  "Prototipo solo front end (HTML5/CSS3/JS ultra-rapido en Vercel)",
  "Pagina web estatica (Next.js SSG / Blogs / Portafolios)",
  "Landing page dinamica (Captura de leads con Supabase DB y Zod)",
  
  # FAMILIA 2: COMERCIO, TRANSACCIONES Y MONETIZACION
  "E-Commerce B2C Transaccional (Tienda directa, carrito y checkout Stripe)",
  "Marketplace (Bilateral multi-vendedor con comisiones y Stripe Connect)",
  "Citas, Agendamiento y Reservas (Booking Engine sin double-booking)",
  "Membresias, Suscripciones y Paywall (Creator Economy con Stripe Billing)",
  "FinTech, Billetera Digital y Boveda P2P (Ledger doble partida y alta custodia)",
  
  # FAMILIA 3: COMUNIDAD, CONTENIDO Y APRENDIZAJE
  "Red social / Comunidad (Supabase Realtime, feeds y Storage)",
  "Educacion, Cursos y Academias Digitales (LMS / EdTech con diplomas)",
  
  # FAMILIA 4: OPERACIONES Y EMPRESA
  "Dashboards y Analitica (Supabase Auth, RBAC, KPIs y tablas paginadas)",
  "Software empresarial (ERP / CRM / Facturacion, inventario y auditoria)",
  "Software multitenant (Aislamiento por tenant_id y subdominios)",
  "Software multitenant global (Multi-region, catalogos y multi-moneda)",
  
  # FAMILIA 5: AUTOMATIZACION, IA Y TELEMETRIA
  "Automatizacion e Integraciones (Vercel Cron Jobs + Supabase Edge Functions)",
  "Copiloto Agentico / AI-First (Vercel AI SDK + Supabase pgvector)",
  "IoT Industrial, Telemetria y Monitoreo (Smart Factory y alertas en vivo)",
  "API Headless / BaaS (Backend puro para apps moviles o IoT)"
)

# ------------------------------------------------------------------------------
# 1. Seleccion de Rol de Equipo
# ------------------------------------------------------------------------------
if ($Role -lt 1 -or $Role -gt 6) {
  Write-Host "`n========================================================" -ForegroundColor Cyan
  Write-Host " 👥 PASO 1: SELECCION DE ROL DE EQUIPO" -ForegroundColor Yellow
  Write-Host "========================================================`n" -ForegroundColor Cyan
  Write-Host "Cual es tu rol en este proyecto?`n" -ForegroundColor White

  for ($r = 0; $r -lt $roles.Count; $r++) {
    $rNum = ($r + 1).ToString().PadLeft(2)
    Write-Host " [$rNum] $($roles[$r])" -ForegroundColor Magenta
  }
  Write-Host ""
  $rSelection = Read-Host "Elige tu rol (1-6)"
  $Role = [int]$rSelection
}

# ------------------------------------------------------------------------------
# 2. Seleccion de Arquetipo
# ------------------------------------------------------------------------------
if ($Archetype -lt 1 -or $Archetype -gt 18) {
  Write-Host "`n========================================================" -ForegroundColor Cyan
  Write-Host " 🏛️ PASO 2: LA TABLA PERIODICA DEL SOFTWARE" -ForegroundColor Yellow
  Write-Host "========================================================`n" -ForegroundColor Cyan
  Write-Host "Que tipo de proyecto deseas construir hoy?`n" -ForegroundColor White

  for ($i = 0; $i -lt $archetypes.Count; $i++) {
    if ($i -eq 0)  { Write-Host "FAMILIA 1: CAPTACION Y PRESENCIA" -ForegroundColor DarkCyan }
    if ($i -eq 3)  { Write-Host "`nFAMILIA 2: COMERCIO, TRANSACCIONES Y MONETIZACION" -ForegroundColor DarkCyan }
    if ($i -eq 8)  { Write-Host "`nFAMILIA 3: COMUNIDAD, CONTENIDO Y APRENDIZAJE" -ForegroundColor DarkCyan }
    if ($i -eq 10) { Write-Host "`nFAMILIA 4: OPERACIONES Y EMPRESA" -ForegroundColor DarkCyan }
    if ($i -eq 14) { Write-Host "`nFAMILIA 5: AUTOMATIZACION, IA Y TELEMETRIA" -ForegroundColor DarkCyan }
    
    $numStr = ($i + 1).ToString().PadLeft(2)
    Write-Host " [$numStr] $($archetypes[$i])" -ForegroundColor Green
  }
  Write-Host ""
  $selection = Read-Host "Elige un arquetipo (1-18)"
  $Archetype = [int]$selection
}

if (-not $ProjectName) {
  $ProjectName = Read-Host "Ingresa el nombre del proyecto (slug en kebab-case, ej. mi-proyecto)"
  if (-not $ProjectName) { $ProjectName = "mi-proyecto" }
}

$roleName = $roles[$Role - 1].Split('[')[0].Trim()
$archetypeName = $archetypes[$Archetype - 1]
Write-Host "`nAprovisionando para Rol: [$roleName] | Arquetipo: $Archetype - $archetypeName ..." -ForegroundColor Cyan

# Directorios comunes
New-Item -ItemType Directory -Path ".github/workflows" -Force | Out-Null

# ------------------------------------------------------------------------------
# MODO AWARENESS (Cualquier arquetipo encapsulado en Frontend Puro con Mock Data)
# ------------------------------------------------------------------------------
if ($Role -eq 1) {
  Write-Host "🎯 Activando MODO PROTOTIPO DE VENTA AWARENESS (<24 Horas)..." -ForegroundColor Yellow
  New-Item -ItemType Directory -Path "css", "js", "assets" -Force | Out-Null

  $prototypeHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$ProjectName - Prototipo de Venta</title>
  <link rel="stylesheet" href="css/styles.css" />
  <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
  <div class="glass-card">
    <div class="badge">PROTOTIPO FUNCIONAL &bull; $roleName</div>
    <h1 id="title">$ProjectName</h1>
    <p id="desc">Demostracion interactiva de alta fidelidad: $archetypeName.</p>
    <div id="demoContent" class="interactive-area">
      <!-- Inyectado por js/mock-data.js -->
    </div>
    <button id="primaryAction" class="btn">Interactuar con Demostracion</button>
  </div>
  <script src="js/mock-data.js"></script>
  <script src="js/app.js"></script>
</body>
</html>
"@
  Set-Content -Path "index.html" -Encoding UTF8 -Value $prototypeHtml

  $prototypeCss = @'
:root { --primary: #6366f1; --primary-hover: #4f46e5; --bg: #030712; --card-bg: rgba(255, 255, 255, 0.04); --border: rgba(255, 255, 255, 0.1); }
body { margin: 0; min-height: 100dvh; display: grid; place-items: center; background: radial-gradient(circle at 50% 0%, #1e1b4b 0%, var(--bg) 75%); color: #f9fafb; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; padding: 1rem; }
.glass-card { width: 100%; max-width: 520px; background: var(--card-bg); backdrop-filter: blur(24px); border: 1px solid var(--border); border-radius: 28px; padding: 2.5rem; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); text-align: center; }
.badge { display: inline-block; padding: 0.25rem 0.75rem; border-radius: 9999px; background: rgba(99, 102, 241, 0.15); border: 1px solid rgba(99, 102, 241, 0.3); color: #a5b4fc; font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em; margin-bottom: 1.25rem; }
h1 { font-size: 2rem; font-weight: 800; letter-spacing: -0.025em; margin: 0 0 0.5rem 0; }
p { color: #9ca3af; font-size: 0.95rem; line-height: 1.5; margin: 0 0 1.75rem 0; }
.interactive-area { background: rgba(0, 0, 0, 0.3); border: 1px solid var(--border); border-radius: 16px; padding: 1.25rem; margin-bottom: 1.5rem; text-align: left; font-size: 0.875rem; }
.btn { width: 100%; min-height: 44px; background: var(--primary); color: white; border: none; border-radius: 14px; font-weight: 600; font-size: 0.95rem; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3); }
.btn:hover { background: var(--primary-hover); transform: translateY(-2px); box-shadow: 0 20px 25px -5px rgba(99, 102, 241, 0.4); }
'@
  Set-Content -Path "css/styles.css" -Encoding UTF8 -Value $prototypeCss

  $mockJs = @"
window.PROJECT_MOCK_DATA = {
  archetypeId: $Archetype,
  archetypeName: "$archetypeName",
  sampleItems: [
    { id: 1, name: "Elemento de Muestra Alfa", status: "Activo", metric: "99.8%" },
    { id: 2, name: "Elemento de Muestra Beta", status: "En Proceso", metric: "450 ms" }
  ]
};
"@
  Set-Content -Path "js/mock-data.js" -Encoding UTF8 -Value $mockJs

  $appJs = @'
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("demoContent");
  const data = window.PROJECT_MOCK_DATA;
  if (container && data) {
    container.innerHTML = `
      <div style="font-weight:600; margin-bottom:0.5rem; color:#c7d2fe;">${data.archetypeName}</div>
      <div style="display:flex; justify-content:space-between; padding:0.5rem 0; border-top:1px solid rgba(255,255,255,0.08);">
        <span>${data.sampleItems[0].name}</span>
        <strong style="color:#34d399;">${data.sampleItems[0].metric}</strong>
      </div>
    `;
  }
  document.getElementById("primaryAction")?.addEventListener("click", () => {
    alert("¡Interaccion simulada completada! Listo para presentar al cliente.");
  });
  if (window.lucide) { window.lucide.createIcons(); }
});
'@
  Set-Content -Path "js/app.js" -Encoding UTF8 -Value $appJs
  Set-Content -Path "vercel.json" -Encoding UTF8 -Value '{"cleanUrls":true,"trailingSlash":false}'

  Write-Host "✅ ¡Prototipo de Venta para [$ProjectName] listo en modo Awareness!" -ForegroundColor Green
  Write-Host "🚀 Abre 'index.html' o corre 'npx vercel dev' para proyectarlo a tu cliente en < 24h.`n" -ForegroundColor Yellow
  return
}

# ------------------------------------------------------------------------------
# MODOS FULLSTACK (Roles 2 a 6: Maker, Consultant, Architect, Expert, Director)
# ------------------------------------------------------------------------------
New-Item -ItemType Directory -Path "supabase/migrations" -Force | Out-Null

switch ($Archetype) {
  1 {
    # Prototipo solo front end
    New-Item -ItemType Directory -Path "css", "js", "assets" -Force | Out-Null
    Set-Content -Path "vercel.json" -Encoding UTF8 -Value '{"cleanUrls":true,"trailingSlash":false}'
  }

  3 {
    # Landing Page Dinámica (Maker)
    New-Item -ItemType Directory -Path "src/app/[locale]", "src/actions", "src/lib/supabase", "src/lib/schemas", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"hero":{"title":"La solucion definitiva","cta":"Unirme a la lista de espera"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"hero":{"title":"The ultimate solution","cta":"Join the waitlist"}}'
    
    $leadsSql = @'
CREATE TABLE IF NOT EXISTS public.leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT NOT NULL UNIQUE,
  full_name TEXT,
  preferred_locale VARCHAR(5) DEFAULT 'es',
  utm_source TEXT,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Permitir insercion anonima de leads" ON public.leads FOR INSERT WITH CHECK (true);
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_leads_table.sql" -Encoding UTF8 -Value $leadsSql
  }

  6 {
    # Citas y Reservas (Consultant)
    New-Item -ItemType Directory -Path "src/app/[locale]/(booking)", "src/actions", "src/lib/calendar", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"booking":{"title":"Agendar Cita","select_time":"Selecciona tu horario"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"booking":{"title":"Book Appointment","select_time":"Select a time slot"}}'

    $bookingSql = @'
CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE TABLE IF NOT EXISTS public.service_providers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS public.appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  provider_id UUID REFERENCES public.service_providers(id) ON DELETE CASCADE,
  customer_name TEXT NOT NULL,
  customer_email TEXT NOT NULL,
  slot_range TSTZRANGE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  EXCLUDE USING gist (provider_id WITH =, slot_range WITH &&)
);
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_booking_schema.sql" -Encoding UTF8 -Value $bookingSql
  }

  7 {
    # Membresías y Paywall (Consultant)
    New-Item -ItemType Directory -Path "src/app/[locale]/(membership)", "src/app/api/stripe/webhook", "src/lib/stripe", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"membership":{"tiers":"Niveles de Membresia","subscribe":"Suscribirme"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"membership":{"tiers":"Membership Tiers","subscribe":"Subscribe"}}'

    $subSql = @'
CREATE TABLE IF NOT EXISTS public.subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  stripe_customer_id TEXT UNIQUE,
  stripe_subscription_id TEXT UNIQUE,
  status TEXT NOT NULL,
  price_id TEXT NOT NULL,
  current_period_end TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Usuarios leen su propia suscripcion" ON public.subscriptions FOR SELECT USING (auth.uid() = user_id);
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_subscriptions_schema.sql" -Encoding UTF8 -Value $subSql
  }

  8 {
    # FinTech & Billetera P2P (Expert / Architect)
    New-Item -ItemType Directory -Path "src/app/[locale]/(wallet)", "src/actions", "src/lib/ledger", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"wallet":{"balance":"Saldo Disponible","transfer":"Transferir Fondos"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"wallet":{"balance":"Available Balance","transfer":"Transfer Funds"}}'

    $walletSql = @'
CREATE TABLE IF NOT EXISTS public.wallets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) UNIQUE,
  currency VARCHAR(3) DEFAULT 'USD',
  balance NUMERIC(15,2) DEFAULT 0.00 CHECK (balance >= 0),
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS public.ledger_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_wallet_id UUID REFERENCES public.wallets(id),
  destination_wallet_id UUID REFERENCES public.wallets(id),
  amount NUMERIC(15,2) NOT NULL CHECK (amount > 0),
  reference_note TEXT,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
ALTER TABLE public.wallets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ledger_entries ENABLE ROW LEVEL SECURITY;
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_ledger_schema.sql" -Encoding UTF8 -Value $walletSql
  }

  10 {
    # Educación / LMS (Consultant)
    New-Item -ItemType Directory -Path "src/app/[locale]/(lms)/cursos", "src/components/video", "src/lib/certificates", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"lms":{"courses":"Mis Cursos","continue":"Continuar leccion"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"lms":{"courses":"My Courses","continue":"Continue lesson"}}'

    $lmsSql = @'
CREATE TABLE IF NOT EXISTS public.courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title JSONB NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  is_published BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS public.lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID REFERENCES public.courses(id) ON DELETE CASCADE,
  title JSONB NOT NULL,
  video_url TEXT NOT NULL,
  duration_seconds INT DEFAULT 0,
  order_index INT NOT NULL
);
CREATE TABLE IF NOT EXISTS public.user_progress (
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT false,
  last_watched_seconds INT DEFAULT 0,
  PRIMARY KEY (user_id, lesson_id)
);
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_lms_schema.sql" -Encoding UTF8 -Value $lmsSql
  }

  17 {
    # IoT Industrial & Telemetría (Expert)
    New-Item -ItemType Directory -Path "src/app/[locale]/(iot)", "src/lib/iot", "src/components/telemetry", "src/messages" -Force | Out-Null
    Set-Content -Path "src/messages/es.json" -Encoding UTF8 -Value '{"iot":{"factory":"Lineas de Produccion","sensors":"Sensores en Tiempo Real"}}'
    Set-Content -Path "src/messages/en.json" -Encoding UTF8 -Value '{"iot":{"factory":"Production Lines","sensors":"Real-time Sensors"}}'

    $iotSql = @'
CREATE TABLE IF NOT EXISTS public.iot_devices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  device_name TEXT NOT NULL,
  device_type TEXT NOT NULL,
  location_zone TEXT,
  is_online BOOLEAN DEFAULT true,
  last_seen TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS public.telemetry_logs (
  id BIGSERIAL PRIMARY KEY,
  device_id UUID REFERENCES public.iot_devices(id) ON DELETE CASCADE,
  metric_name TEXT NOT NULL,
  metric_value NUMERIC NOT NULL,
  unit VARCHAR(10),
  recorded_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
ALTER TABLE public.iot_devices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.telemetry_logs ENABLE ROW LEVEL SECURITY;
ALTER PUBLICATION supabase_realtime ADD TABLE public.telemetry_logs;
'@
    Set-Content -Path "supabase/migrations/20261024000000_create_iot_schema.sql" -Encoding UTF8 -Value $iotSql
  }

  default {
    # Estructura Enterprise Modular
    New-Item -ItemType Directory -Path "apps/web/app/[locale]", "apps/web/components/ui", "apps/web/lib/supabase", "apps/web/messages", "packages/ui", "packages/database" -Force | Out-Null
    Set-Content -Path "apps/web/messages/es.json" -Encoding UTF8 -Value '{"common":{"welcome":"Bienvenido"}}'
    Set-Content -Path "apps/web/messages/en.json" -Encoding UTF8 -Value '{"common":{"welcome":"Welcome"}}'
  }
}

# Archivo de entorno canonico
if (-not (Test-Path ".env.example")) {
  $envContent = @'
NODE_ENV=development
PORT=3000

# Supabase Local o Cloud (https://app.supabase.com)
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-aqui
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key-secreta

# Vercel & App URL
NEXT_PUBLIC_APP_URL=http://localhost:3000
'@
  Set-Content -Path ".env.example" -Encoding UTF8 -Value $envContent
}

Write-Host "`nEstructura para [$ProjectName] aprovisionada exitosamente para rol [$roleName]!" -ForegroundColor Green
Write-Host "Proximos pasos:" -ForegroundColor Yellow
Write-Host " 1. Copia .env.example a .env.local y anade tus credenciales de Supabase." -ForegroundColor White
Write-Host " 2. Ejecuta 'npm run dev' o 'npx vercel dev' para arrancar el servidor local." -ForegroundColor White
