#!/usr/bin/env bash
# ==============================================================================
# 📚 Seven Reasoons Documentation Generator (reasoons-documentar)
# Bash (Linux / Mac / WSL2)
# ==============================================================================
set -e

PROJECT_PATH=${1:-"."}
DOCS_DIR_NAME=${2:-"documentacion-oficial"}

echo -e "\n================================================================================"
echo -e " 📚 SEVEN REASOONS DOCUMENTATION ENGINE (reasoons-documentar)"
echo -e "    Generador de Documentacion Oficial del Proyecto Ruta por Ruta"
echo -e "================================================================================\n"

RESOLVED_PROJECT="$(cd "$PROJECT_PATH" && pwd)"
TARGET_DOCS_DIR="$RESOLVED_PROJECT/$DOCS_DIR_NAME"
ROUTES_DIR="$TARGET_DOCS_DIR/rutas"

mkdir -p "$TARGET_DOCS_DIR" "$ROUTES_DIR"

echo "[*] Escaneando proyecto en: $RESOLVED_PROJECT"

# 1. Buscar paginas
PAGE_FILES=()
for sp in "src/app" "app" "apps/web/app" "pages" "src/pages"; do
  if [ -d "$RESOLVED_PROJECT/$sp" ]; then
    while IFS= read -r f; do
      if [ -n "$f" ]; then PAGE_FILES+=("$f"); fi
    done < <(find "$RESOLVED_PROJECT/$sp" -type f \( -name "page.tsx" -o -name "page.jsx" -o -name "page.js" -o -name "page.ts" \) 2>/dev/null)
  fi
done

