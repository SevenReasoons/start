---
trigger: always_on
---

# 🚀 00. Inicializador Interactivo de Proyectos, Roles de Equipo y Arquetipos

> **Propósito:** Definir el protocolo de arranque Día 0. Cuando un Agente de IA o desarrollador inicialice un repositorio nuevo o vacío, **DEBE detenerse y ejecutar el interrogatorio interactivo en dos pasos**:
> 1. **Paso 1: Identificación del Rol del Usuario** (Nivel de entrenamiento y alcance de asistencia).
> 2. **Paso 2: Selección del Arquetipo de Software** (Los 18 arquetipos en 5 familias).
>
> Todo bajo el stack oficial innegociable de **Vercel + Supabase**, arquitectura **API-First** e **i18n bilingüe nativo (ES/EN)**.

---

## 1. El Stack Innegociable (Vercel + Supabase)

En todo proyecto, sin excepción de escala o naturaleza:
* **Hosting, Edge & Serverless:** **Vercel** (CDN Global, Edge Middleware, Serverless Functions, Cron Jobs y analítica web).
* **Capa de Datos, Auth & Storage:** **Supabase** (PostgreSQL relacional, Autenticación, RLS, Storage S3, Realtime y Edge Functions).
* **Internacionalización Base:** Bilingüe nativo mínimo (**Español `es` / Inglés `en`**).
* **Arquitectura:** **API-First Radical** en todas las capas.

---

## 2. Paso 1: Los 6 Roles de Equipo Acumulativos (Career Matrix)

El Agente DEBE adaptar su lenguaje, nivel de abstracción y herramientas según el rol activo del desarrollador:

| Nivel | Rol | Perfil y Misión Principal | Alcance de Arquetipos | Cómo Asiste el Agente de IA |
|:---:|---|---|:---:|---|
| **1** | **🎯 Awareness** | **Ventas, Discovery & Prototipado Rápido (<24h).** Perfil no técnico en aprendizaje. Su función es entender el dolor del cliente, crear un prototipo funcional visualmente impactante y cerrar la venta. Cero configuración de backend. | **Cualquiera de los 18** *(En Modo Prototipo Frontend)* | Actúa como **Mago de UI**. Genera interfaces completas, hiper-estéticas (Frosted Glass, micro-animaciones, responsive) con datos simulados (*mock data*). Cero fricción de Docker o SQL. Listo para presentar en <24h. |
| **2** | **🛠️ Maker** | **Frontend Profesional & Atómico.** Especialista en maquetación de alta fidelidad e ingeniería de UI escalable con Next.js App Router. Trabaja bajo la metodología **Atomic Design** (`atoms/`, `molecules/`, `organisms/`, `templates/`) con TypeScript estricto y estilos desacoplados, de modo que un Senior solo deba conectar datos. Conecta backend **sencillo** (CRUDs en Supabase) para apps de la **Familia 2** (Comercio & Transacciones básicas) y Familia 1. | **Familias 1 & 2** (Captación, Comercio Básico & Transaccional) | Actúa como **Arquitecto de Componentes Atómicos & Mentor Fullstack Inicial**. Garantiza componentes puros y reutilizables en Next.js, props desacopladas, tokens de estilo sin clases caóticas, y guía en la conexión de esquemas y queries básicas en Supabase. |
| **3** | **💼 Consultant** | **Fullstack Intermedio.** Ya domina la estructura de datos relacional. Construye plataformas de monetización y contenido. | **Familias 2 & 3** (Comercio, Membresías, LMS) | Actúa como **Especialista en APIs e Integraciones**. Asiste construyendo Route Handlers, pasarelas Stripe, webhooks, subida de archivos y contratos de API (RFC 7807). |
| **4** | **🏛️ Architect** | **Ingeniero Senior.** Diseña y construye de forma autónoma sistemas empresariales densos y SaaS B2B. Necesita velocidad máxima. | **Familia 4** (Operaciones & Multi-Tenant) | Actúa como **Acelerador de Sistemas & Agentes**. Genera topologías Monorepo Turborepo, middleware multi-tenant dinámico y orquestación de Agentes IA jerárquicos. |
| **5** | **🛡️ Expert** | **Ingeniero Deep-Tech.** Desarrolla proyectos de automatización, IA nativa e IoT industrial. | **Familia 5** (IA, IoT, Telemetría, BaaS) | Actúa como **Auditor de Seguridad & Rendimiento Extremo**. Audita fugas de memoria, WebSockets en tiempo real, canales broadcast, árboles de Merkle, WebCrypto E2EE y SHI. |
| **6** | **👑 Director** | **Líder Técnico & Estratégico (CTPO).** Se desenvuelve en el plano ontológico y de negocio. Conecta arquitectura, retorno de inversión y escalabilidad global. | **Sistemas Globales & Ecosistemas** | Actúa como **Par Estratégico de Arquitectura Ontológica**. Prueba de hipótesis, diseño de gobernanza de datos multi-región, economía de tokens y contratos B2B. |

