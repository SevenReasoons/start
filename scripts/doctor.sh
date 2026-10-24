#!/usr/bin/env bash
# ==============================================================================
# 🩺 Antigravity Environment Doctor (Diagnostico de Salud y Alineacion) - Bash
# ==============================================================================
ROLE=${1:-0}

echo -e "\n========================================================"
echo -e " [DOCTOR] ANTIGRAVITY ENVIRONMENT & TEAM ALIGNMENT"
echo -e "========================================================\n"

roles=(
  "Awareness   [Nivel 1] - Ventas & Prototipos interactivos (<24h)"
  "Maker       [Nivel 2] - Fullstack Junior (Captacion + DB basica)"
  "Consultant  [Nivel 3] - Fullstack Intermedio (APIs, Stripe & LMS)"
  "Architect   [Nivel 4] - Ingeniero Senior (Multi-Tenant & Multi-Agente)"
  "Expert      [Nivel 5] - Deep-Tech (IoT, Ciberseguridad & 60 FPS)"
  "Director    [Nivel 6] - Lider Tecnico/CTPO (Ontologia & Global)"
)

if [ "$ROLE" -lt 1 ] || [ "$ROLE" -gt 6 ]; then
  echo -e "Para calibrar el diagnostico segun tu nivel de equipo:"
  for r in "${!roles[@]}"; do
    printf " [%2d] %s\n" "$((r+1))" "${roles[$r]}"
  done
  echo ""
  read -p "Ingresa tu rol (1-6) [Presiona Enter para Diagnostico Completo]: " ROLE
  ROLE=${ROLE:-0}
fi

ISSUES=0
WARNINGS=0

echo -e "\n[*] Iniciando escaneo de herramientas y entorno...\n"

# CHECK 1: Antigravity IDE
if [ -d "$HOME/.gemini/antigravity-ide" ] || [ -d "$HOME/.gemini/antigravity" ] || pgrep -f "antigravity" > /dev/null 2>&1; then
  echo -e " [PASS] IDE Oficial: Google Antigravity IDE detectado correctamente."
else
  echo -e " [INFO] IDE Oficial: Antigravity IDE (Verifica que este proyecto se ejecute dentro de Antigravity)."
fi

# ROL AWARENESS SHORT-CIRCUIT
if [ "$ROLE" -eq 1 ]; then
  echo -e "\n========================================================"
  echo -e " [ROL 1: AWARENESS] EVALUACION DE ENTORNO"
  echo -e "========================================================"
  echo -e " Entorno 100% LISTO para trabajar y vender sin friccion."
  echo -e " Como Awareness, tu mision es discovery y prototipado visual en menos de 24 horas."
  echo -e " NO necesitas configurar Docker, ni Node.js, ni bases de datos complejas."
  echo -e " Solo necesitas Antigravity para editar texto y tu navegador para proyectar."
  echo -e " Comando para arrancar tu prototipo: ./scripts/init-project.sh 1"
  echo -e "========================================================\n"
  exit 0
fi

# CHECK 2: Node.js (v20+ LTS)
if command -v node > /dev/null 2>&1; then
  NODE_VER=$(node -v)
  MAJOR_VER=$(echo "$NODE_VER" | tr -d 'v' | cut -d'.' -f1)
  if [ "$MAJOR_VER" -ge 20 ]; then
    echo -e " [PASS] Node.js: $NODE_VER (Cumple con version LTS v20+ obligatoria)."
  else
    echo -e " [FAIL] Node.js: $NODE_VER instalado. SE REQUIERE Node.js v20 LTS o superior."
    echo -e "        Solucion: Usa nvm: 'nvm install 20 && nvm use 20'"
    ISSUES=$((ISSUES+1))
  fi
else
  echo -e " [FAIL] Node.js no encontrado en PATH."
  echo -e "        Solucion: Descarga Node v20 LTS desde https://nodejs.org o usa nvm."
  ISSUES=$((ISSUES+1))
fi

# CHECK 3: Git e Identidad
if command -v git > /dev/null 2>&1; then
  GIT_VER=$(git --version)
  GIT_USER=$(git config user.name || true)
  GIT_EMAIL=$(git config user.email || true)
  if [ -n "$GIT_USER" ] && [ -n "$GIT_EMAIL" ]; then
    echo -e " [PASS] Git: $GIT_VER (Configurado para '$GIT_USER' <$GIT_EMAIL>)."
  else
    echo -e " [WARN] Git instalado pero faltan credenciales (user.name o user.email)."
    echo -e "        Solucion: git config --global user.name 'Tu Nombre' && git config --global user.email 'tu@empresa.com'"
    WARNINGS=$((WARNINGS+1))
  fi
else
  echo -e " [FAIL] Git no esta instalado o no se encuentra en el PATH."
  ISSUES=$((ISSUES+1))
fi

# CHECK 4: Aislamiento Anti-Cloud Sync
CURRENT_DIR=$(pwd)
if echo "$CURRENT_DIR" | grep -Ei "OneDrive|Dropbox|Google Drive" > /dev/null 2>&1; then
  echo -e " [FAIL] VIOLACION ANTI-CLOUD SYNC: El proyecto esta en una carpeta sincronizada en la nube ($CURRENT_DIR)."
  echo -e "        Regla 02: Mueve tu proyecto a una ruta local aislada para evitar corrupcion de dependencias."
  ISSUES=$((ISSUES+1))
else
  echo -e " [PASS] Ubicacion de Disco: Ruta local limpia y aislada de sincronizadores cloud."
fi

# CHECK 5: Docker
if command -v docker > /dev/null 2>&1; then
  if docker info > /dev/null 2>&1; then
    echo -e " [PASS] Docker: En ejecucion activa, listo para Supabase local."
  else
    echo -e " [WARN] Docker instalado pero el demonio no esta corriendo."
    echo -e "        Solucion: Inicia Docker antes de ejecutar 'npx supabase start'."
    WARNINGS=$((WARNINGS+1))
  fi
else
  echo -e " [WARN] Docker no detectado (opcional si usas Supabase Cloud directamente)."
fi

# CHECK 6: Vercel CLI
if command -v vercel > /dev/null 2>&1; then
  echo -e " [PASS] Vercel CLI: $(vercel --version) detectado."
else
  echo -e " [INFO] Vercel CLI: Disponible via 'npx vercel'."
fi

# CHECK 7: Supabase CLI
if command -v supabase > /dev/null 2>&1; then
  echo -e " [PASS] Supabase CLI: $(supabase --version) detectado."
else
  echo -e " [INFO] Supabase CLI: Disponible via 'npx supabase'."
fi

echo -e "\n========================================================"
if [ "$ISSUES" -eq 0 ]; then
  echo -e " [100% OK] ESTADO DEL ENTORNO: SALUDABLE Y ALINEADO"
  if [ "$WARNINGS" -gt 0 ]; then
    echo -e " Se detectaron $WARNINGS advertencias menores no bloqueantes."
  fi
  echo -e " Todo tu equipo puede compilar, probar y desplegar sin sorpresas en Antigravity."
else
  echo -e " [ALERTA] SE ENCONTRARON $ISSUES PROBLEMAS BLOQUEANTES"
  echo -e " Resuelve los puntos marcados en [FAIL] para garantizar compatibilidad total."
fi
echo -e "========================================================\n"
