# 🏛️ Universal Starter Rules Kit (Clase Mundial)

> **El estándar maestro de ingeniería, arquitectura y gobernanza para inicializar cualquier proyecto de software desde cero.**  
> Diseñado para ser agnóstico, modular y 100% estandarizado bajo el stack oficial innegociable: **Vercel + Supabase**.

---

## 🗺️ Mapa de Arquitectura del Kit (3 Capas)

```text
rules/
│
├── 🚀 DÍA 0: EL INICIALIZADOR INTERACTIVO
│   └── 00_project_initializer.md      # Catálogo interactivo de 13 arquetipos y estructuras de carpetas ideales
│
├── 🧠 CAPÍTULO I: EL NÚCLEO INVARIABLE (Obligatorio en el 100% de proyectos)
│   ├── 01_core_philosophy.md          # 5 Axiomas: API-First Radical, i18n Bilingüe (ES/EN), Zod, Topologías
│   ├── 02_system_hygiene_and_env.md   # .editorconfig, LF/CRLF, NVM, Docker, Zod compile-time env.ts
│   ├── 03_naming_and_git_flow.md      # Convenciones de nomenclatura, Conventional Commits, Husky
│   ├── 04_api_and_error_contract.md   # Contrato unificado, RFC 7807, Accept-Language, traceId, Idempotencia
│   ├── 05_observability_and_logs.md   # Logs estructurados en JSON, prohibición de console.log, /health
│   └── 06_devops_ci_cd_and_qa.md     # 3 Entornos, CI/CD GitHub Actions, Playwright data-testid, Rollback
│
├── 🚀 CAPÍTULO II: ESPECIALIZACIONES DE DOMINIO (Módulos activables según la naturaleza)
│   ├── 07_frontend_and_mobile_first.md # Mobile-First radical, 100dvh, 44px touch, hardware modesto 60 FPS
│   ├── 08_ui_system_and_a11y.md       # 3 Presets visuales, Frosted Glass, Wizards, a11y WCAG 2.1 AA
│   ├── 09_backend_and_database.md     # Supabase Postgres, migraciones en Git, RLS, Paginación
│   ├── 10_ai_first_and_generative_ui.md # Vercel AI SDK, Generative UI, Zod tools, privacidad, fallbacks
│   └── 11_multi_tenant_engine.md      # Enrutamiento dinámico en middleware, Design Tokens en runtime
│
└── 🛡️ CAPÍTULO III: EXTENSIÓN ENTERPRISE & ALTA CUSTODIA (FinTech / Cripto / Datos Críticos)
    └── 12_high_custody_security.md    # Security Health Index (SHI 0-100 pts), E2EE WebCrypto, Merkle Trees
```

---

## 👥 Matriz de Carrera y Roles de Equipo (6 Niveles Acumulativos)

El Agente calibra su profundidad técnica, lenguaje y herramientas según el rol declarado por el usuario en el Día 0:

| Nivel | Rol | Función Principal | Especialidad / Acompañamiento del Agente |
|:---:|---|---|---|
| **1** | **🎯 Awareness** | **Ventas, Discovery & Prototipado (<24h)** | **Modo Prototipo Frontend:** Genera prototipos hiper-estéticos de cualquiera de los 18 arquetipos con datos simulados (`mock-data.js`). Cero backend, listo para cerrar ventas en <24h. |
| **2** | **🛠️ Maker** | **Fullstack Junior** | **Familia 1 (Captación):** Next.js App Router y guía paso a paso para modelar tablas y esquemas Zod en Supabase. |
| **3** | **💼 Consultant** | **Fullstack Intermedio** | **Familias 2 y 3 (Comercio & Contenido):** Creación de APIs robustas (RFC 7807), webhooks de Stripe, LMS y calendarios. |
| **4** | **🏛️ Architect** | **Ingeniero Senior** | **Familia 4 (Empresa & Multi-Tenant):** Monorepos Turborepo, subdominios dinámicos y orquestación de Agentes de IA. |
| **5** | **🛡️ Expert** | **Ingeniero Deep-Tech** | **Familia 5 (IA, IoT & BaaS):** Ciberseguridad bancaria (SHI, WebCrypto E2EE, Merkle) y rendimiento extremo (60 FPS). |
| **6** | **👑 Director** | **Líder Técnico & CTPO** | **Sistemas Globales & Negocio:** Diseño ontológico, validación de hipótesis, economía de tokens y estrategia multi-región. |

---

## 📋 Catálogo Oficial de 18 Arquetipos (La Tabla Periódica del Software)

Al detectar un nuevo proyecto, el Agente invoca el menú interactivo con los arquetipos organizados en 5 familias:

### 🟢 Familia 1: Captación & Presencia
1. **🎨 Prototipo solo front end:** HTML5/CSS3/JS Vanilla optimizado para demos en 2 minutos sin dependencias pesadas.
2. **📄 Página web estática:** Blogs, portafolios y sitios institucionales con SSG en Vercel Edge.
3. **🎯 Landing page dinámica:** Formularios validados con Zod, captura directa a Supabase DB y alertas.

