---
name: reasoons-archetype04-ecommerce
description: >-
  Especializada en el Arquetipo 04 (Familia 2): E-Commerce B2C Transaccional. Tienda directa
  en Next.js con catálogo de productos, carrito persistente en cliente (Zustand), pasarela
  de pago Stripe Checkout, tablas de órdenes en Supabase con RLS y Atomic Design.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🛍️ Skill: Arquetipo 04 — E-Commerce B2C Transaccional

> **Familia 2:** Comercio, Transacciones & Monetización  
> **Propósito:** Tiendas en línea B2C directas con carrito, inventario y checkout seguro con Stripe.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js App Router + Atomic Design (`atoms/`, `molecules/`, `organisms/`, `templates/`) + Stripe SDK + Supabase.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    image_url TEXT,
    stock INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    status TEXT DEFAULT 'pending',
    shipping_address TEXT,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
  CREATE POLICY "Lectura publica de productos" ON public.products FOR SELECT USING (true);
  CREATE POLICY "Usuarios gestionan sus ordenes" ON public.orders FOR ALL USING (auth.uid() = user_id);
  ```
- **Handoff Maker-Senior:** Componentes de producto (`ProductCard`, `CartDrawer`) desacoplados con props TypeScript estrictas.
