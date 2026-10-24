---
name: reasoons-archetype10-edtech-lms
description: >-
  Especializada en el Arquetipo 10 (Familia 3): Educación, Cursos y Academias Digitales (LMS / EdTech).
  Estructura de módulos y lecciones, reproductor de video protegido HLS, tracking de progreso
  por usuario, cuestionarios y emisión automatizada de certificados en PDF.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🎓 Skill: Arquetipo 10 — Educación Digital, Cursos y LMS

> **Familia 3:** Comunidad, Contenido & Aprendizaje  
> **Propósito:** Academias en línea, plataformas EdTech, capacitación corporativa y programas de certificación.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + HLS Video Player + Supabase PostgreSQL + React-PDF.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.courses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title JSONB NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    is_published BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  CREATE TABLE IF NOT EXISTS public.lessons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID REFERENCES public.courses(id) ON DELETE CASCADE,
    title JSONB NOT NULL,
    video_url TEXT NOT NULL,
    duration_seconds INT DEFAULT 0,
    order_index INT NOT NULL
  );
  CREATE TABLE IF NOT EXISTS public.user_progress (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    lesson_id UUID REFERENCES public.lessons(id) ON DELETE CASCADE,
    completed BOOLEAN DEFAULT false,
    last_watched_seconds INT DEFAULT 0,
    PRIMARY KEY (user_id, lesson_id)
  );
  ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;
  ```
- **Persistencia de Video:** Guardado del segundo exacto de reproducción con debounce de 5 segundos hacia Supabase para reanudar lecciones sin latencia.
