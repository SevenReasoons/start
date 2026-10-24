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
  "Maker       [Nivel 2] - Frontend Atómico Next.js & DB Familia 2 (Handoff a Senior)"
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
  <title>$PROJECT_NAME - Prototipo de Venta &bull; Seven Reasoons</title>
  <!-- Google Fonts: Inter -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css" />
  <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
  <!-- Contenedor Principal con Borde Degradado de 2px (Regla de Oro: relleno sólido interior) -->
  <main class="card-gradient-border">
    <div class="card-inner">
      <div class="badge">PROTOTIPO FUNCIONAL &bull; $ROLE_NAME</div>
      <h1 id="title">$PROJECT_NAME</h1>
      <p id="desc">Demostracion interactiva de alta fidelidad: $ARCHETYPE_NAME.</p>
      
      <div id="demoContent" class="interactive-area">
        <!-- Inyectado por js/mock-data.js -->
      </div>
      
      <!-- Botón CTA Oficial: Borde degradado de 2px con relleno sólido -->
      <div class="btn-cta-border" id="primaryActionWrapper">
        <button id="primaryAction" class="btn-cta">
          <i data-lucide="sparkles" style="width:18px;height:18px;"></i>
          <span>Interactuar con Demostracion</span>
        </button>
      </div>

      <!-- Enlace WhatsApp Oficial Seven Reasoons -->
      <div class="whatsapp-box">
        <a href="https://wa.me/525649328703" target="_blank" rel="noopener noreferrer" class="whatsapp-link">
          <i data-lucide="message-circle" style="width:16px;height:16px;color:#22c55e;"></i>
          <span>WhatsApp Oficial: 5649328703 &bull; Respondemos en menos de una hora</span>
        </a>
      </div>
    </div>
  </main>

  <!-- Footer Oficial Seven Reasoons -->
  <footer class="brand-footer">
    <img 
      src="https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png" 
      alt="Seven Reasoons" 
      class="brand-logo"
    />
    <p class="brand-footnote">Made with love by Seven Reasoons</p>
  </footer>

  <script src="js/mock-data.js"></script>
  <script src="js/app.js"></script>
</body>
</html>
EOF

  cat <<'EOF' > css/styles.css
:root {
  --sr-red: #ef4444;
  --sr-orange: #f97316;
  --sr-green: #22c55e;
  --sr-blue: #3b82f6;
  --sr-gradient: linear-gradient(to right, var(--sr-red), var(--sr-orange), var(--sr-green), var(--sr-blue));
  --bg-page: #f8fafc;
  --card-bg: #ffffff;
  --text-main: #0f172a;
  --text-muted: #64748b;
  --border-subtle: #e2e8f0;
  --area-bg: #f8fafc;
}

* { box-sizing: border-box; }

