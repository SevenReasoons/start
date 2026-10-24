#!/usr/bin/env bash
# ==============================================================================
# 🌟 Seven Reasoons Universal Project Starter (reasoons-start)
# Bash (Linux / Mac / WSL2)
# ==============================================================================
set -e

PROJECT_NAME=${1:-""}
ROLE=${2:-0}
ARCHETYPE=${3:-0}
DESTINATION_PATH=${4:-""}
SOURCE_REPO="https://github.com/SevenReasoons/start.git"

echo -e "\n================================================================================"
echo -e " ⭐ SEVEN REASOONS PROJECT STARTER (reasoons-start)"
echo -e "    Arranque interactivo llave en mano de proyectos en carpeta independiente"
echo -e "================================================================================\n"

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
  "E-Commerce B2C Transaccional (Tienda directa, carrito y checkout Stripe)"
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

# 1. Nombre del Proyecto
if [ -z "$PROJECT_NAME" ]; then
  read -p "1. Ingresa el nombre del nuevo proyecto (ej. mi-nueva-app): " PROJECT_NAME
  PROJECT_NAME=${PROJECT_NAME:-"mi-nuevo-proyecto"}
fi
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9-_' '-' | sed 's/^-//;s/-$//')

# 2. Selección de Rol
if [ "$ROLE" -lt 1 ] || [ "$ROLE" -gt 6 ]; then
  echo -e "\n2. Selecciona tu Rol de Equipo:"
  for r in "${!roles[@]}"; do
    printf "   [%2d] %s\n" "$((r+1))" "${roles[$r]}"
  done
  echo ""
  read -p "Elige tu rol (1-6): " ROLE
fi
ROLE_NAME=$(echo "${roles[$((ROLE-1))]}" | cut -d'[' -f1 | xargs)

# 3. Selección de Arquetipo
if [ "$ARCHETYPE" -lt 1 ] || [ "$ARCHETYPE" -gt 18 ]; then
  echo -e "\n3. Selecciona el Arquetipo de Software (Tabla Periodica):"
  for i in "${!archetypes[@]}"; do
    if [ "$i" -eq 0 ];  then echo -e "   FAMILIA 1: CAPTACION Y PRESENCIA"; fi
    if [ "$i" -eq 3 ];  then echo -e "\n   FAMILIA 2: COMERCIO, TRANSACCIONES Y MONETIZACION"; fi
    if [ "$i" -eq 8 ];  then echo -e "\n   FAMILIA 3: COMUNIDAD, CONTENIDO Y APRENDIZAJE"; fi
    if [ "$i" -eq 10 ]; then echo -e "\n   FAMILIA 4: OPERACIONES Y EMPRESA"; fi
    if [ "$i" -eq 14 ]; then echo -e "\n   FAMILIA 5: AUTOMATIZACION, IA Y TELEMETRIA"; fi
    printf "   [%2d] %s\n" "$((i+1))" "${archetypes[$i]}"
  done
  echo ""
  read -p "Elige un arquetipo (1-18): " ARCHETYPE
fi
ARCHETYPE_NAME="${archetypes[$((ARCHETYPE-1))]}"

# 4. Carpeta Destino
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PARENT_DIR="$(cd "$TEMPLATE_ROOT/.." && pwd)"

if [ -z "$DESTINATION_PATH" ]; then
  DESTINATION_PATH="$PARENT_DIR/$PROJECT_NAME"
fi

echo -e "\n📁 Carpeta destino: $DESTINATION_PATH"
mkdir -p "$DESTINATION_PATH"

# 5. Clonado o Copia
echo -e "\n📦 Inicializando proyecto base desde plantilla..."
CLONED=0
if [ -z "$(ls -A "$DESTINATION_PATH" 2>/dev/null)" ]; then
  echo "   Intentando clonar repositorio oficial ($SOURCE_REPO)..."
  if git clone --depth 1 "$SOURCE_REPO" "$DESTINATION_PATH" 2>/dev/null; then
    CLONED=1
    echo "   [PASS] Clonado exitoso desde GitHub."
  fi
