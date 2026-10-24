---
name: reasoons-archetype13-saas-multitenant
description: >-
  Especializada en el Arquetipo 13 (Familia 4): SaaS B2B Multi-Tenant con Subdominios.
  Aislamiento estricto de datos por tenant_id con RLS, enrutamiento dinámico en el Edge
  Middleware de Next.js, personalización de marca blanca (Design Tokens) y suscripciones por empresa.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🌐 Skill: Arquetipo 13 — SaaS B2B Multi-Tenant (Marca Blanca)

> **Familia 4:** Operaciones & Empresa  
> **Propósito:** Plataformas de software como servicio multi-empresa con aislamiento de datos y subdominios personalizados.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js Edge Middleware + Supabase Multi-Tenancy RLS + Tailwind CSS Variables.
- **Enrutamiento en el Edge:**
  ```typescript
  // middleware.ts
  const hostname = req.headers.get("host")!;
  const subdomain = hostname.split(".")[0];
  return NextResponse.rewrite(new URL(`/${subdomain}${req.nextUrl.pathname}`, req.url));
  ```
- **Aislamiento en PostgreSQL:**
  ```sql
  CREATE POLICY "Aislamiento por tenant" ON public.organization_data
  FOR ALL USING (tenant_id = current_setting('app.current_tenant_id', true)::uuid);
  ```
- **Design Tokens Dinámicos:** Inyección de CSS variables personalizadas por inquilino (`--brand-primary`, `--brand-logo`) desde el servidor.
