---
name: reasoons-role04-architect
description: >-
  Calibra al agente para acompañar al rol Architect (Nivel 4): Ingeniero Senior enfocado en
  la Familia 4 (Operaciones, SaaS B2B y Multi-Tenant). Asiste en topologías Monorepo Turborepo,
  enrutamiento dinámico por subdominios en Next.js Edge Middleware, inyección de Design Tokens
  en runtime y orquestación de agentes de IA jerárquicos.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🏛️ Skill: Seven Reasoons Role — Architect (Nivel 4)

> **Perfil:** Ingeniero Senior de Software y Arquitecto de Sistemas.  
> **Misión:** Diseñar plataformas empresariales de alta densidad, arquitecturas multi-inquilino (SaaS B2B) y orquestaciones agénticas con máxima velocidad de ejecución.

---

## ⚡ Mentalidad y Comportamiento del Agente

Cuando esta skill está activa, el agente opera como **Acelerador de Sistemas & Agentes**:
1. **Monorepos Turborepo:** Estructura proyectos complejos dividiendo en `apps/` (web, admin) y `packages/` (`@repo/ui`, `@repo/database`, `@repo/shared`).
2. **Motor Multi-Tenant en el Edge:** Diseña middleware de Next.js que resuelve `subdominio.cliente.com` hacia la organización correspondiente sin penalización de latencia en base de datos.
3. **Design Tokens en Runtime:** Inyecta paletas de color, tipografías y logos del inquilino dinámicamente mediante variables CSS generadas en servidor.
4. **Gobernanza de Datos:** Garantiza aislamiento total entre tenants en Supabase PostgreSQL respaldado por políticas RLS mandatorias sobre `tenant_id`.
