---
name: reasoons-audit06-security
description: >-
  Audita la seguridad, criptografía y privacidad de aplicaciones contra los estándares
  de alta custodia (.agents/standards/12): Calificación SHI (0-100 pts), cifrado E2EE con
  WebCrypto nativo, registros inmutables con Árboles de Merkle, blindaje de secretos y
  cortafuegos de privacidad PII en prompts de IA.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🛡️ Skill: Seven Reasoons Security & High Custody Auditor

> **Propósito:** Auditar de forma implacable el nivel de ciberseguridad, criptografía, protección de datos y cumplimiento del Security Health Index (SHI) bajo [`.agents/standards/12_high_custody_security.md`](../standards/12_high_custody_security.md).

---

## 📋 Lista de Verificación de Auditoría (Security Gate)

### 1. 📊 Security Health Index (SHI: 0 a 100 Puntos)
El auditor calcula el puntaje SHI sumando las 4 categorías fundamentales:

- **Infraestructura y Secretos (25 pts):**
  - [ ] Cero secretos o llaves API quemadas en código fuente (`SUPABASE_SERVICE_ROLE_KEY`, `STRIPE_SECRET_KEY` ❌).
  - [ ] Validación estricta en tiempo de arranque con Zod (`env.ts`).
  - [ ] Headers HTTP de seguridad (`Content-Security-Policy`, `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`).

- **Criptografía y Privacidad (25 pts):**
  - [ ] En datos sensibles: Cifrado en reposo o E2EE con la WebCrypto API nativa (`AES-GCM` 256 bits, `PBKDF2` con mínimo 100,000 iteraciones).
  - [ ] Cero almacenamiento de llaves privadas en `localStorage` o cookies no cifradas.
  - [ ] Cortafuegos de IA: Verificación de que no se envíen números de tarjeta, correos, nombres o credenciales en prompts enviados a LLMs de terceros.

- **Identidad, RLS y Autorización (25 pts):**
  - [ ] Políticas RLS activas en el 100% de las tablas relacionales.
  - [ ] Cero endpoints públicos que permitan inserción o lectura indiscriminada sin validar sesión o token.
  - [ ] Protección contra timing attacks en comparación de hashes o firmas de webhooks (`crypto.timingSafeEqual`).

- **Auditoría e Integridad Forense (25 pts):**
  - [ ] Registro transaccional inmutable encadenado con Árboles de Merkle o hashes SHA-256 secuenciales.
  - [ ] Sanitización y enmascaramiento de datos personales en logs estructurados JSON (tarjetas ofuscadas `**** **** **** 1234`).

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] CYBERSECURITY & SHI SCORE REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Puntaje SHI Global: [0-100] / 100 Pts
 Estado: [🛡️ Óptimo (90-100) | ⚠️ Alerta (70-89) | 🔴 Crítico (<70)]

 Desglose por Categoría:
   - Infraestructura y Secretos: [X/25]
   - Criptografía y Privacidad:   [X/25]
   - Identidad y RLS:            [X/25]
   - Auditoría e Integridad:     [X/25]

 🔴 Vulnerabilidades Detectadas:
   - [Severidad ALTA/MEDIA/BAJA] [Archivo:Línea] -> Riesgo -> Mitigación Inmediata

 💡 Medidas Preventivas Obligatorias:
   - [Paso requerido para certificar el código]
========================================================
```
