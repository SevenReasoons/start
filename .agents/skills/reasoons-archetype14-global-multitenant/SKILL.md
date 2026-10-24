---
name: reasoons-archetype14-global-multitenant
description: >-
  Especializada en el Arquetipo 14 (Familia 4): Multi-Tenant Global y Multi-Región. Plataformas
  corporativas transnacionales con catálogos federados, transacciones multi-moneda con tasas
  de cambio dinámicas, cumplimiento GDPR/CCPA y replicación de lectura multi-región.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🌍 Skill: Arquetipo 14 — Multi-Tenant Global y Multi-Región

> **Familia 4:** Operaciones & Empresa  
> **Propósito:** Empresas multinacionales que requieren operar en múltiples países, monedas e idiomas con catálogos centralizados pero precios y normativas localizadas.

---

## ⚡ Especificación Técnica
- **Stack:** Turborepo + Vercel Multi-Region Edge + Supabase Global Read Replicas.
- **Soporte Multi-Moneda:** Conversión automática de tasas de cambio con caché horaria y persistencia del tipo de cambio exacto al momento de cada transacción.
- **Cumplimiento Regulatorio:** Almacenamiento y enrutamiento consciente de la región geográfica del usuario para cumplimiento de normativas de soberanía de datos (GDPR en Europa, LGPD en Brasil).
