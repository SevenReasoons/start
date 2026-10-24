#!/usr/bin/env bash
# ==============================================================================
# Universal Project Scaffolder (Vercel + Supabase) - Bash (Mac / Linux / WSL)
# 6 Roles Acumulativos de Equipo & 18 Arquetipos Maestros
# ==============================================================================
set -e

ROLE=${1:-0}
ARCHETYPE=${2:-0}
PROJECT_NAME=${3:-""}

roles=(
  "Awareness   [Nivel 1] - Ventas & Prototipos interactivos en <24h (Solo Frontend)"
  "Maker       [Nivel 2] - Fullstack Junior (Familia 1: Captacion + Asistencia en DB)"
  "Consultant  [Nivel 3] - Fullstack Intermedio (Familias 2 y 3 + Asistencia en APIs)"
  "Architect   [Nivel 4] - Ingeniero Senior (Familia 4: Multi-Tenant & Multi-Agente)"
  "Expert      [Nivel 5] - Ingeniero Deep-Tech (Familia 5: IoT, Seguridad & 60 FPS)"
  "Director    [Nivel 6] - Lider Tecnico/CTPO (Ontologia de Negocio & Sistemas Globales)"
)

archetypes=(
  "Prototipo solo front end (HTML5/CSS3/JS ultra-rapido en Vercel)"
  "Pagina web estatica (Next.js SSG / Blogs / Portafolios)"
  "Landing page dinamica (Captura de leads con Supabase DB y Zod)"
  "E-Commerce B2C Transaccional (Tienda directa y checkout Stripe)"
  "Marketplace (Bilateral multi-vendedor con comisiones y Stripe Connect)"
  "Citas, Agendamiento y Reservas (Booking Engine sin double-booking)"
  "Membresias, Suscripciones y Paywall (Creator Economy con Stripe Billing)"
  "FinTech, Billetera Digital y Boveda P2P (Ledger doble partida y alta custodia)"
  "Red social / Comunidad (Supabase Realtime, feeds y Storage)"
  "Educacion, Cursos y Academias Digitales (LMS / EdTech con diplomas)"
  "Dashboards y Analitica (Supabase Auth, RBAC, KPIs y tablas paginadas)"
  "Software empresarial (ERP / CRM / Facturacion, inventario y auditoria)"
  "Software multitenant (Aislamiento por tenant_id y subdominios)"
  "Software multitenant global (Multi-region, catalogos y multi-moneda)"
  "Automatizacion e Integraciones (Vercel Cron Jobs + Supabase Edge Functions)"
  "Copiloto Agentico / AI-First (Vercel AI SDK + Supabase pgvector)"
  "IoT Industrial, Telemetria y Monitoreo (Smart Factory y alertas en vivo)"
  "API Headless / BaaS (Backend puro para apps moviles o IoT)"
)

# 1. Seleccion de Rol
if [ "$ROLE" -lt 1 ] || [ "$ROLE" -gt 6 ]; then
  echo -e "\n========================================================"
  echo -e " 👥 PASO 1: SELECCION DE ROL DE EQUIPO"
  echo -e "========================================================\n"
  echo -e "Cual es tu rol en este proyecto?\n"

  for r in "${!roles[@]}"; do
    printf " [%2d] %s\n" "$((r+1))" "${roles[$r]}"
  done
  echo ""
  read -p "Elige tu rol (1-6): " ROLE
fi

# 2. Seleccion de Arquetipo
if [ "$ARCHETYPE" -lt 1 ] || [ "$ARCHETYPE" -gt 18 ]; then
  echo -e "\n========================================================"
  echo -e " 🏛️ PASO 2: LA TABLA PERIODICA DEL SOFTWARE"
  echo -e "========================================================\n"
  echo -e "Que tipo de proyecto deseas construir hoy?\n"

  for i in "${!archetypes[@]}"; do
    if [ "$i" -eq 0 ];  then echo -e "FAMILIA 1: CAPTACION Y PRESENCIA"; fi
    if [ "$i" -eq 3 ];  then echo -e "\nFAMILIA 2: COMERCIO, TRANSACCIONES Y MONETIZACION"; fi
    if [ "$i" -eq 8 ];  then echo -e "\nFAMILIA 3: COMUNIDAD, CONTENIDO Y APRENDIZAJE"; fi
    if [ "$i" -eq 10 ]; then echo -e "\nFAMILIA 4: OPERACIONES Y EMPRESA"; fi
    if [ "$i" -eq 14 ]; then echo -e "\nFAMILIA 5: AUTOMATIZACION, IA Y TELEMETRIA"; fi
    printf " [%2d] %s\n" "$((i+1))" "${archetypes[$i]}"
  done
  echo ""
  read -p "Elige un arquetipo (1-18): " ARCHETYPE
