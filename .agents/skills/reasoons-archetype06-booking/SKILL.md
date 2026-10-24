---
name: reasoons-archetype06-booking
description: >-
  Especializada en el Arquetipo 06 (Familia 2): Motor de Citas, Agendamiento y Reservas.
  Control estricto de concurrencia temporal sin doble reserva (zero double-booking) mediante
  extensiones PostgreSQL (btree_gist y rangos TSTZRANGE), zonas horarias UTC y recordatorios.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 📅 Skill: Arquetipo 06 — Citas, Agendamiento y Reservas (Booking Engine)

> **Familia 2:** Comercio, Transacciones & Monetización  
> **Propósito:** Agendamiento de servicios profesionales, consultas médicas, salones o instalaciones sin riesgo de solapamiento de horarios.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + PostgreSQL GiST + Supabase.
- **Base de Datos Blindada contra Doble Reserva:**
  ```sql
  CREATE EXTENSION IF NOT EXISTS btree_gist;
  CREATE TABLE IF NOT EXISTS public.appointments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL,
    customer_email TEXT NOT NULL,
    slot_range TSTZRANGE NOT NULL,
    status TEXT DEFAULT 'confirmed',
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
    EXCLUDE USING gist (provider_id WITH =, slot_range WITH &&)
  );
  ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
  ```
- **Manejo de Zona Horaria:** Todos los rangos se persisten en UTC en la base de datos y se renderizan en la zona horaria local del navegador mediante `Intl.DateTimeFormat`.
