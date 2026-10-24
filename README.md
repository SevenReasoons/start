# 🚀 Seven Reasons — Universal Starter Kit (`start`)

> **El repositorio maestro para inicializar cualquier proyecto de software dentro del ecosistema Seven Reasons.**  
> Diseñado para ser clonado como punto de partida estandarizado, turnkey e inteligente, operado exclusivamente en **Google Antigravity IDE** bajo el stack innegociable: **Vercel + Supabase**.

---

## ⚡ El Stack Innegociable

* **IDE Oficial Obligatorio:** **Google Antigravity IDE** (Todo el equipo opera dentro de Antigravity con agentes autónomos, MCPs y gobernanza de reglas).
* **Alojamiento y Computación en el Edge:** **Vercel** (Next.js App Router, Edge Middleware, Cron Jobs).
* **Capa de Datos, Auth, Storage y Realtime:** **Supabase** (PostgreSQL, Row Level Security, Storage S3, Realtime Channels).
* **Internacionalización Base:** Bilingüe nativo mínimo (**Español `es` / Inglés `en`**).
* **Arquitectura:** **API-First Radical** en todas las capas (contrato unificado RFC 7807).

---

## 🏁 Inicio Rápido en 4 Pasos (Day 0 Onboarding)

Cualquier persona del equipo arranca un proyecto nuevo en menos de 2 minutos siguiendo estos pasos:

### 1. Clonar el Repositorio Starter
```bash
git clone https://github.com/SevenReasoons/start.git mi-nuevo-proyecto
cd mi-nuevo-proyecto
```

### 2. Abrir en Google Antigravity IDE
Abre la carpeta del proyecto dentro de **Google Antigravity**.  
*Antigravity cargará automáticamente las configuraciones de formato con Prettier, auto-fix de ESLint al guardar, saltos de línea LF y soporte inline para traducciones en [`.vscode/`](./.vscode/).*

### 3. Diagnosticar la Salud del Entorno (`doctor`)
Verifica que tu máquina esté alineada según tu nivel de responsabilidad:
* **En Windows (PowerShell):**
  ```powershell
  .\scripts\doctor.ps1
  # O indicando tu rol directamente (ej. rol 1 Awareness sin dependencias pesadas):
  .\scripts\doctor.ps1 -Role 1
  ```
* **En Mac / Linux / WSL2 (Bash):**
  ```bash
  chmod +x ./scripts/doctor.sh
  ./scripts/doctor.sh 1
  ```

### 4. Inicializar la Estructura de Carpetas del Arquetipo (`init-project`)
Ejecuta el aprovisionador para crear la estructura física en menos de 200 ms:
* **En Windows (PowerShell):**
  ```powershell
  .\scripts\init-project.ps1
  ```
* **En Mac / Linux / WSL2 (Bash):**
  ```bash
  chmod +x ./scripts/init-project.sh
  ./scripts/init-project.sh
  ```

---

## 👥 Matriz de Carrera y Roles de Equipo (6 Niveles Acumulativos)

El Agente de Antigravity adapta su profundidad técnica, lenguaje y asistencia según el rol declarado:

| Nivel | Rol | Función Principal | Especialidad / Acompañamiento del Agente |
|:---:|---|---|---|
| **1** | **🎯 Awareness** | **Ventas, Discovery & Prototipado (<24h)** | **Modo Prototipo Frontend:** Genera prototipos hiper-estéticos de cualquiera de los 18 arquetipos con datos simulados (`mock-data.js`). Cero backend ni Docker, listo para proyectar y vender en <24h. |
| **2** | **🛠️ Maker** | **Fullstack Junior** | **Familia 1 (Captación):** Next.js App Router y guía paso a paso para modelar tablas y esquemas Zod en Supabase. |
| **3** | **💼 Consultant** | **Fullstack Intermedio** | **Familias 2 y 3 (Comercio & Contenido):** Creación de APIs robustas (RFC 7807), pasarelas Stripe, webhooks y LMS. |
| **4** | **🏛️ Architect** | **Ingeniero Senior** | **Familia 4 (Empresa & Multi-Tenant):** Monorepos Turborepo, subdominios dinámicos y orquestación de Agentes de IA. |
| **5** | **🛡️ Expert** | **Ingeniero Deep-Tech** | **Familia 5 (IA, IoT & BaaS):** Ciberseguridad bancaria (SHI, WebCrypto E2EE, Merkle) y rendimiento extremo (60 FPS). |
| **6** | **👑 Director** | **Líder Técnico & CTPO** | **Sistemas Globales & Negocio:** Diseño ontológico, validación de hipótesis, economía de tokens y estrategia multi-región. |

