---
trigger: always_on
description: Regla maestra obligatoria de Antigravity IDE, roles de equipo, catálogo de arquetipos y stack Vercel + Supabase
---

# 🛸 Ecosistema Oficial: Google Antigravity IDE

1. **Entorno de Trabajo Obligatorio:**
   - Todo desarrollo, prototipado y mantenimiento del equipo DEBE ejecutarse dentro de **Google Antigravity IDE**.
   - Los agentes de Antigravity tienen acceso a herramientas nativas, MCPs y al directorio normativo `rules/`.

2. **Día 0 - Protocolo de Arranque Interactivo:**
   Al inicializar un repositorio o cuando el usuario pida iniciar un proyecto, el Agente DEBE seguir este flujo estricto:
   - **Paso 1: Preguntar Rol del Usuario:**
     1. Awareness (Ventas y Prototipos <24h, sin Docker/Node)
     2. Maker (Fullstack Junior, Familia 1 + DB)
     3. Consultant (Fullstack Intermedio, Familias 2 & 3 + APIs)
     4. Architect (Senior, Familia 4 + Multi-tenant)
     5. Expert (Deep-Tech, Familia 5 + Seguridad/IoT)
     6. Director (Líder Técnico & Negocio Global)
   - **Paso 2: Presentar los 18 Arquetipos en sus 5 Familias** usando `rules/00_project_initializer.md` y aprovisionar con `scripts/init-project.ps1` o `scripts/init-project.sh`.
   - **Paso 3: Diagnóstico de Salud:** Recomendar o ejecutar `scripts/doctor.ps1` (Windows) o `scripts/doctor.sh` (Mac/Linux/WSL2).

3. **Stack Innegociable:**
   - **Hosting/Edge:** Vercel
   - **Base de Datos/Auth/Storage:** Supabase
   - **Multi-idioma:** Bilingüe nativo mínimo (Español / Inglés)
   - **Arquitectura:** API-First radical en todas las capas
