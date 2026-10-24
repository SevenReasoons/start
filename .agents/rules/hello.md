---
trigger: always_on
description: Regla maestra obligatoria de Antigravity IDE, roles de equipo, catálogo de arquetipos y stack Vercel + Supabase
---

# 🛸 Ecosistema Oficial: Google Antigravity IDE

1. **Entorno de Trabajo Obligatorio:**
   - Todo desarrollo, prototipado y mantenimiento del equipo DEBE ejecutarse dentro de **Google Antigravity IDE**.
   - Los agentes de Antigravity tienen acceso a herramientas nativas, MCPs y al directorio normativo centralizado en `.agents/standards/`.

2. **Día 0 - Protocolo de Arranque Interactivo:**
   Al inicializar un repositorio o cuando el usuario pida iniciar un proyecto, el Agente DEBE seguir este flujo estricto:
   - **Paso 1: Preguntar Rol del Usuario:**
     1. Awareness (Ventas y Prototipos <24h, sin Docker/Node)
     2. Maker (Frontend Profesional Atómico en Next.js [Átomos, Moléculas, Organismos] + Backend sencillo Familia 2 [Supabase CRUD], preparado para handoff a Senior)
     3. Consultant (Fullstack Intermedio, Familias 2 & 3 + APIs)
     4. Architect (Senior, Familia 4 + Multi-tenant)
     5. Expert (Deep-Tech, Familia 5 + Seguridad/IoT)
     6. Director (Líder Técnico & Negocio Global)
   - **Paso 2: Presentar los 18 Arquetipos en sus 5 Familias** usando `.agents/standards/00_project_initializer.md` y aprovisionar con `scripts/init-project.ps1` o `scripts/init-project.sh`.
   - **Paso 3: Diagnóstico de Salud:** Recomendar o ejecutar `scripts/doctor.ps1` (Windows) o `scripts/doctor.sh` (Mac/Linux/WSL2).

3. **Stack Innegociable:**
   - **Hosting/Edge:** Vercel
   - **Base de Datos/Auth/Storage:** Supabase
   - **Multi-idioma:** Bilingüe nativo mínimo (Español / Inglés)
   - **Arquitectura:** API-First radical en todas las capas

4. **Estándar Visual Innegociable (EXCLUSIVO PARA PROTOTIPOS):**
   - **Alcance Estricto:** Este estilo aplica **ÚNICAMENTE a prototipos rápidos y demos de venta (<24h, Rol Awareness / Arquetipo 1)**. En proyectos de producción para clientes, SaaS multi-tenant o ERPs se utilizan los tokens propios del cliente o los presets neutros de `.agents/standards/08_ui_system_and_a11y.md`.
   - **Prioridad de Tema:** **Tema Claro Obligatorio por Defecto (Luxury Minimalist Light)**. Fondos blancos aireados (`#ffffff` / `bg-white`), superficies limpias (`bg-slate-50`), textos en alto contraste (`slate-900` / `slate-600`) y sombras sutiles.
   - **Degradado Oficial:** 4 colores: Rojo (`#ef4444`), Naranja (`#f97316`), Verde (`#22c55e`), Azul (`#3b82f6`).
     - CSS: `linear-gradient(to right, #ef4444, #f97316, #22c55e, #3b82f6)`
     - Tailwind: `bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)]`
   - **LA REGLA DE ORO:** El degradado **NUNCA** se utiliza como fondo/relleno de botones o componentes grandes. Su uso es **exclusivo para bordes de 2px** y acentos técnicos.
   - **Tipografía:** `Inter` (Google Fonts), pesos 300 (Light), 500 (Medium) y 700 (Bold). Títulos con `tracking-tighter` y labels/badges mayúsculas con `tracking-widest`.
   - **Botones (CTA):** Borde degradado de 2px con relleno interior sólido blanco (o slate-900 en casos de acento). Radio `rounded-2xl` (16px). Hover con `-translate-y-1` y `shadow-2xl`.
   - **Tarjetas:** Solo tarjetas "Highlight" o "Premium" llevan el borde degradado completo de 2px con relleno interior blanco. Las demás usan bordes neutros sutiles (`border-slate-100` / `border-slate-200`).
   - **Logo Oficial:** `https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png`. Centrado en footer con `opacity-50 grayscale hover:opacity-100 hover:grayscale-0`.
   - **Contacto Oficial:** WhatsApp `5649328703` (`https://wa.me/525649328703`). Promesa: *"Respondemos en menos de una hora"*.
   - **Tono y Sello:** Premium, minimalista, directo, espacios amplios. Firma: *"Made with love by Seven Reasoons"*.