fi

if [ -z "$PROJECT_NAME" ]; then
  read -p "Ingresa el nombre del proyecto (slug en kebab-case, ej. mi-proyecto): " PROJECT_NAME
  PROJECT_NAME=${PROJECT_NAME:-"mi-proyecto"}
fi

ROLE_NAME=$(echo "${roles[$((ROLE-1))]}" | cut -d'[' -f1 | xargs)
ARCHETYPE_NAME="${archetypes[$((ARCHETYPE-1))]}"

echo -e "\nAprovisionando para Rol: [$ROLE_NAME] | Arquetipo: $ARCHETYPE - $ARCHETYPE_NAME ..."

mkdir -p .github/workflows

# MODO AWARENESS (Cualquier arquetipo encapsulado en Frontend Puro en <24h)
if [ "$ROLE" -eq 1 ]; then
  echo -e "🎯 Activando MODO PROTOTIPO DE VENTA AWARENESS (<24 Horas)..."
  mkdir -p css js assets

  cat <<EOF > index.html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$PROJECT_NAME - Prototipo de Venta</title>
  <link rel="stylesheet" href="css/styles.css" />
  <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
  <div class="glass-card">
    <div class="badge">PROTOTIPO FUNCIONAL &bull; $ROLE_NAME</div>
    <h1 id="title">$PROJECT_NAME</h1>
    <p id="desc">Demostracion interactiva de alta fidelidad: $ARCHETYPE_NAME.</p>
    <div id="demoContent" class="interactive-area">
      <!-- Inyectado por js/mock-data.js -->
    </div>
    <button id="primaryAction" class="btn">Interactuar con Demostracion</button>
  </div>
  <script src="js/mock-data.js"></script>
  <script src="js/app.js"></script>
</body>
</html>
EOF

  cat <<EOF > css/styles.css