IS_PROTO=0
if [ ${#PAGE_FILES[@]} -eq 0 ] && [ -f "$RESOLVED_PROJECT/index.html" ]; then
  IS_PROTO=1
  PAGE_FILES+=("$RESOLVED_PROJECT/index.html")
fi

echo "   Rutas/Paginas encontradas: ${#PAGE_FILES[@]}"

TABLE_ROWS=""

for f in "${PAGE_FILES[@]}"; do
  REL_PATH="${f#$RESOLVED_PROJECT/}"
  
  if [ "$IS_PROTO" -eq 1 ]; then
    ROUTE_URL="/"
    DOC_SLUG="01_inicio_prototipo"
    PAGE_TITLE="Pagina Principal / Demostracion Interactiva"
  else
    DIR_PART="$(dirname "$REL_PATH")"
    CLEAN_DIR=$(echo "$DIR_PART" | sed -E 's/^(src\/)?app\/?//; s/^(src\/)?pages\/?//; s/^apps\/web\/app\/?//; s/\([^)]*\)\/?//g')
    
    if [ -z "$CLEAN_DIR" ] || [ "$CLEAN_DIR" = "." ]; then
      ROUTE_URL="/"
      DOC_SLUG="01_inicio"
      PAGE_TITLE="Pagina de Inicio (Home)"
    else
      ROUTE_URL="/$CLEAN_DIR"
      DOC_SLUG=$(echo "$CLEAN_DIR" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
      PAGE_TITLE=$(echo "${CLEAN_DIR##*/}" | tr '[:lower:]' '[:upper:]' | tr '-_' ' ')
    fi
  fi

  ROUTE_DOC_PATH="$ROUTES_DIR/$DOC_SLUG.md"
  TABLE_ROWS+=$'| `'"$ROUTE_URL"'` | **'"$PAGE_TITLE"'** | `'"$REL_PATH"'` | [Ver Detalle](rutas/'"$DOC_SLUG"'.md) |\n'

  if [ ! -f "$ROUTE_DOC_PATH" ]; then
    cat <<EOF > "$ROUTE_DOC_PATH"
# 📄 Pantalla: $PAGE_TITLE
> **Ruta en la Aplicacion:** \`$ROUTE_URL\`  
> **Archivo Fuente:** \`$REL_PATH\`  
> **Estado:** Documentado oficialmente para el cliente

---

## 1. 🎯 Proposito de esta Pantalla
Describe aqui la mision principal de esta pantalla dentro de la experiencia del usuario y del modelo de negocio del cliente.

---

## 2. ⚡ Funcionalidades Disponibles para el Usuario
Detalla cada una de las acciones que el usuario puede realizar en esta vista:
- **Accion Principal:** (Ej. Registrarse, Comprar, Agendar, Filtrar datos).
- **Interacciones Secundarias:** (Ej. Navegar a otras vistas, descargar comprobantes, editar perfil).
- **Botones y Llamados a la Accion (CTA):** Comportamiento al hacer clic.

---

## 3. 📝 Formularios y Datos Solicitados
Si esta pantalla recopila informacion:
- **Campos del Formulario:** Lista de campos, formatos requeridos y obligatoriedad.
- **Validaciones en Tiempo Real:** Reglas aplicadas (longitud minima, formato de email, RFC, etc.).
- **Mensajes de Confirmacion / Error:** Que se le muestra al usuario al enviar exitosamente o si hay un fallo.

---

## 4. 🗄️ Informacion Conectada al Sistema (Backend)
- **Datos que Muestra:** De donde proviene la informacion proyectada en la pantalla (Tablas de Supabase / Base de datos).
- **Datos que Guarda o Modifica:** Que registros crea o actualiza al confirmar una accion.
- **Seguridad y Permisos:** Quien puede acceder a esta pantalla (Publico, Usuario autenticado, Administrador).

---

## 5. 🔄 Flujo Paso a Paso del Usuario (User Journey)
1. El usuario entra a \`$ROUTE_URL\`.
2. Observa la informacion principal y los indicadores.
3. Realiza la accion deseada.
4. El sistema valida los datos y responde de forma inmediata.
5. El usuario recibe confirmacion visual.

---
*Documentacion generada con amor por Seven Reasoons &bull; Soporte oficial: 5649328703*
EOF
    echo "   [+] Creado documento de ruta: rutas/$DOC_SLUG.md"
  fi
done

# 3. Indice General
cat <<EOF > "$TARGET_DOCS_DIR/00_indice_general.md"
# 📖 Documentacion Oficial del Proyecto &bull; Manual de Funcionalidades

> **Documentacion ejecutiva y funcional entregable al cliente.**  
> Este manual describe de forma clara y exhaustiva cada una de las paginas, rutas y capacidades que componen la plataforma.

---

## 🗺️ Mapa de Navegacion del Sistema (Rutas Activas)

A continuacion se presenta el inventario completo de pantallas desarrolladas en esta aplicacion:

| Ruta (URL) | Nombre de Pantalla | Archivo Fuente | Documento de Detalle |
|---|---|---|---|
$TABLE_ROWS

---

## 🏛️ Stack Tecnologico y Arquitectura Base
- **Alojamiento y Computacion:** Vercel (Edge Network de alta velocidad y 99.99% disponibilidad).
- **Base de Datos y Autenticacion:** Supabase PostgreSQL con seguridad estricta a nivel de fila (Row Level Security).
- **Diseno e Interfaz:** Tema Claro de alto impacto, mobile-first y optimizado a 60 FPS.
- **Soporte Bilingue:** Arquitectura preparada para Espanol e Ingles nativo.

---

## 📞 Soporte y Atencion al Cliente
- **Canal Oficial de Atencion:** WhatsApp \`5649328703\` (https://wa.me/525649328703)
- **Compromiso de Respuesta:** Menos de una hora.
- **Holding:** *Made with love by Seven Reasoons*
EOF

echo "   [PASS] Indice general generado: 00_indice_general.md"

# 4. Guia de Administracion
cat <<'EOF' > "$TARGET_DOCS_DIR/99_guia_de_administracion.md"
# 💼 Guia de Administracion y Operacion del Negocio

> **Manual de operacion para el dueno del producto y administradores.**

---

## 1. 📊 Como Monitorear tu Plataforma
- **Acceso a la Base de Datos:** A traves del panel oficial de Supabase.
- **Revision de Metricas:** Visualizacion de visitas, conversiones y tiempos de carga en Vercel Analytics.

## 2. 🔐 Gestion de Usuarios y Seguridad
- Todas las contrasenas estan cifradas y los accesos protegidos por politicas RLS (Row Level Security).
- Los administradores pueden visualizar altas de clientes y registros en tiempo real.

## 3. 🚨 Protocolo ante Incidencias
En caso de requerir soporte tecnico o actualizaciones:
1. Contactar a soporte Seven Reasoons por WhatsApp al **5649328703**.
2. Indicar la ruta o pantalla donde se detecto el detalle.
3. Tiempo de respuesta garantizado: **Menos de una hora**.
EOF

echo "   [PASS] Guia de administracion creada: 99_guia_de_administracion.md"

echo -e "\n================================================================================"
echo -e " [PASS] DOCUMENTACION OFICIAL GENERADA EN: $TARGET_DOCS_DIR"
echo -e "================================================================================\n"