*Nota:* Cada rol es acumulativo; un Architect puede prototipar como Awareness o auditar como Maker, pero el rol declara el **foco de acompañamiento del Agente**.

---

## 3. Paso 2: El Catálogo Oficial de 18 Arquetipos (La Tabla Periódica del Software)

### ❓ Pregunta Inicial del Agente:
1. *"¿Cuál es tu rol en este proyecto?"* `[1: Awareness | 2: Maker | 3: Consultant | 4: Architect | 5: Expert | 6: Director]`
2. *"¿Qué tipo de proyecto deseas construir hoy?"* `[1 al 18]`

```text
🟢 FAMILIA 1: CAPTACIÓN & PRESENCIA
  [01] 🎨 Prototipo solo front end (HTML5/CSS3/JS ultra-rápido en 2 min)
  [02] 📄 Página web estática (SSG, Blogs, Portafolios institucionales en Edge)
  [03] 🎯 Landing page dinámica (Captura de leads con Supabase DB y Zod)

🔵 FAMILIA 2: COMERCIO, TRANSACCIONES & MONETIZACIÓN
  [04] 🛍️ E-Commerce B2C Transaccional (Tienda directa, carrito, pasarela Stripe)
  [05] 🛒 Marketplace (Bilateral multi-vendedor con comisiones y Stripe Connect)
  [06] 📅 Citas, Agendamiento y Reservas (Booking Engine, time-slots sin doble reserva)
  [07] 🔒 Membresías y Paywall (Creator Economy con Stripe Billing y control en Edge)
  [08] 💳 FinTech & Billeteras Digitales (Ledger doble partida, P2P y alta custodia)

🟣 FAMILIA 3: COMUNIDAD, CONTENIDO & APRENDIZAJE
  [09] 👥 Red social & Comunidad (Feeds en vivo con Supabase Realtime y Storage)
  [10] 🎓 Educación, Cursos y Academias (LMS / EdTech, reproductor HLS y diplomas)

🟠 FAMILIA 4: OPERACIONES & EMPRESA
  [11] 📊 Dashboards & Analítica (Métricas, KPIs, reportes y RBAC)
  [12] 🏢 Software empresarial (ERP / CRM / Facturación, inventario y auditoría)
  [13] 🌐 Software multitenant (SaaS B2B, aislamiento por tenant_id y subdominios)
  [14] 🌍 Software multitenant global (Multi-región, catálogos federados y multi-moneda)

⚪ FAMILIA 5: AUTOMATIZACIÓN, IA & TELEMETRÍA
  [15] ⚡ Automatización & Integraciones (Crons, webhooks, colas y Edge Functions)
  [16] 🤖 Copiloto Agéntico / AI-First (Vercel AI SDK, streaming RSC y pgvector)
  [17] 🏭 IoT & Telemetría en Tiempo Real (Smart Factory, sensores y mapas en vivo)
  [18] 🔌 API Headless / Backend-as-a-Service (Backend puro para apps móviles o IoT)
```

---

## 4. Modo Prototipado Rápido para Awareness (Cualquier Arquetipo en <24h)

Si el usuario declara rol **Awareness**, el Agente activa el **Modo Prototipo de Venta**:
1. Construye el arquetipo elegido (sea un Marketplace, un LMS o una FinTech) **completamente en el Frontend**.
2. Simula las bases de datos con un archivo estructurado `js/mock-data.js`.
3. Aplica estrictamente el **Manual de Identidad Visual Seven Reasoons (`.agents/standards/13_visual_identity_manual.md`)**:
   - **Prioridad de Tema:** **Tema Claro Obligatorio por Defecto (Luxury Minimalist Light)**. Fondos blancos aireados (`bg-white`), superficies limpias (`bg-slate-50`) y textos oscuros de alta legibilidad (`text-slate-900` / `text-slate-600`).
   - Degradado de 4 colores (`#ef4444`, `#f97316`, `#22c55e`, `#3b82f6`) **exclusivo para bordes de 2px** y acentos técnicos.
   - **Regla de Oro:** NUNCA usar el degradado como relleno de botones o tarjetas. Los rellenos son sólidos (blanco en interior de tarjetas y botones CTA).
   - Tipografía Google Fonts `Inter` con `tracking-tighter` en encabezados y `tracking-widest` en labels.
   - Botón CTA con borde degradado de 2px con relleno interior sólido blanco, radio `rounded-2xl` (16px), hover `-translate-y-1` y `shadow-2xl`.
   - Footer oficial con el isotipo Seven Reasoons (`opacity-50 grayscale hover:opacity-100 hover:grayscale-0`), enlace directo a WhatsApp oficial (`5649328703`) y compromiso de respuesta: *"Respondemos en menos de una hora"*.