fi

if [ "$CLONED" -eq 0 ]; then
  echo "   Copiando plantilla maestra local..."
  rsync -av --exclude='.git' --exclude='node_modules' --exclude='.next' --exclude='dist' "$TEMPLATE_ROOT/" "$DESTINATION_PATH/" >/dev/null 2>&1 || cp -rf "$TEMPLATE_ROOT"/* "$DESTINATION_PATH/"
  echo "   [PASS] Plantilla maestra copiada exitosamente."
fi

# 6. Reinicializar Git
cd "$DESTINATION_PATH"
rm -rf .git
git init -b main >/dev/null 2>&1 || git init >/dev/null 2>&1
echo "   [PASS] Repositorio Git limpio inicializado en rama 'main'."

# 7. Aprovisionar Arquetipo
echo -e "\n⚙️ Aprovisionando Arquetipo $ARCHETYPE ($ARCHETYPE_NAME) para Rol $ROLE_NAME..."
bash "$DESTINATION_PATH/scripts/init-project.sh" "$ROLE" "$ARCHETYPE" "$PROJECT_NAME"

# 8. Extensiones IDE
echo -e "\n🧩 Configurando extensiones recomendadas de Antigravity IDE / VS Code..."
mkdir -p "$DESTINATION_PATH/.vscode"
cat <<'EOF' > "$DESTINATION_PATH/.vscode/extensions.json"
{
  "recommendations": [
    "bradlc.vscode-tailwindcss",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "supabase.supabase-vscode",
    "vercel.vercel-vscode",
    "lokalise.i18n-ally",
    "usernamehw.errorlens",
    "tamasfe.even-better-toml",
    "eamodio.gitlens"
  ]
}
EOF

# 9. Dependencias
if [ "$ROLE" -eq 1 ]; then
  echo -e "\n🎯 [Modo Awareness]: Prototipo de venta ultrarrápido (<24h)."
  echo -e "   Cero dependencias pesadas. ¡Sin esperar instalaciones de npm!"
else
  echo -e "\n📦 Instalando dependencias de Node.js..."
  if [ -f "package.json" ]; then
    if command -v pnpm >/dev/null 2>&1; then
      pnpm install || npm install
    else
      npm install
    fi
    echo -e "   [PASS] Dependencias instaladas con éxito."
  fi
fi

# 10. Doctor
echo -e "\n🩺 Ejecutando diagnóstico de salud (doctor.sh)..."
bash "$DESTINATION_PATH/scripts/doctor.sh" "$ROLE" || true

# 11. Resumen
echo -e "\n================================================================================"
echo -e " 🎉 ¡PROYECTO [$PROJECT_NAME] INICIALIZADO CON ÉXITO!"
echo -e "================================================================================"
echo -e "  Ubicación:   $DESTINATION_PATH"
echo -e "  Rol:         [$ROLE] $ROLE_NAME"
echo -e "  Arquetipo:   [$ARCHETYPE] $ARCHETYPE_NAME\n"
echo -e "🚀 Pasos para empezar a trabajar de inmediato:"
echo -e "  1. Abrir en Antigravity IDE:"
echo -e "     code \"$DESTINATION_PATH\""
echo -e "     cd \"$DESTINATION_PATH\"\n"
if [ "$ROLE" -eq 1 ]; then
  echo -e "  2. Proyectar prototipo al cliente:"
  echo -e "     Abre '$DESTINATION_PATH/index.html' o corre: npx vercel dev"
else
  echo -e "  2. Configurar credenciales:"
  echo -e "     Copia .env.example a .env.local y añade tus credenciales de Supabase."
  echo -e "  3. Iniciar servidor local:"
  echo -e "     npm run dev"
fi
echo -e "================================================================================\n"
