# 🏛️ Universal Starter Rules Kit (Clase Mundial)

> **El estándar maestro de ingeniería, arquitectura y gobernanza para inicializar cualquier proyecto de software desde cero.**  
> Diseñado para ser agnóstico, modular y 100% estandarizado bajo el stack oficial innegociable: **Vercel + Supabase**.

---

## 🗺️ Mapa de Arquitectura del Kit (3 Capas)

```text
.agents/standards/
│
├── 🚀 DÍA 0: EL INICIALIZADOR INTERACTIVO
│   └── 00_project_initializer.md      # Catálogo interactivo de 18 arquetipos y estructuras de carpetas ideales
│                                      # Operado mediante reasoons-start y scripts/start-project.ps1 / .sh
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
│   ├── 11_multi_tenant_engine.md      # Enrutamiento dinámico en middleware, Design Tokens en runtime
│   ├── 13_visual_identity_manual.md   # Manual de Identidad Seven Reasoons, Degradado en bordes, CTA, Logo, WhatsApp
│   └── 14_prototype_ui_components_cheatsheet.md # Catálogo de componentes de copia y pega en Tema Claro para prototipos
│
└── 🛡️ CAPÍTULO III: EXTENSIÓN ENTERPRISE & ALTA CUSTODIA (FinTech / Cripto / Datos Críticos)
    └── 12_high_custody_security.md    # Security Health Index (SHI 0-100 pts), E2EE WebCrypto, Merkle Trees
```

---

## 👥 Matriz de Carrera y Roles de Equipo (6 Niveles Acumulativos)

El Agente calibra su profundidad técnica, lenguaje y herramientas según el rol declarado por el usuario en el Día 0:

| Nivel | Rol | Función Principal | Especialidad / Acompañamiento del Agente |
|:---:|---|---|---|
| **1** | **🎯 Awareness** | **Ventas, Discovery & Prototipado (<24h)** | **Modo Prototipo Frontend:** Genera prototipos hiper-estéticos bajo el **Manual de Identidad Visual Seven Reasoons (Regla 13)** con datos simulados (`mock-data.js`). Cero backend, listo para cerrar ventas en <24h. |
| **2** | **🛠️ Maker** | **Frontend Profesional & Atómico** | **Familias 1 & 2 (Captación & Comercio Básico):** Next.js App Router con **Atomic Design** (`atoms/`, `molecules/`, `organisms/`, `templates/`), componentes desacoplados para handoff fluido a Senior, y conexión de backend sencillo (CRUDs en Supabase). |
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

## ⚡ Suite Oficial de Skills (`reasoons-*`)

Todas las habilidades y automatizaciones del holding se encuentran estandarizadas bajo el prefijo unificado `reasoons-*` en [`.agents/skills/`](../skills/):

- **Arrancadores:**
  - **`reasoons-start`**: Arranque llave en mano de proyectos en carpeta nueva e independiente.
  - **`reasoons-project-init`**: Aprovisionamiento dentro del repositorio activo.
- **Documentación:**
  - **`reasoons-documentar`**: Generador de documentación oficial ruta por ruta entregable al cliente.
- **Interfaz de Usuario (UI):**
  - **`reasoons-ui-pure`**: Prototipos comerciales interactivos (<24h, Tema Claro, borde degradado 2px, interior blanco sólido, botón CTA y WhatsApp oficial).
  - **`reasoons-ui-minimalist`**: Erradicación de estilos genéricos bajo estándares modernos de Google Chrome para producción de clientes.
  - **`reasoons-ui-atomic`**: Arquitectura atómica en Next.js (`atoms`, `molecules`, `organisms`, `templates`) con Pure UI para handoff fluido a Seniors.
- **Experiencia de Usuario (UX):**
  - **`reasoons-ux-flows`**: Flujos multi-paso, Wizards de onboarding, embudos y checkouts sin ruido visual (Zero-Clutter).
  - **`reasoons-ux-mobile-first`**: Ergonomía táctil móvil, 100dvh, touch targets mínimos de 44x44px y 60 FPS.
- **6 Auditores de Calidad (Ordenados por Complejidad Progresiva):**
  - **`reasoons-audit01-clean-code`**: Arquitectura limpia, antipatrones, nomenclatura y Git.
  - **`reasoons-audit02-frontend`**: UI Next.js, Atomic Design, 100dvh, accesibilidad WCAG.
  - **`reasoons-audit03-backend`**: Contratos RFC 7807, Server Actions, Idempotencia y Zod.
  - **`reasoons-audit04-database`**: Supabase PostgreSQL, RLS, índices B-Tree e integridad.
  - **`reasoons-audit05-performance`**: Core Web Vitals, 60 FPS, caching y límites de RAM.
  - **`reasoons-audit06-security`**: Ciberseguridad SHI, WebCrypto E2EE, Merkle Trees y PII.
- **6 Roles de Carrera (Escala Acumulativa de Madurez):**
  - **`reasoons-role01-awareness`**: Ventas y Demos <24h.
  - **`reasoons-role02-maker`**: Frontend Atómico profesional + Backend Familia 2.
  - **`reasoons-role03-consultant`**: Fullstack intermedio, Familias 2 & 3.
  - **`reasoons-role04-architect`**: Senior, Familia 4 & Multi-tenant.
  - **`reasoons-role05-expert`**: Deep-Tech, Familia 5, Criptografía & IoT.
  - **`reasoons-role06-director`**: Liderazgo técnico global & Estrategia.
- **18 Arquetipos Maestros de Software (5 Familias):**
  - Familia 1 (Frontend & Presencia): `reasoons-archetype01-proto-front` a `reasoons-archetype03-landing-leads`.
  - Familia 2 (Transaccional & Monetización): `reasoons-archetype04-ecommerce` a `reasoons-archetype08-fintech`.
  - Familia 3 (Social & Contenido): `reasoons-archetype09-social-network` y `reasoons-archetype10-edtech-lms`.
  - Familia 4 (Operaciones & SaaS B2B): `reasoons-archetype11-dashboard-analytics` a `reasoons-archetype14-global-multitenant`.
  - Familia 5 (Deep-Tech, IA & Crons): `reasoons-archetype15-automation-crons` a `reasoons-archetype18-headless-baas`.

---

## 📦 Archivo de Reglas Previas

Las reglas históricas y playbooks de marca previos se encuentran respaldados en:
📁 [`.agents/archive/_legacy_archive/`](../archive/_legacy_archive/)