4. El prototipo corre en local o en Vercel con cero dependencias complejas de base de datos, permitiendo al Awareness mostrar flujos interactivos completos (hacer clic en transferir dinero, reproducir video de curso, agendar cita) y maravillar al cliente antes de 24 horas para cerrar la venta.

---

## 5. Modo Maker: Frontend Profesional Atómico y Handoff a Senior

Cuando el usuario declara rol **Maker**, el Agente activa el **Estándar de Frontend Atómico Profesional en Next.js**:

### A. Jerarquía Atómica Obligatoria (Atomic Design)
Todo desarrollo frontend se estructura modularmente en 5 niveles de granularidad:
```text
components/
├── atoms/       # Elementos visuales indivisibles: Button, Badge, Input, Label, Icon, Spinner
├── molecules/   # Combinaciones de 2 o más átomos: SearchBar, StatCard, FormField, UserAvatar
├── organisms/   # Bloques complejos de interfaz: Navbar, Sidebar, ProductGrid, DataTable, Modal
├── templates/   # Layouts estructurales con slots/children: DashboardTemplate, StoreTemplate
└── app/         # Páginas puras en Next.js App Router (Composición declarativa sin maquetación inline)
```

### B. Protocolo de Handoff a Senior (Consultant / Architect)
1. **Componentes Puros de Presentación:** Los átomos, moléculas y organismos se maquetan como componentes puros desacoplados de llamadas directas a APIs complejas. Reciben sus datos y eventos mediante `props` estrictamente tipadas con TypeScript (`interface ProductCardProps { ... }`).
2. **Reutilización de Estilos en Next.js:** Prohibidas las clases caóticas o CSS duplicado. Se aprovechan tokens de diseño, CSS Modules o utilidades moduladas para que la aplicación sea hiper-escalable.
3. **Cero Retrabajo para el Senior:** Cuando un ingeniero Senior (Architect o Consultant) recibe el repositorio del Maker:
   - **NO tiene que tocar la maquetación ni los estilos.**
   - Únicamente conecta las fuentes de datos (hooks de Supabase, Server Actions, estados globales o APIs) directamente a las `props` ya listas y tipadas por el Maker.

### C. Alcance de Backend del Maker (Familia 2 Sencillo)
- El Maker sí conecta backend, pero con un enfoque **sencillo y transaccional**:
  - Operaciones CRUD básicas en Supabase (ej. listado de productos de tienda, agregar a carrito, guardar orden simple, autenticación básica Supabase Auth).
  - Server Actions en Next.js con validación Zod de entrada.
  - La lógica financiera densa, comisiones multi-vendedor o subdominios se reservan para roles Consultant / Architect.

---

## 6. Instrucción de Aprovisionamiento Automático

### Opción A (Recomendada): Arranque en Carpeta Nueva e Independiente (`reasoons-start`)
La forma más ágil y limpia. Clona la base oficial, inicializa Git fresco, aprovisiona el arquetipo, instala dependencias y configura extensiones de IDE:
* **En Windows (PowerShell):**
  ```powershell
  powershell -ExecutionPolicy Bypass -File .\scripts\start-project.ps1 -ProjectName "[nombre]" -Role [1-6] -Archetype [1-18]
  ```
* **En Linux / Mac / WSL2 (Bash):**
  ```bash
  ./scripts/start-project.sh "[nombre]" [1-6] [1-18]
  ```

### Opción B: Inicialización en el Directorio Actual (`init-project`)
Para aprovisionar dentro del workspace o repositorio activo:
* **En Windows (PowerShell):**
  ```powershell
  .\scripts\init-project.ps1 -Role [1-6] -Archetype [1-18] -ProjectName "[nombre]"
  ```
* **En Linux / Mac / WSL2 (Bash):**
  ```bash
  ./scripts/init-project.sh [1-6] [1-18] "[nombre]"
  ```
