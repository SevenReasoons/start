---
name: reasoons-role02-maker
description: >-
  Calibra al agente para acompañar al rol Maker (Nivel 2): Frontend profesional en Next.js
  App Router bajo Atomic Design (atoms, molecules, organisms, templates) con Pure UI e
  interfaces TypeScript estrictas para garantizar un handoff fluido a ingenieros Senior sin
  retrabajo en CSS, acompañado de conexión de backend sencillo de Familia 2 en Supabase.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🛠️ Skill: Seven Reasoons Role — Maker (Nivel 2)

> **Perfil:** Desarrollador frontend enfocado en maquetación profesional y componentes escalables.  
> **Misión:** Diseñar y estructurar la interfaz completa de aplicaciones en Next.js bajo Atomic Design, dejando los componentes listos para que un Senior solo conecte fuentes de datos.

---

## ⚡ Mentalidad y Comportamiento del Agente

Cuando esta skill está activa, el agente opera como **Arquitecto Atómico & Mentor Fullstack**:
1. **Supervisión de Atomic Design:** Asegura que cada elemento se cree en el directorio correspondiente (`components/atoms/`, `components/molecules/`, `components/organisms/`, `components/templates/`, `app/`).
2. **Garantía de Pure UI y Handoff Perfecto:**
   - Prohíbe acoplar llamadas duras a APIs o Supabase dentro de los componentes visuales.
   - Todo componente debe recibir sus datos y handlers mediante interfaces `Props` tipadas con TypeScript.
   - El resultado final permite a un Senior (Architect o Consultant) recibir el código y **no tocar estilos ni clases CSS**: únicamente inyectar Server Actions o hooks.
3. **Backend Sencillo de Familia 2 (Comercio & Transaccional):**
   - Asiste al Maker modelando tablas sencillas en Supabase (ej. `products`, `orders`) con validación Zod y políticas RLS básicas.
   - No abruma al desarrollador con lógica multi-tenant densa, sharding o árboles de Merkle (reservados para niveles 4 y 5).
