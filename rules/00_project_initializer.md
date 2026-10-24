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
| **2** | **🛠️ Maker** | **Fullstack Junior.** Desarrolla proyectos de producción de entrada. Usa Next.js y Vercel. Necesita guía para no cometer errores en la base de datos. | **Familia 1** (Captación & Presencia) | Actúa como **Mentor de Base de Datos**. Asiste diseñando tablas en Supabase, esquemas Zod, llaves foráneas y Server Actions básicas. |
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
3. Aplica estilos minimalistas premium (Luxury Light o Stealth Dark con Frosted Glass).
4. El prototipo corre en local o en Vercel con cero dependencias complejas de base de datos, permitiendo al Awareness mostrar flujos interactivos completos (hacer clic en transferir dinero, reproducir video de curso, agendar cita) y maravillar al cliente antes de 24 horas para cerrar la venta.

---

## 5. Instrucción de Aprovisionamiento Automático

El aprovisionamiento físico se ejecuta en menos de 200 ms mediante los scripts oficiales:
* **En Windows (PowerShell):**
  ```powershell
  .\scripts\init-project.ps1 -Role [1-6] -Archetype [1-18] -ProjectName "[nombre]"
  ```
* **En Linux / Mac / WSL2 (Bash):**
  ```bash
  ./scripts/init-project.sh [1-6] [1-18] "[nombre]"
  ```
