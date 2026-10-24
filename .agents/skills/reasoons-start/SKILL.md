---
name: reasoons-start
description: >-
  [⭐ RECOMENDADO - NUEVO PROYECTO] Inicia por defecto un proyecto llave en mano en una
  CARPETA NUEVA e INDEPENDIENTE (fuera del workspace actual) clonando SevenReasoons/start
  (o plantilla local), preguntando nombre, rol (1-6) y arquetipo (1-18), aprovisionando
  la arquitectura, instalando dependencias (npm install) y configurando extensiones de IDE.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# ⭐ Skill: Seven Reasoons Project Starter (`reasoons-start`)

> **Propósito:** Ser la vía más rápida, sencilla y automatizada para arrancar un proyecto en el ecosistema Seven Reasoons. En un solo flujo interactivo clona el repositorio base, solicita los datos esenciales, crea una carpeta limpia independiente, aprovisiona el arquetipo, instala dependencias y configura las extensiones de desarrollo en Google Antigravity IDE.

---

## ⚡ Flujo de Ejecución Automatizado

Cuando el desarrollador invoque `reasoons-start` o pida iniciar un nuevo proyecto desde cero, el Agente debe ejecutar este flujo:

### 1. Diálogo Interactivo con el Usuario
Preguntar amigablemente los 3 parámetros de configuración (o capturarlos si el usuario ya los mencionó en el prompt):
1. **Nombre del Proyecto:** Slug en kebab-case (ej. `tienda-don-pedro`, `saas-crm`, `clinica-dental`).
2. **Rol de Equipo (1 a 6):**
   - `[1] Awareness:` Ventas & Prototipos interactivos (<24h, sin Docker/Node, Mock Data)
   - `[2] Maker:` Frontend Profesional Atómico Next.js & Supabase CRUD (Handoff a Senior)
   - `[3] Consultant:` Fullstack Intermedio (Familias 2 & 3, APIs RFC 7807, Stripe)
   - `[4] Architect:` Senior (Familia 4, Multi-Tenant dinámico, Turborepo)
   - `[5] Expert:` Deep-Tech (Familia 5, IoT telemetría, Ciberseguridad SHI, 60 FPS)
   - `[6] Director:` CTPO / Estrategia Global de Negocio
3. **Arquetipo Maestro (1 a 18):**
   - Presentar la familia correspondiente al interés del usuario o listar los arquetipos de la Tabla Periódica.
4. **Ubicación de la Carpeta:**
   - Por defecto: Carpeta hermana en el escritorio o directorio superior (`..\<nombre-proyecto>`).

---

### 2. Ejecución del Starter Llave en Mano

Ejecutar el script oficial pasándole los parámetros acordados:

#### En Windows (PowerShell):
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-project.ps1 -ProjectName "<slug>" -Role <1-6> -Archetype <1-18>
```

#### En Mac / Linux / WSL2 (Bash):
```bash
./scripts/start-project.sh "<slug>" <1-6> <1-18>
```

---

### 3. Operaciones que Realiza Automáticamente el Starter

1. **Clonado Limpio:** Clona `https://github.com/SevenReasoons/start.git` (o realiza una copia local de la plantilla maestra si no hay conexión a internet).
2. **Git Fresh:** Elimina el `.git` heredado e inicializa un repositorio nuevo con `git init -b main` para que el proyecto del cliente nazca con su propio historial.
3. **Aprovisionamiento de Código:**
   - **Rol 1 (Awareness):** Prototipo ultrarrápido bajo el estándar **Seven Reasoons Pure** (Tema Claro, borde degradado 2px con fondo blanco sólido, botón 16px, WhatsApp oficial y `mock-data.js`). Cero descargas pesadas de npm.
   - **Roles 2 a 6 (Maker a Director):** Arquitectura Next.js App Router (Atomic Design en Maker con `atoms/`, `molecules/`, `organisms/`, `templates/`), esquemas relacionales PostgreSQL en Supabase, contratos RFC 7807 y soporte bilingüe i18n.
4. **Configuración de Extensiones en `.vscode/extensions.json`:**
   - Tailwind CSS IntelliSense (`bradlc.vscode-tailwindcss`)
   - ESLint (`dbaeumer.vscode-eslint`)
   - Prettier (`esbenp.prettier-vscode`)
   - Supabase Oficial (`supabase.supabase-vscode`)
   - Vercel Oficial (`vercel.vercel-vscode`)
   - i18n Ally (`lokalise.i18n-ally`)
   - ErrorLens (`usernamehw.errorlens`)
   - GitLens (`eamodio.gitlens`)
5. **Instalación de Dependencias:**
   - Ejecuta `npm install` (o `pnpm install`) automáticamente para roles Fullstack (2 al 6).
6. **Diagnóstico de Salud (Doctor):**
   - Ejecuta `scripts/doctor.ps1` o `doctor.sh` para verificar Node v20+, herramientas y variables de entorno.

---

### 4. Guía de Entrega y Puesta en Marcha

Al finalizar, informar al usuario con enlaces clicables:
1. **Ruta del nuevo proyecto:** `[nombre-proyecto](file:///ruta/completa)`
2. **Comando para abrir en Antigravity IDE:**
   ```bash
   code "C:\ruta\al\nuevo\proyecto"
   ```
3. **Comando de arranque:**
   - Si es **Awareness (Rol 1):** Abrir `index.html` en el navegador o `npx vercel dev`.
   - Si es **Maker / Fullstack (Roles 2-6):** `cd "C:\ruta\al\nuevo\proyecto"` y luego `npm run dev`.
