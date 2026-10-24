---
name: reasoons-project-init
description: >-
  [DENTRO DEL WORKSPACE ACTUAL] Aprovisiona la arquitectura y carpetas físicas de
  cualquiera de los 18 Arquetipos y 6 Roles DENTRO DEL REPOSITORIO ACTIVO (sin crear
  carpetas externas ni clonar repositorios). Úsalo cuando ya estés dentro de la carpeta
  del proyecto y desees inicializar su estructura con init-project y doctor.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🚀 Skill: Seven Reasoons Project Initializer (Día 0)

> **Propósito:** Automatizar el arranque estandarizado de cualquier repositorio o subproyecto bajo el stack innegociable **Vercel + Supabase**, ejecutando el protocolo oficial del Día 0.

---

## ⚡ El Protocolo de Arranque en 3 Pasos

Cuando el usuario pida iniciar un nuevo proyecto o repositorio, esta skill ejecuta de forma determinista:

### Paso 1: Identificación del Rol de Equipo
Preguntar al desarrollador su nivel de carrera para calibrar el acompañamiento del Agente:
1. **Awareness [Nivel 1]:** Ventas y prototipos interactivos en <24h (Solo Frontend con Mock Data y estilo Seven Reasoons Pure).
2. **Maker [Nivel 2]:** Frontend profesional en Next.js con Atomic Design (`atoms/`, `molecules/`, `organisms/`, `templates/`) y backend sencillo de Familia 2 (CRUDs Supabase).
3. **Consultant [Nivel 3]:** Fullstack intermedio para Familias 2 & 3 (APIs RFC 7807, Stripe, LMS).
4. **Architect [Nivel 4]:** Ingeniero Senior (Monorepos Turborepo, subdominios multi-tenant, orquestación de agentes).
5. **Expert [Nivel 5]:** Deep-Tech (Ciberseguridad SHI, WebCrypto E2EE, Merkle Trees, IoT en tiempo real y 60 FPS).
6. **Director [Nivel 6]:** CTPO / Estrategia global (Ontología de negocio, economía de tokens y sistemas multi-región).

---

### Paso 2: Selección del Arquetipo (La Tabla Periódica del Software)
Presentar las 5 familias con sus 18 arquetipos canónicos:
- **🟢 Familia 1 (Captación):** [01] Prototipo Frontend, [02] Web Estática, [03] Landing Dinámica Leads.
- **🔵 Familia 2 (Comercio & Transaccional):** [04] E-Commerce B2C, [05] Marketplace Bilateral, [06] Booking & Citas, [07] Membresías & Paywall, [08] FinTech & Billeteras P2P.
- **🟣 Familia 3 (Comunidad & Contenido):** [09] Red Social, [10] LMS / Academia Digital.
- **🟠 Familia 4 (Operaciones & Empresa):** [11] Dashboards, [12] ERP / Facturación, [13] SaaS Multi-Tenant, [14] Multi-Tenant Global.
- **⚪ Familia 5 (Automatización & IA):** [15] Crons & Webhooks, [16] Copiloto Agéntico / Generative UI, [17] IoT Smart Factory, [18] API Headless BaaS.

---

### Paso 3: Aprovisionamiento Físico Inmediato
Ejecutar el script oficial correspondiente según el sistema operativo:

```powershell
# En Windows (PowerShell):
.\scripts\init-project.ps1 -Role [1-6] -Archetype [1-18] -ProjectName "[nombre-slug]"

# En Linux / Mac / WSL2 (Bash):
./scripts/init-project.sh [1-6] [1-18] "[nombre-slug]"
```

Y validar la salud del entorno con:
```powershell
.\scripts\doctor.ps1 -Role [1-6]
```