---

## 📋 Catálogo Oficial de 18 Arquetipos (La Tabla Periódica del Software)

### 🟢 Familia 1: Captación & Presencia
1. **🎨 Prototipo solo front end:** HTML5/CSS3/JS Vanilla optimizado para demos en 2 minutos sin dependencias pesadas.
2. **📄 Página web estática:** Blogs, portafolios y sitios institucionales con SSG en Vercel Edge.
3. **🎯 Landing page dinámica:** Formularios validados con Zod, captura directa a Supabase DB y alertas.

### 🔵 Familia 2: Comercio, Transacciones & Monetización
4. **🛍️ E-Commerce B2C Transaccional:** Tienda directa, carrito persistente y checkout Stripe/MercadoPago.
5. **🛒 Marketplace:** Plataforma bilateral multi-vendedor con comisiones y Stripe Connect.
6. **📅 Citas, Agendamiento y Reservas (Booking Engine):** Bloques de tiempo, prevención de colisiones (GiST) y calendarios.
7. **🔒 Membresías, Suscripciones & Paywall:** Creator economy, muros de pago en el Edge y Stripe Billing.
8. **💳 FinTech, Billetera Digital & Bóveda P2P:** Libros de doble partida (*ledger*), transferencias P2P atómicas y SHI.

### 🟣 Familia 3: Comunidad, Contenido & Aprendizaje
9. **👥 Red social / Comunidad:** Feeds en tiempo real con Supabase Realtime y subida de archivos a Storage.
10. **🎓 Educación, Cursos y Academias Digitales (LMS / EdTech):** Módulos, reproductor HLS, progreso y diplomas en PDF.

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

## 🗺️ Mapa Normativo del Kit de Reglas

Toda la documentación técnica profunda se encuentra en la carpeta [`rules/`](./rules/):

- [`rules/00_project_initializer.md`](./rules/00_project_initializer.md): Catálogo de arquetipos, roles y estructuras ideales.
- [`rules/01_core_philosophy.md`](./rules/01_core_philosophy.md): 5 Axiomas, API-First, i18n bilingüe y topologías.
- [`rules/02_system_hygiene_and_env.md`](./rules/02_system_hygiene_and_env.md): Mandato de Antigravity IDE, `.vscode/`, `doctor` y variables de entorno Zod.
- [`rules/03_naming_and_git_flow.md`](./rules/03_naming_and_git_flow.md): Convenciones de nomenclatura y Conventional Commits.
- [`rules/04_api_and_error_contract.md`](./rules/04_api_and_error_contract.md): Contrato unificado RFC 7807 e Idempotencia.
- [`rules/05_observability_and_logs.md`](./rules/05_observability_and_logs.md): Logs estructurados JSON y health checks.
- [`rules/06_devops_ci_cd_and_qa.md`](./rules/06_devops_ci_cd_and_qa.md): Pipeline de CI/CD, Vitest y Playwright.
- [`rules/07_frontend_and_mobile_first.md`](./rules/07_frontend_and_mobile_first.md): Mobile-First, touch targets y 60 FPS.
- [`rules/08_ui_system_and_a11y.md`](./rules/08_ui_system_and_a11y.md): Presets de diseño, Frosted Glass y accesibilidad.
- [`rules/09_backend_and_database.md`](./rules/09_backend_and_database.md): Supabase PostgreSQL, RLS y migraciones.
- [`rules/10_ai_first_and_generative_ui.md`](./rules/10_ai_first_and_generative_ui.md): Vercel AI SDK y Generative UI.
- [`rules/11_multi_tenant_engine.md`](./rules/11_multi_tenant_engine.md): Enrutamiento dinámico y subdominios.
- [`rules/12_high_custody_security.md`](./rules/12_high_custody_security.md): Seguridad de alta custodia (SHI, WebCrypto E2EE, Merkle).

---

## 📄 Licencia

Propiedad exclusiva de **Seven Reasons Holding**. Todos los derechos reservados.
