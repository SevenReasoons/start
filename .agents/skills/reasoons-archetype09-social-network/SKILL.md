---
name: reasoons-archetype09-social-network
description: >-
  Especializada en el Arquetipo 09 (Familia 3): Red Social y Comunidad Interactiva. Feeds en
  vivo con Supabase Realtime, muros de publicaciones, sistema de reacciones y comentarios,
  perfiles sociales, subida segura de multimedia a Supabase Storage y paginación por cursor.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 👥 Skill: Arquetipo 09 — Red Social y Comunidad en Vivo

> **Familia 3:** Comunidad, Contenido & Aprendizaje  
> **Propósito:** Redes sociales temáticas, foros comunitarios, intranets interactivas y canales de discusión en tiempo real.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js App Router + Supabase Realtime + Supabase Storage + TanStack Virtual.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    author_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    media_url TEXT,
    likes_count INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;
  ALTER PUBLICATION supabase_realtime ADD TABLE public.posts;
  ```
- **Rendimiento:** Virtualización de la lista de publicaciones para garantizar 60 FPS y menos de 25MB de RAM con paginación basada en cursor temporal.
