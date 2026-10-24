---
name: reasoons-archetype18-headless-baas
description: >-
  Especializada en el Arquetipo 18 (Familia 5): API Headless y Backend-as-a-Service (BaaS).
  Backend puro para alimentar aplicaciones móviles (React Native, Flutter, Swift, Kotlin),
  dispositivos IoT o integraciones B2B con contratos de API OpenAPI / TypeRPC y autenticación JWT.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🔌 Skill: Arquetipo 18 — API Headless / Backend-as-a-Service (BaaS)

> **Familia 5:** Automatización, IA & Telemetría  
> **Propósito:** Backend desacoplado que expone endpoints seguros y de baja latencia para clientes móviles (iOS/Android), IoT o integraciones de terceros.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js Route Handlers / Supabase Edge Functions + Zod OpenAPI + JWT Auth.
- **Contrato Universal:**
  - Respuestas formateadas estrictamente bajo `{ success: boolean, data: T, meta: { ... } }` o RFC 7807 en errores.
  - Generación automática del SDK de cliente o tipos TypeScript mediante OpenAPI Spec / TypeRPC.
- **Autenticación Móvil:** Soporte para Refresh Tokens, rotación de sesiones y rate limiting por IP y por API Key.
