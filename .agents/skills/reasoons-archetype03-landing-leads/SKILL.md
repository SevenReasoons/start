---
name: reasoons-archetype03-landing-leads
description: >-
  Especializada en el Arquetipo 03 (Familia 1): Landing Page Dinámica con Captura de Leads.
  Formularios de alta conversión con validación Zod en cliente y servidor, almacenamiento seguro
  en Supabase PostgreSQL con RLS y alertas automáticas por correo electrónico o webhook.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🎯 Skill: Arquetipo 03 — Landing Page Dinámica (Captura de Leads)

> **Familia 1:** Captación & Presencia  
> **Propósito:** Páginas de aterrizaje de alta conversión para adquisición de usuarios, preventas o listas de espera.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js App Router + React Hook Form + Zod + Supabase Client.
- **Esquema de Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email TEXT NOT NULL UNIQUE,
    full_name TEXT,
    preferred_locale VARCHAR(5) DEFAULT 'es',
    utm_source TEXT,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;
  CREATE POLICY "Permitir insercion anonima de leads" ON public.leads FOR INSERT WITH CHECK (true);
  ```
- **Server Action:** Validación estricta con Zod antes de la inserción y feedback visual optimista en el botón CTA.