body {
  margin: 0;
  min-height: 100dvh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: radial-gradient(circle at 50% 0%, #ffffff 0%, var(--bg-page) 100%);
  color: var(--text-main);
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  padding: 2rem 1rem;
}

/* Tarjeta Highlight: Borde Degradado de 2px con Relleno Sólido Blanco Interior */
.card-gradient-border {
  width: 100%;
  max-width: 520px;
  padding: 2px;
  border-radius: 24px;
  background: var(--sr-gradient);
  box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.07), 0 0 1px 1px rgba(0, 0, 0, 0.02);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card-inner {
  background: var(--card-bg);
  border-radius: 22px;
  padding: 2.5rem;
  text-align: center;
}

/* Badges en mayúsculas con tracking-widest */
.badge {
  display: inline-block;
  padding: 0.35rem 0.85rem;
  border-radius: 9999px;
  background: #f1f5f9;
  border: 1px solid var(--border-subtle);
  color: #475569;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 1.25rem;
}

/* Títulos principales con tracking-tighter */
h1 {
  font-size: 2rem;
  font-weight: 800;
  letter-spacing: -0.05em;
  margin: 0 0 0.5rem 0;
  color: var(--text-main);
}

p {
  color: var(--text-muted);
  font-size: 0.95rem;
  font-weight: 400;
  line-height: 1.6;
  margin: 0 0 1.75rem 0;
}

.interactive-area {
  background: var(--area-bg);
  border: 1px solid var(--border-subtle);
  border-radius: 16px;
  padding: 1.25rem;
  margin-bottom: 1.5rem;
  text-align: left;
  font-size: 0.875rem;
  color: #334155;
}

/* BOTÓN CTA OFICIAL SEVEN REASOONS (TEMA CLARO PRIORITARIO):
   Estructura: Borde degradado de 2px con relleno sólido (blanco).
   REGLA DE ORO: El degradado solo va en el borde.
   Radio: rounded-2xl (16px).
   Animación: -translate-y-1 y shadow-2xl en hover.
*/
.btn-cta-border {
  display: block;
  width: 100%;
  padding: 2px;
  border-radius: 16px;
  background: var(--sr-gradient);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
}

.btn-cta-border:hover {
  transform: translateY(-3px);
  box-shadow: 0 20px 35px -10px rgba(59, 130, 246, 0.25);
}

.btn-cta {
  width: 100%;
  min-height: 48px;
  background: #ffffff;
  color: #0f172a;
  border: none;
  border-radius: 14px;
  font-family: 'Inter', sans-serif;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  transition: background 0.2s ease, color 0.2s ease;
}

.btn-cta:hover {
  background: #f8fafc;
}

/* Enlace a WhatsApp Oficial */
.whatsapp-box {
  margin-top: 1.5rem;
  padding-top: 1.25rem;
  border-top: 1px solid var(--border-subtle);
}

.whatsapp-link {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  color: #64748b;
  text-decoration: none;
  font-size: 0.8rem;
  font-weight: 400;
  transition: color 0.2s ease;
}

.whatsapp-link:hover {
  color: #16a34a;
}

/* Footer con Logo Oficial Seven Reasoons */
.brand-footer {
  margin-top: 2.5rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.brand-logo {
  height: 28px;
  width: auto;
  opacity: 0.5;
  filter: grayscale(100%);
  transition: all 0.3s ease;
}

.brand-logo:hover {
  opacity: 1;
  filter: grayscale(0%);
}

.brand-footnote {
  margin: 0;
  font-size: 0.75rem;
  font-weight: 400;
  color: #94a3b8;
  letter-spacing: 0.05em;
}
EOF

  cat <<EOF > js/mock-data.js
window.PROJECT_MOCK_DATA = {
  archetypeId: $ARCHETYPE,
  archetypeName: "$ARCHETYPE_NAME",
  projectName: "$PROJECT_NAME",
  catalog: {
    1: { category: "Captación & Presencia", headline: "Prototipo Interactivo de Alta Fidelidad", kpis: [{ label: "Conversión Estimada", val: "8.4%", badge: "+2.1%" }, { label: "Velocidad de Carga", val: "0.4s", badge: "A+" }], items: [{ name: "Flujo de Registro en 1 Clic", status: "Completado", detail: "Sin fricción cognitiva" }, { name: "Presentación de Propuesta", status: "Activo", detail: "Listo para validación" }] },
    2: { category: "Página Web Estática", headline: "Portal Institucional en Vercel Edge", kpis: [{ label: "Lighthouse Score", val: "100/100", badge: "Edge" }, { label: "Indexación SEO", val: "100%", badge: "Google" }], items: [{ name: "Página de Inicio & Servicios", status: "Publicado", detail: "SSG ultrarrápido" }, { name: "Casos de Estudio & Blog", status: "Publicado", detail: "Edge Caching" }] },
    3: { category: "Landing Page Dinámica", headline: "Embudo de Captación y Validación Zod", kpis: [{ label: "Leads Capturados", val: "1,420", badge: "+18% hoy" }, { label: "Tasa de Cualificación", val: "32.4%", badge: "Alta" }], items: [{ name: "Carlos Mendoza — Dir. Operaciones", status: "Calificado", detail: "Interés en Plan Pro" }, { name: "Sofía Villarreal — Head of Growth", status: "Demo Agendada", detail: "Contacto en <1h" }] },
    4: { category: "E-Commerce B2C Transaccional", headline: "Tienda y Checkout Directo Stripe", kpis: [{ label: "Ventas de Hoy", val: "$48,250 MXN", badge: "+14.2%" }, { label: "Ticket Promedio", val: "$1,850 MXN", badge: "Stripe" }], items: [{ name: "Auriculares Noise-Cancelling Pro", status: "En Stock", detail: "$3,499 MXN — 4.9 ★ (128 reseñas)" }, { name: "Reloj Inteligente Titan Series", status: "Últimas pzas", detail: "$5,299 MXN — 4.8 ★ (94 reseñas)" }] },
    5: { category: "Marketplace Bilateral", headline: "Plataforma Multi-Vendedor y Comisiones", kpis: [{ label: "GMV Mensual", val: "$380,000 USD", badge: "Connect" }, { label: "Comisión Neta (12%)", val: "$45,600 USD", badge: "MRR" }], items: [{ name: "Taller Artesanal Maderero", status: "Verificado", detail: "98% Entregas a tiempo" }, { name: "Mesa Parota Ejecutiva 2.40m", status: "En Tránsito", detail: "Fondos en custodia Stripe" }] },
    6: { category: "Citas, Agendamiento y Reservas", headline: "Motor de Reservas sin Doble Asignación", kpis: [{ label: "Citas Confirmadas", val: "18 Citas", badge: "100% Lleno" }, { label: "Tiempo por Sesión", val: "45 min", badge: "GiST Slot" }], items: [{ name: "Dra. Valentina Ruiz — Consulta", status: "10:30 AM", detail: "Paciente: Roberto Garza (Confirmado)" }, { name: "Dr. Fernando Morales — Checkup", status: "11:45 AM", detail: "Paciente: Mariana Gómez (Confirmado)" }] },
    7: { category: "Membresías y Paywall", headline: "Comunidad Exclusiva y Cobro Recurrente", kpis: [{ label: "Suscriptores Activos", val: "2,410", badge: "Billing" }, { label: "MRR Recurrente", val: "$28,920 USD", badge: "Churn <1%" }], items: [{ name: "Pase Fundador All-Access", status: "Activo", detail: "$49 USD/mes — Ilimitado" }, { name: "Círculo Privado de Mentoría", status: "Lista de Espera", detail: "Cupo lleno (50/50 miembros)" }] },
    8: { category: "FinTech & Billetera Digital", headline: "Bóveda P2P y Contabilidad Doble Partida", kpis: [{ label: "Custodia en Bóveda", val: "$1,450,200 MXN", badge: "Auditable" }, { label: "Velocidad de Cierre", val: "340 TPS", badge: "Atómico" }], items: [{ name: "Transferencia SPEI Recibida", status: "+$15,000 MXN", detail: "BBVA Bancomer — Conciliado" }, { name: "Pago QR en Comercio", status: "-$420.50 MXN", detail: "Café Gourmet Monterrey" }] },
    9: { category: "Red Social / Comunidad", headline: "Feeds en Tiempo Real y Canales en Vivo", kpis: [{ label: "Usuarios en Línea", val: "892 activos", badge: "Realtime" }, { label: "Publicaciones Hoy", val: "4,120", badge: "+32%" }], items: [{ name: "¿Cómo estructurar un equipo de IA?", status: "Trending", detail: "142 comentarios &bull; 89 reposts" }, { name: "Lanzamiento oficial de plataforma", status: "Oficial", detail: "389 reacciones &bull; 45 compartidos" }] },
    10: { category: "Educación, Cursos y LMS", headline: "Academia Digital con Certificación", kpis: [{ label: "Estudiantes Activos", val: "6,840", badge: "LMS" }, { label: "Tasa de Finalización", val: "87.3%", badge: "Top 5%" }], items: [{ name: "Master en Arquitectura Cloud", status: "Módulo 4/8", detail: "Progreso: 68% del alumno" }, { name: "Sistemas Escalables en Vercel", status: "Completado", detail: "Diploma emitido #SR-2026" }] },
    11: { category: "Dashboards & Analítica", headline: "Panel Ejecutivo de Control y Métricas", kpis: [{ label: "MRR Total", val: "$94,200 USD", badge: "+22% YoY" }, { label: "Eficiencia CAC/LTV", val: "1:4.8", badge: "Óptimo" }], items: [{ name: "Retención Cohorte Q3", status: "94.2%", detail: "+3.8% vs periodo anterior" }, { name: "Margen Bruto de Operación", status: "78.4%", detail: "Optimización continua" }] },
    12: { category: "Software Empresarial (ERP/CRM)", headline: "Gestión de Inventarios y Facturación", kpis: [{ label: "Facturación Mes", val: "$2.4M MXN", badge: "CFDI 4.0" }, { label: "Órdenes Procesadas", val: "1,840", badge: "Sin mora" }], items: [{ name: "Factura A-9841 — Grupo Alfa", status: "Pagada", detail: "$348,000 MXN — Conciliada" }, { name: "Lote de Acero Grado Automotriz", status: "94 tons", detail: "Almacén Central Monterrey" }] },
    13: { category: "Software Multitenant (SaaS)", headline: "Aislamiento por Subdominio y Tenant", kpis: [{ label: "Inquilinos Activos", val: "148 Empresas", badge: "Subdominios" }, { label: "Aislamiento RLS", val: "100% Estricto", badge: "Postgres" }], items: [{ name: "acme.tuapp.com", status: "Enterprise", detail: "1,200 usuarios activos" }, { name: "logistica.tuapp.com", status: "Plan Pro", detail: "350 usuarios activos" }] },
    14: { category: "Software Multitenant Global", headline: "Nodos Multi-Región y Multi-Moneda", kpis: [{ label: "Regiones Activas", val: "US, EU, LATAM", badge: "Global" }, { label: "Latencia P99", val: "18 ms", badge: "Edge" }], items: [{ name: "Nodo Norteamérica (us-east)", status: "Saludable", detail: "12,400 req/min — USD" }, { name: "Nodo Europa (eu-central)", status: "Saludable", detail: "8,900 req/min — EUR (GDPR)" }] },
    15: { category: "Automatización & Integraciones", headline: "Orquestador de Tareas Cron y Webhooks", kpis: [{ label: "Eventos Procesados", val: "148,920", badge: "200 OK" }, { label: "Tasa de Error", val: "0.001%", badge: "3x Retries" }], items: [{ name: "Sincronización Nocturna SAP", status: "Completado", detail: "Ejecución: 02:00 AM (48s)" }, { name: "Webhook Stripe — Invoice Paid", status: "Procesado", detail: "CFDI timbrado en 400ms" }] },
    16: { category: "Copiloto Agéntico / AI-First", headline: "Agentes Autónomos con Streaming y RAG", kpis: [{ label: "Tokens Procesados", val: "1.4M hoy", badge: "Streaming" }, { label: "Precisión Vectorial", val: "96.4%", badge: "pgvector" }], items: [{ name: "TORI — Agente Diagnóstico", status: "Activo", detail: "Memoria contextual cargada" }, { name: "Copiloto de Soporte Técnico", status: "En Línea", detail: "Tiempo de respuesta: 650ms" }] },
    17: { category: "IoT Industrial & Telemetría", headline: "Monitoreo en Tiempo Real y Alertas de Planta", kpis: [{ label: "Sensores Conectados", val: "340 Unidades", badge: "MQTT/WS" }, { label: "Frecuencia Muestreo", val: "100 ms", badge: "En Vivo" }], items: [{ name: "Turbina Bahía 3 — Vibración", status: "Normal (42°C)", detail: "0.12 mm/s — En rango óptimo" }, { name: "Bomba Hidráulica Principal", status: "Alerta Leve", detail: "78°C — Mantenimiento agendado" }] },
    18: { category: "API Headless / BaaS", headline: "Contrato Tipado RFC 7807 y Edge Cache", kpis: [{ label: "Disponibilidad 30d", val: "99.99%", badge: "SLA" }, { label: "Latencia Media", val: "32 ms", badge: "Edge" }], items: [{ name: "GET /api/v1/telemetry/live", status: "200 OK", detail: "Bearer Token validado" }, { name: "POST /api/v1/orders/create", status: "201 Created", detail: "Idempotencia RFC 7807" }] }
  }
};
EOF

  cat <<'EOF' > js/app.js
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("demoContent");
  const data = window.PROJECT_MOCK_DATA;
  if (!container || !data) return;

  const current = data.catalog[data.archetypeId] || data.catalog[1];

  let kpiHtml = `
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:0.75rem; margin-bottom:1rem;">
      <div style="background:#ffffff; border:1px solid #e2e8f0; border-radius:12px; padding:0.75rem; text-align:left;">
        <div style="font-size:0.7rem; color:#64748b; font-weight:600; text-transform:uppercase;">${current.kpis[0].label}</div>
        <div style="font-size:1.25rem; font-weight:800; color:#0f172a; margin-top:0.25rem;">${current.kpis[0].val}</div>
        <span style="font-size:0.65rem; color:#16a34a; font-weight:700;">${current.kpis[0].badge}</span>
      </div>
      <div style="background:#ffffff; border:1px solid #e2e8f0; border-radius:12px; padding:0.75rem; text-align:left;">
        <div style="font-size:0.7rem; color:#64748b; font-weight:600; text-transform:uppercase;">${current.kpis[1].label}</div>
        <div style="font-size:1.25rem; font-weight:800; color:#0f172a; margin-top:0.25rem;">${current.kpis[1].val}</div>
        <span style="font-size:0.65rem; color:#2563eb; font-weight:700;">${current.kpis[1].badge}</span>
      </div>
    </div>
  `;

  let itemsHtml = current.items.map(item => `
    <div style="display:flex; justify-content:space-between; align-items:center; padding:0.6rem 0; border-top:1px solid #e2e8f0; font-size:0.85rem;">
      <div style="text-align:left;">
        <strong style="color:#0f172a; display:block;">${item.name}</strong>
        <span style="color:#64748b; font-size:0.75rem;">${item.detail}</span>
      </div>
      <span style="font-size:0.7rem; font-weight:700; background:#f1f5f9; color:#334155; padding:0.2rem 0.6rem; border-radius:9999px; border:1px solid #cbd5e1; white-space:nowrap;">
        ${item.status}
      </span>
    </div>
  `).join("");

  container.innerHTML = `
    <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:0.75rem;">
      <span style="width:8px; height:8px; border-radius:50%; background:#22c55e; display:inline-block;"></span>
      <span style="font-size:0.75rem; font-weight:700; color:#16a34a; letter-spacing:0.05em; text-transform:uppercase;">${current.category}</span>
    </div>
    <div style="font-weight:700; font-size:1rem; color:#0f172a; margin-bottom:0.75rem;">${current.headline}</div>
    ${kpiHtml}
    ${itemsHtml}
  `;

  document.getElementById("primaryAction")?.addEventListener("click", () => {
    alert(`⚡ [Simulación en Tiempo Real]\nOperación ejecutada con éxito para ${current.headline}.\n¡Prototipo 100% interactivo listo para presentar!`);
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

  4)
    mkdir -p src/app/[locale]/\(store\) src/components/atoms src/components/molecules src/components/organisms src/components/templates src/actions src/lib/supabase src/messages
    echo '{"store":{"title":"Tienda Oficial","addToCart":"Agregar al Carrito","checkout":"Proceder al Pago"}}' > src/messages/es.json
    echo '{"store":{"title":"Official Store","addToCart":"Add to Cart","checkout":"Proceed to Checkout"}}' > src/messages/en.json
    cat <<EOF > supabase/migrations/20261024000000_create_store_schema.sql
CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  image_url TEXT,
  stock INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS public.orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
  status TEXT DEFAULT 'pending',
  shipping_address TEXT,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Lectura publica de productos" ON public.products FOR SELECT USING (true);
CREATE POLICY "Usuarios gestionan sus propias ordenes" ON public.orders FOR ALL USING (auth.uid() = user_id);
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

# ------------------------------------------------------------------------------
# Generación de package.json y configuración Next.js para Roles Fullstack (2 a 6)
# ------------------------------------------------------------------------------
if [ "$ROLE" -ge 2 ]; then
  if [ ! -f "package.json" ]; then
    cat <<EOF > package.json
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "@supabase/ssr": "^0.5.2",
    "@supabase/supabase-js": "^2.48.1",
    "clsx": "^2.1.1",
    "lucide-react": "^0.475.0",
    "next": "^14.2.23",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "tailwind-merge": "^2.6.0",
    "zod": "^3.24.1"
  },
  "devDependencies": {
    "@types/node": "^20.17.16",
    "@types/react": "^18.3.18",
    "@types/react-dom": "^18.3.5",
    "autoprefixer": "^10.4.20",
    "eslint": "^8.57.1",
    "eslint-config-next": "^14.2.23",
    "postcss": "^8.5.1",
    "tailwindcss": "^3.4.17",
    "typescript": "^5.7.3"
  }
}
EOF
  fi

  if [ ! -f "tsconfig.json" ]; then
    cat <<'EOF' > tsconfig.json
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF
  fi

  if [ ! -f "tailwind.config.ts" ]; then
    cat <<'EOF' > tailwind.config.ts
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        sr: {
          red: "#ef4444",
          orange: "#f97316",
          green: "#22c55e",
          blue: "#3b82f6",
        },
      },
    },
  },
  plugins: [],
};
export default config;
EOF
  fi

  if [ ! -f "postcss.config.js" ] && [ ! -f "postcss.config.mjs" ]; then
    cat <<'EOF' > postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
