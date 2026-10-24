---
name: reasoons-archetype15-automation-crons
description: >-
  Especializada en el Arquetipo 15 (Familia 5): Automatización, Webhooks y Crons Programados.
  Orquestación de tareas en segundo plano con Vercel Cron Jobs, Supabase Edge Functions,
  reintentos con retroceso exponencial, verificación criptográfica de firmas y webhooks idempotentes.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# ⚡ Skill: Arquetipo 15 — Automatización, Webhooks y Cron Jobs

> **Familia 5:** Automatización, IA & Telemetría  
> **Propósito:** Tareas programadas periódicas, sincronizaciones en segundo plano y procesamiento de webhooks externos.

---

## ⚡ Especificación Técnica
- **Stack:** Vercel Cron Jobs (`vercel.json`) + Supabase Edge Functions (Deno/TypeScript) + Upstash Redis (colas y rate limiting).
- **Vercel Cron Config:**
  ```json
  {
    "crons": [
      {
        "path": "/api/crons/sync-inventory",
        "schedule": "0 2 * * *"
      }
    ]
  }
  ```
- **Seguridad en Webhooks:** Verificación obligatoria de firmas criptográficas HMAC SHA-256 (`timingSafeEqual`) y almacenamiento de `idempotency_key` con expiración de 24 horas.
