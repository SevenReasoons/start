---
name: reasoons-archetype11-dashboard-analytics
description: >-
  Especializada en el Arquetipo 11 (Familia 4): Dashboards Ejecutivos y Analítica de Negocio.
  Tarjetas de KPIs en tiempo real, gráficos interactivos ligeros, tablas de datos densas con
  paginación por cursor, exportación a CSV/Excel y control de acceso basado en roles (RBAC).
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 📊 Skill: Arquetipo 11 — Dashboards y Analítica Ejecutiva

> **Familia 4:** Operaciones & Empresa  
> **Propósito:** Paneles de administración, consolas de métricas y centros de control con visualizaciones en tiempo real.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + Recharts/Tremor ligero + Supabase RPC + TanStack Table.
- **Métricas:** Cálculos agregados ejecutados en PostgreSQL mediante funciones almacenadas (`SECURITY DEFINER` con RLS activo) para minimizar la transferencia de datos al navegador.
- **RBAC:** Roles jerárquicos (`superadmin`, `manager`, `viewer`) definidos en JWT o claims de Supabase Auth.
