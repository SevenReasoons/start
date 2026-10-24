---
name: reasoons-archetype12-enterprise-erp
description: >-
  Especializada en el Arquetipo 12 (Familia 4): Software Empresarial (ERP / CRM / Facturación).
  Gestión de inventarios multi-almacén, cotizaciones, órdenes de compra, catálogo de clientes,
  emisión de facturas y pistas de auditoría inmutables para operaciones corporativas.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🏢 Skill: Arquetipo 12 — Software Empresarial (ERP / CRM / Operaciones)

> **Familia 4:** Operaciones & Empresa  
> **Propósito:** Automatización integral de procesos operativos, inventarios, compras y facturación corporativa.

---

## ⚡ Especificación Técnica
- **Stack:** Turborepo + Next.js App Router + Supabase + TanStack Form + Zod.
- **Módulos Canónicos:**
  - `src/app/[locale]/(erp)/inventario`
  - `src/app/[locale]/(erp)/ventas-crm`
  - `src/app/[locale]/(erp)/facturacion`
  - `src/app/[locale]/(erp)/auditoria`
- **Auditoría Transaccional:** Cada inserción, actualización o anulación de documento se registra en una tabla append-only `audit_logs` con `user_id`, `ip_address`, `timestamp` y snapshot JSON de los cambios.