:root { --primary: #6366f1; --primary-hover: #4f46e5; --bg: #030712; --card-bg: rgba(255, 255, 255, 0.04); --border: rgba(255, 255, 255, 0.1); }
body { margin: 0; min-height: 100dvh; display: grid; place-items: center; background: radial-gradient(circle at 50% 0%, #1e1b4b 0%, var(--bg) 75%); color: #f9fafb; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; padding: 1rem; }
.glass-card { width: 100%; max-width: 520px; background: var(--card-bg); backdrop-filter: blur(24px); border: 1px solid var(--border); border-radius: 28px; padding: 2.5rem; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); text-align: center; }
.badge { display: inline-block; padding: 0.25rem 0.75rem; border-radius: 9999px; background: rgba(99, 102, 241, 0.15); border: 1px solid rgba(99, 102, 241, 0.3); color: #a5b4fc; font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em; margin-bottom: 1.25rem; }
h1 { font-size: 2rem; font-weight: 800; letter-spacing: -0.025em; margin: 0 0 0.5rem 0; }
p { color: #9ca3af; font-size: 0.95rem; line-height: 1.5; margin: 0 0 1.75rem 0; }
.interactive-area { background: rgba(0, 0, 0, 0.3); border: 1px solid var(--border); border-radius: 16px; padding: 1.25rem; margin-bottom: 1.5rem; text-align: left; font-size: 0.875rem; }
.btn { width: 100%; min-height: 44px; background: var(--primary); color: white; border: none; border-radius: 14px; font-weight: 600; font-size: 0.95rem; cursor: pointer; transition: all 0.2s ease; box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3); }
.btn:hover { background: var(--primary-hover); transform: translateY(-2px); box-shadow: 0 20px 25px -5px rgba(99, 102, 241, 0.4); }
EOF

  cat <<EOF > js/mock-data.js
window.PROJECT_MOCK_DATA = {
  archetypeId: $ARCHETYPE,
  archetypeName: "$ARCHETYPE_NAME",
  sampleItems: [
    { id: 1, name: "Elemento de Muestra Alfa", status: "Activo", metric: "99.8%" },
    { id: 2, name: "Elemento de Muestra Beta", status: "En Proceso", metric: "450 ms" }
  ]
};
EOF

  cat <<EOF > js/app.js
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("demoContent");
  const data = window.PROJECT_MOCK_DATA;
  if (container && data) {
    container.innerHTML = \`
      <div style="font-weight:600; margin-bottom:0.5rem; color:#c7d2fe;">\${data.archetypeName}</div>
      <div style="display:flex; justify-content:space-between; padding:0.5rem 0; border-top:1px solid rgba(255,255,255,0.08);">
        <span>\${data.sampleItems[0].name}</span>
        <strong style="color:#34d399;">\${data.sampleItems[0].metric}</strong>
      </div>
    \`;
  }
  document.getElementById("primaryAction")?.addEventListener("click", () => {
    alert("¡Interaccion simulada completada! Listo para presentar al cliente.");
  });
  if (window.lucide) { window.lucide.createIcons(); }
});
EOF

  echo '{"cleanUrls":true,"trailingSlash":false}' > vercel.json

  echo -e "✅ ¡Prototipo de Venta para [$PROJECT_NAME] listo en modo Awareness!"
  echo -e "🚀 Abre 'index.html' o corre 'npx vercel dev' para proyectarlo a tu cliente en < 24h.\n"
  exit 0
fi

# MODOS FULLSTACK (Maker, Consultant, Architect, Expert, Director)
mkdir -p supabase/migrations

case $ARCHETYPE in
  1)
    mkdir -p css js assets
    echo '{"cleanUrls":true,"trailingSlash":false}' > vercel.json
    ;;

  3)
    mkdir -p src/app/[locale] src/actions src/lib/supabase src/lib/schemas src/messages
    echo '{"hero":{"title":"La solucion definitiva","cta":"Unirme a la lista de espera"}}' > src/messages/es.json
    echo '{"hero":{"title":"The ultimate solution","cta":"Join the waitlist"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_leads_table.sql
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
EOF
    ;;

  6)
    mkdir -p src/app/[locale]/\(booking\) src/actions src/lib/calendar src/messages
    echo '{"booking":{"title":"Agendar Cita","select_time":"Selecciona tu horario"}}' > src/messages/es.json
    echo '{"booking":{"title":"Book Appointment","select_time":"Select a time slot"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_booking_schema.sql
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
EOF
    ;;

  7)
    mkdir -p src/app/[locale]/\(membership\) src/app/api/stripe/webhook src/lib/stripe src/messages
    echo '{"membership":{"tiers":"Niveles de Membresia","subscribe":"Suscribirme"}}' > src/messages/es.json
    echo '{"membership":{"tiers":"Membership Tiers","subscribe":"Subscribe"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_subscriptions_schema.sql
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
EOF
    ;;

  8)
    mkdir -p src/app/[locale]/\(wallet\) src/actions src/lib/ledger src/messages
    echo '{"wallet":{"balance":"Saldo Disponible","transfer":"Transferir Fondos"}}' > src/messages/es.json
    echo '{"wallet":{"balance":"Available Balance","transfer":"Transfer Funds"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_ledger_schema.sql
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
EOF
    ;;

  10)
    mkdir -p src/app/[locale]/\(lms\)/cursos src/components/video src/lib/certificates src/messages
    echo '{"lms":{"courses":"Mis Cursos","continue":"Continuar leccion"}}' > src/messages/es.json
    echo '{"lms":{"courses":"My Courses","continue":"Continue lesson"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_lms_schema.sql
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
EOF
    ;;

  17)
    mkdir -p src/app/[locale]/\(iot\) src/lib/iot src/components/telemetry src/messages
    echo '{"iot":{"factory":"Lineas de Produccion","sensors":"Sensores en Tiempo Real"}}' > src/messages/es.json
    echo '{"iot":{"factory":"Production Lines","sensors":"Real-time Sensors"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_iot_schema.sql
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
EOF
    ;;

  *)
    mkdir -p apps/web/app/[locale] apps/web/components/ui apps/web/lib/supabase apps/web/messages packages/ui packages/database
    echo '{"common":{"welcome":"Bienvenido"}}' > apps/web/messages/es.json
    echo '{"common":{"welcome":"Welcome"}}' > apps/web/messages/en.json
    ;;
esac

if [ ! -f ".env.example" ]; then
  cat <<EOF > .env.example
NODE_ENV=development
PORT=3000

# Supabase Local o Cloud (https://app.supabase.com)
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-anon-key-aqui
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key-secreta

# Vercel & App URL
NEXT_PUBLIC_APP_URL=http://localhost:3000
EOF
fi

echo -e "\nEstructura para [$PROJECT_NAME] aprovisionada exitosamente para rol [$ROLE_NAME]!"
echo -e "Proximos pasos:"
echo -e " 1. Copia .env.example a .env.local y anade tus credenciales de Supabase."
echo -e " 2. Ejecuta 'npm run dev' o 'npx vercel dev' para arrancar el servidor local."
