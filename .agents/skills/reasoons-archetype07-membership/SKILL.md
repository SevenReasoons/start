---
name: reasoons-archetype07-membership
description: >-
  Especializada en el Arquetipo 07 (Familia 2): Membresías, Suscripciones Recurrentes y Paywall.
  Gestión de planes escalonados con Stripe Billing / Customer Portal, control de acceso a
  contenido protegido en el Edge Middleware de Next.js y sincronización segura de webhooks.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🔒 Skill: Arquetipo 07 — Membresías y Paywall (Creator Economy)

> **Familia 2:** Comercio, Transacciones & Monetización  
> **Propósito:** Plataformas con contenido exclusivo, muros de pago (Paywalls) y suscripciones periódicas mensuales/anuales.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js App Router + Stripe Billing + Next.js Middleware + Supabase RLS.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    stripe_customer_id TEXT UNIQUE,
    stripe_subscription_id TEXT UNIQUE,
    status TEXT NOT NULL,
    price_id TEXT NOT NULL,
    current_period_end TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
  CREATE POLICY "Usuarios leen su propia suscripcion" ON public.subscriptions FOR SELECT USING (auth.uid() = user_id);
  ```
- **Control de Acceso en Edge:** El middleware de Next.js valida el token de sesión y la cookie de suscripción activa en milisegundos antes de permitir el acceso a rutas protegidas (`/premium/*`).
