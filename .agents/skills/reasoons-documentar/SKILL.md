---
name: reasoons-documentar
description: >-
  Escanea exhaustivamente todo el código del proyecto y genera en la carpeta
  'documentacion-oficial/' la documentación completa y funcional entregable al cliente.
  Crea un documento por cada ruta/pantalla del proyecto detallando su propósito,
  funcionalidades interactivas, formularios, validaciones, datos conectados a Supabase
  y flujos de usuario, junto a un índice general y guía de administración.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 📚 Skill: Seven Reasoons Documentation Engine (`reasoons-documentar`)

> **Propósito:** Generar de forma automatizada y exhaustiva la **"Documentación Oficial"** de cualquier proyecto del holding. Entrega al cliente y a su equipo un compendio impecable en formato Markdown con **un documento por cada ruta/página del sistema**, describiendo todas las capacidades, interacciones, formularios y datos conectados sin tecnicismos oscuros, pero con total rigor de ingeniería.

---

## 🏛️ Estructura de la Carpeta `documentacion-oficial/`

Al activarse, la skill estructura la documentación en la raíz del proyecto:

```text
documentacion-oficial/
│
├── 00_indice_general.md             # Resumen ejecutivo, arquitectura y mapa de navegación
│
├── rutas/                           # UN DOCUMENTO POR CADA RUTA DE LA APLICACIÓN
│   ├── 01_inicio.md                 # Pantalla principal (/)
│   ├── tienda.md                    # Catálogo de productos (/tienda)
│   ├── checkout.md                  # Pasarela y checkout (/checkout)
│   ├── citas_agendamiento.md        # Motor de reservas (/citas)
│   ├── dashboard_metricas.md        # Panel de control (/dashboard)
│   └── ...                          # Cualquier otra ruta detectada en el código
│
└── 99_guia_de_administracion.md     # Manual de operación diaria para el dueño del negocio
```

---

## ⚡ Flujo de Ejecución del Agente

Cuando el usuario pida documentar el proyecto o invoque `reasoons-documentar`, el Agente ejecuta estos 4 pasos:

### Paso 1: Escaneo y Descubrimiento de Rutas
1. Ejecutar el script oficial de descubrimiento para registrar todas las páginas del proyecto:
   - **En Windows (PowerShell):**
     ```powershell
     powershell -ExecutionPolicy Bypass -File .\scripts\generate-docs.ps1
     ```
   - **En Mac / Linux / WSL2 (Bash):**
     ```bash
     ./scripts/generate-docs.sh
     ```
2. El script detecta automáticamente todas las rutas en `src/app/**/page.tsx`, `app/**/page.tsx`, `pages/` o `index.html` (prototipos) y genera los archivos base.

---

### Paso 2: Análisis Profundo de Código por Pantalla
Para cada página identificada, el Agente inspecciona el archivo fuente (`page.tsx`) y sus componentes asociados (`components/atoms/`, `molecules/`, `organisms/`, `actions/`):
- ¿Qué botones, modales, pestañas o campos contiene?
- ¿Qué validaciones Zod aplica el formulario?
- ¿Qué tablas de Supabase consulta o actualiza (`SELECT`, `INSERT`, `UPDATE`)?
- ¿Qué permisos RLS requiere el usuario (Público, Logueado, Admin)?

---

### Paso 3: Redacción del Documento de Ruta (Estándar Oficial)
El Agente rellena cada archivo en `documentacion-oficial/rutas/<slug>.md` bajo este estándar obligatorio:

1. **Encabezado y Metadatos:**
   - Nombre de la Pantalla.
   - URL activa (`/`, `/productos/:id`, `/checkout`).
   - Archivo fuente en el repositorio.
2. **🎯 Propósito de la Pantalla:**
   - Qué objetivo de negocio y de usuario cumple esta vista.
3. **⚡ Funcionalidades Disponibles para el Usuario:**
   - Cada acción que el usuario puede realizar: botones, filtros, búsquedas, carritos, descargas, ordenamientos.
4. **📝 Formularios y Datos Solicitados:**
   - Lista de inputs, formatos esperados, campos obligatorios, validaciones en tiempo real y mensajes de confirmación o error.
5. **🗄️ Información Conectada al Sistema (Backend & Supabase):**
   - Tablas que lee o escribe (ej. `public.orders`, `public.leads`, `public.appointments`).
   - Políticas de seguridad y roles permitidos.
6. **🔄 Flujo Paso a Paso del Usuario (User Journey):**
   - Secuencia cronológica desde que el usuario ingresa hasta que completa su objetivo.

---

### Paso 4: Síntesis del Índice y Guía de Administración
1. Actualizar `documentacion-oficial/00_indice_general.md`:
   - Tabla completa de navegación con enlaces relativos a cada archivo en `rutas/`.
   - Ficha del stack: Vercel Edge + Supabase Postgres + Next.js App Router.
2. Actualizar `documentacion-oficial/99_guia_de_administracion.md`:
   - Cómo revisa el cliente sus métricas y base de datos.
   - Buenas prácticas de seguridad.
   - Enlace directo a WhatsApp oficial de soporte Seven Reasoons (`5649328703` con compromiso de respuesta en <1 hora).

---

## 📋 Criterios de Calidad de la Documentación

- **Lenguaje Claro y Profesional:** Redactado para que el director general o dueño del negocio entienda perfectamente el valor de su plataforma sin perderse en tecnicismos innecesarios.
- **Trazabilidad Total:** Cada funcionalidad descrita debe corresponder a un componente o acción real en el código.
- **100% Cobertura de Rutas:** Ninguna página activa de la aplicación debe quedar sin su respectivo documento.
- **Firma Oficial:** Todos los documentos deben incluir la firma:  
  *Made with love by Seven Reasoons &bull; Soporte oficial: 5649328703*