### 🔵 Familia 2: Comercio, Transacciones & Monetización
4. **🛍️ E-Commerce B2C Transaccional:** Tienda directa, carrito persistente y checkout Stripe/MercadoPago.
5. **🛒 Marketplace:** Plataforma bilateral multi-vendedor con comisiones y Stripe Connect.
6. **📅 Citas, Agendamiento y Reservas (Booking Engine):** Bloques de tiempo, prevención de colisiones (GiST exclusion) y calendarios.
7. **🔒 Membresías, Suscripciones & Paywall:** Creator economy, muros de pago en el Edge y Stripe Billing.
8. **💳 FinTech, Billetera Digital & Bóveda P2P:** Libros de doble partida (*ledger*), transferencias P2P atómicas y SHI.

### 🟣 Familia 3: Comunidad, Contenido & Aprendizaje
9. **👥 Red social / Comunidad:** Feeds en tiempo real con Supabase Realtime y subida de archivos a Storage.
10. **🎓 Educación, Cursos y Academias Digitales (LMS / EdTech):** Módulos, reproductor HLS, progreso del alumno y diplomas en PDF.

### 🟠 Familia 4: Operaciones & Empresa
11. **📊 Dashboards & Analítica:** Paneles analíticos con Supabase Auth, roles (RBAC) y tablas paginadas.
12. **🏢 Software empresarial (ERP / CRM / Facturación):** Auditoría inmutable, inventario y reportes ejecutivos.
13. **🌐 Software multitenant:** Aislamiento de inquilinos por `tenant_id` y subdominios dinámicos (`cliente.tuapp.com`).
14. **🌍 Software multitenant global:** Multi-región, catálogos federados, multi-moneda y latencia ultra-baja.

### ⚪ Familia 5: Automatización, IA & Telemetría
15. **⚡ Automatización & Integraciones:** Webhooks y tareas programadas (*Vercel Cron Jobs* + *Supabase Edge Functions*).
16. **🤖 Copiloto Agéntico / AI-First:** Vercel AI SDK, streaming de componentes y memoria vectorial `pgvector`.
17. **🏭 IoT Industrial, Telemetría y Monitoreo (Smart Factory):** Ingesta de sensores, canales broadcast y mapas en vivo.
18. **🔌 API Headless / BaaS:** Backend puro para alimentar apps móviles (React Native/Flutter) o IoT.

---

## ⚡ El Stack Innegociable

* **IDE Oficial Obligatorio:** **Google Antigravity IDE** (Todo el equipo opera dentro de Antigravity con agentes, MCPs y reglas unificadas)
* **Alojamiento y Computación:** **Vercel**
* **Base de Datos, Auth, Storage y Realtime:** **Supabase**
* **Internacionalización Base:** Bilingüe nativo mínimo (**Español / Inglés**)
* **Arquitectura:** **API-First Radical** en todos los niveles

---

## 🛠️ Herramientas Llave en Mano Incluidas (100% Turnkey)

El repositorio incluye la infraestructura física lista para arrancar proyectos en 1 segundo:

1. **Diagnóstico de Salud y Alineación del Entorno (`scripts/doctor`):**
   - Audita automáticamente la máquina de cualquier desarrollador según su rol (del 1 al 6), garantizando que todo el equipo trabaje con las mismas versiones sin fricción:
     - En Windows (PowerShell):
       ```powershell
       .\scripts\doctor.ps1
       # O con tu rol específico:
       .\scripts\doctor.ps1 -Role 1  # Awareness (cero dependencias complejas)
       ```
     - En Mac / Linux / WSL2 (Bash):
       ```bash
       chmod +x ./scripts/doctor.sh
       ./scripts/doctor.sh
       ```
2. **Estandarización de IDE para Antigravity (`.vscode/`):**
   - [`.vscode/settings.json`](../.vscode/settings.json): Prettier automático al guardar, auto-corrección de ESLint, salto de línea `\n` (LF) forzado y previsualización inline con `i18n-ally`.
   - [`.vscode/extensions.json`](../.vscode/extensions.json): Extensiones recomendadas del equipo para productividad máxima.
3. **Aprovisionador Instantáneo por CLI (`scripts/init-project`):**
   - En Windows (PowerShell):
     ```powershell
     .\scripts\init-project.ps1
     ```
   - En Mac / Linux / WSL2 (Bash):
     ```bash
     chmod +x ./scripts/init-project.sh
     ./scripts/init-project.sh
     ```
   - *Crea la estructura física de carpetas del arquetipo elegido, `.env.example`, migraciones y plantillas i18n en menos de 200 ms.*
4. **Pipeline de GitHub Actions CI/CD:**
   - Archivo activo: [`.github/workflows/ci.yml`](../.github/workflows/ci.yml)
   - Valida automáticamente Linting, TypeScript (`tsc --noEmit`), Vitest y Playwright en cada Pull Request hacia `main`.
5. **Plantilla Canónica de Supabase CLI Local:**
   - Archivo activo: [`templates/supabase/config.toml`](../templates/supabase/config.toml)
   - Configura puertos locales para Postgres (54322), Studio (54323), Storage S3 y servidor local de correos Inbucket (54324).

---

## 📦 Archivo de Reglas Previas

Las reglas históricas y playbooks de marca previos se encuentran respaldados en:
📁 [`_legacy_archive/`](./_legacy_archive/)

