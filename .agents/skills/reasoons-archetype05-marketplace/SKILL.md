---
name: reasoons-archetype05-marketplace
description: >-
  Especializada en el Arquetipo 05 (Familia 2): Marketplace Bilateral Multi-Vendedor. Plataforma
  con onboarding de vendedores mediante Stripe Connect (Custom/Express), división de comisiones
  de plataforma, catálogos federados por vendedor y transferencias automatizadas.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🛒 Skill: Arquetipo 05 — Marketplace Bilateral Multi-Vendedor

> **Familia 2:** Comercio, Transacciones & Monetización  
> **Propósito:** Plataformas bilaterales donde múltiples vendedores publican productos o servicios y la plataforma cobra una comisión porcentual o fija por transacción.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + Stripe Connect + Supabase PostgreSQL con RLS.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.vendors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    business_name TEXT NOT NULL,
    stripe_account_id TEXT UNIQUE,
    commission_rate NUMERIC(4,2) DEFAULT 0.10,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.vendors ENABLE ROW LEVEL SECURITY;
  ```
- **Flujo Transaccional:** Uso de Stripe Transfers / PaymentIntents con `application_fee_amount` y `transfer_data[destination]`.