EOF
  fi

  if [ ! -f "next.config.mjs" ]; then
    cat <<'EOF' > next.config.mjs
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
};

export default nextConfig;
EOF
  fi

  mkdir -p src/app
  if [ ! -f "src/app/globals.css" ]; then
    cat <<'EOF' > src/app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --background: #ffffff;
  --foreground: #0f172a;
}

body {
  color: var(--foreground);
  background: var(--background);
  font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}
EOF
  fi

  if [ ! -f "src/app/layout.tsx" ]; then
    cat <<EOF > src/app/layout.tsx
import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "$PROJECT_NAME &bull; Seven Reasoons",
  description: "Proyecto construido bajo los estandares de Seven Reasoons (Next.js + Supabase + Vercel)",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body className="min-h-screen bg-white text-slate-900 antialiased">
        {children}
      </body>
    </html>
  );
}
EOF
  fi

  if [ ! -f "src/app/page.tsx" ]; then
    cat <<EOF > src/app/page.tsx
import { Sparkles, MessageCircle } from "lucide-react";

export default function HomePage() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center p-6 bg-slate-50">
      <div className="w-full max-w-xl p-0.5 rounded-3xl bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)] shadow-xl">
        <div className="bg-white rounded-[22px] p-8 text-center space-y-6">
          <span className="inline-block px-3 py-1 rounded-full text-xs font-bold uppercase tracking-widest bg-slate-100 text-slate-700">
            $ROLE_NAME &bull; Arquetipo $ARCHETYPE
          </span>
          <h1 className="text-3xl font-extrabold tracking-tight text-slate-900">
            $PROJECT_NAME
          </h1>
          <p className="text-sm text-slate-600 leading-relaxed">
            $ARCHETYPE_NAME aprovisionado con exito. Arquitectura modular lista para conexion con Supabase y despliegue en Vercel.
          </p>
          <div className="pt-2">
            <a
              href="https://wa.me/525649328703"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 text-xs font-semibold text-slate-600 hover:text-slate-900 transition-colors"
            >
              <MessageCircle className="w-4 h-4 text-emerald-500" />
              <span>Soporte Seven Reasoons: 5649328703</span>
            </a>
          </div>
        </div>
      </div>
      <footer className="mt-8 text-center">
        <p className="text-xs text-slate-400">Made with love by Seven Reasoons</p>
      </footer>
    </main>
  );
}
EOF
  fi
fi

echo -e "\nEstructura para [$PROJECT_NAME] aprovisionada exitosamente para rol [$ROLE_NAME]!"
echo -e "Proximos pasos:"
echo -e " 1. Copia .env.example a .env.local y anade tus credenciales de Supabase."
echo -e " 2. Ejecuta 'npm run dev' o 'npx vercel dev' para arrancar el servidor local."
