---
name: reasoons-archetype16-agentic-copilot
description: >-
  Especializada en el Arquetipo 16 (Familia 5): Copiloto Agéntico y Sistemas AI-First.
  Implementación con Vercel AI SDK, streaming nativo con React Server Components (RSC),
  Generative UI tipada con Zod, memoria contextual vectorial con pgvector y cortafuegos de privacidad.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🤖 Skill: Arquetipo 16 — Copiloto Agéntico y Generative UI

> **Familia 5:** Automatización, IA & Telemetría  
> **Propósito:** Asistentes de IA contextuales, copilotos conversacionales que renderizan interfaces vivas y flujos agénticos autónomos.

---

## ⚡ Especificación Técnica
- **Stack:** Vercel AI SDK (`ai/rsc`) + Supabase Vector (`pgvector`) + Modelos de frontera (Gemini Pro, Claude 3.5, GPT-4o).
- **Generative UI:** El modelo no devuelve únicamente texto plano; invoca herramientas con validación Zod que renderizan componentes React en streaming directamente en el chat.
- **RAG & Búsqueda Semántica:**
  ```sql
  CREATE EXTENSION IF NOT EXISTS vector;
  CREATE TABLE IF NOT EXISTS public.document_embeddings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL,
    embedding VECTOR(1536),
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  CREATE INDEX ON public.document_embeddings USING ivfflat (embedding vector_cosine_ops);
  ```
- **Cortafuegos de Privacidad:** Sanitización previa de prompts para eliminar PII (tarjetas, contraseñas) antes de la llamada a la API externa.