5. **Directorio Normativo de Ingeniería (.agents/standards/):**
   Para especificaciones técnicas profundas, consultar bajo demanda los manuales modulares:
   - `00_project_initializer.md`: 18 Arquetipos y 6 Roles
   - `01_core_philosophy.md`: 5 Axiomas, API-First, i18n
   - `02_system_hygiene_and_env.md`: Higiene de entorno y Zod
   - `03_naming_and_git_flow.md`: Nomenclatura y Conventional Commits
   - `04_api_and_error_contract.md`: RFC 7807 e Idempotencia
   - `05_observability_and_logs.md`: Logs estructurados JSON
   - `06_devops_ci_cd_and_qa.md`: Vitest, Playwright y GitHub Actions
   - `07_frontend_and_mobile_first.md`: Mobile-First y 60 FPS
   - `08_ui_system_and_a11y.md`: Sistema de diseño para clientes
   - `09_backend_and_database.md`: Supabase PostgreSQL y RLS
   - `10_ai_first_and_generative_ui.md`: Vercel AI SDK
   - `11_multi_tenant_engine.md`: Enrutamiento y subdominios
   - `12_high_custody_security.md`: Seguridad SHI y WebCrypto E2EE
   - `13_visual_identity_manual.md`: Manual de Identidad Visual Seven Reasoons Pure
   - `14_prototype_ui_components_cheatsheet.md`: Componentes Light Theme de copia y pega

6. **Skills Oficiales de Ingeniería y Prototipado (.agents/skills/):**
   Todas las habilidades del ecosistema comparten el prefijo unificado `reasoons-*` y numeración ordenada para autocompletado y jerarquía en Antigravity IDE:
   - **Inicializadores:** `reasoons-star` (o `reasoons-start`), `reasoons-project-init`.
   - **Documentación:** `reasoons-documentar` (genera manual funcional entregable al cliente ruta por ruta).
   - **Interfaz de Usuario (UI):**
     - `reasoons-ui-pure`: Prototipos de venta interactivos (<24h, Tema Claro, Regla de Oro del degradado en bordes de 2px, CTA y WhatsApp).
     - `reasoons-ui-minimalist`: Erradicación de estilos genéricos, layouts aireados y directrices de Google Chrome Modern Web (para producción de clientes).
     - `reasoons-ui-atomic`: Arquitectura atómica en Next.js (Átomos, Moléculas, Organismos, Templates) con Pure UI para handoff a Seniors.
   - **Experiencia de Usuario (UX):**
     - `reasoons-ux-flows`: Flujos multi-paso, Wizards de onboarding, embudos y checkouts sin ruido visual (Zero-Clutter & Ghost Borders).
     - `reasoons-ux-mobile-first`: Experiencia mobile-first radical, 100dvh, touch targets mínimos de 44x44px y ergonomía a 60 FPS.
   - **6 Auditores Ordenados por Complejidad:**
     - `reasoons-audit01-clean-code`: Arquitectura limpia, antipatrones, nomenclatura y Git.
     - `reasoons-audit02-frontend`: UI Next.js, Atomic Design, 100dvh, accesibilidad WCAG.
     - `reasoons-audit03-backend`: Contratos RFC 7807, Server Actions, Idempotencia y Zod.
     - `reasoons-audit04-database`: Supabase PostgreSQL, RLS, índices B-Tree e integridad.
     - `reasoons-audit05-performance`: Core Web Vitals, 60 FPS, caching y límites de RAM.
     - `reasoons-audit06-security`: Ciberseguridad SHI, WebCrypto E2EE, Merkle Trees y PII.
   - **6 Roles de Carrera Acumulativos:**
     - `reasoons-role01-awareness` a `reasoons-role06-director`.
   - **18 Arquetipos Maestros (Tabla Periódica):**
     - `reasoons-archetype01-proto-front` a `reasoons-archetype18-headless-baas`.


