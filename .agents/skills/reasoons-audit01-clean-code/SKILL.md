---
name: reasoons-audit01-clean-code
description: >-
  Audita la arquitectura limpia, antipatrones y código espagueti contra los estándares oficiales
  (.agents/standards/01 y 03): Erradicación de código espagueti, cero hardcoding de URLs/secretos,
  convenciones de nomenclatura (kebab-case, camelCase), principios DRY y SOLID, y Conventional Commits.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🧹 Skill: Seven Reasoons Clean Code & Architecture Auditor

> **Propósito:** Detectar y erradicar antipatrones, duplicación de código, malas prácticas de nomenclatura y acoplamientos espagueti bajo [`.agents/standards/01_core_philosophy.md`](../standards/01_core_philosophy.md) y [`.agents/standards/03_naming_and_git_flow.md`](../standards/03_naming_and_git_flow.md).

---

## 📋 Lista de Verificación de Auditoría (Clean Code Gate)

### 1. 🍝 Erradicación de Código Espagueti
- [ ] **Desacoplamiento Estricto:** NUNCA colocar llamadas directas a base de datos o lógica de negocio pesada dentro de componentes visuales tontos. Los componentes de UI solo consumen props o llaman handlers limpios.
- [ ] **Funciones Puras:** Preferir funciones puras con efectos secundarios aislados. Las mutaciones deben encapsularse en Server Actions o capas de servicio (`src/services/`).

### 2. 🚫 Zero-Hardcoding
- [ ] Prohibido quemar URLs de API (`http://localhost:3000` o `https://api.miempresa.com` ❌). Todas deben resolverse mediante variables validadas por Zod en tiempo de compilación (`env.NEXT_PUBLIC_APP_URL` ✅).
- [ ] Prohibido quemar identificadores de planes, precios o configuraciones arbitrarias en medio del código fuente.

### 3. 🏷️ Convenciones de Nomenclatura Universales
- [ ] **Archivos y Carpetas:** Obligatoriamente en `kebab-case` (ej. `product-card.tsx`, `use-debounce.ts`, `route.ts`).
- [ ] **Componentes e Interfaces:** En `PascalCase` (ej. `ProductCard`, `interface ProductCardProps`).
- [ ] **Variables y Funciones:** En `camelCase` (ej. `calculateDiscountAmount`, `isLoadingProducts`).
- [ ] **Constantes y Enums:** En `UPPER_SNAKE_CASE` (ej. `MAX_RETRY_ATTEMPTS`, `DEFAULT_PAGE_SIZE`).

### 4. ♻️ Principio DRY (Don't Repeat Yourself)
- [ ] Si la misma lógica de cálculo, formateo o llamada a API se repite en dos o más lugares, debe refactorizarse de inmediato hacia una capa compartida (`src/lib/` o `@repo/shared`).
- [ ] Componentes duplicados con ligeras variaciones visuales deben unificarse mediante props polimórficas o variantes de diseño.

### 5. 🐙 Higiene de Control de Versiones
- [ ] Mensajes de commit formateados bajo **Conventional Commits** (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`).
- [ ] Ramas de Git con prefijos estándar (`feat/[slug]`, `fix/[slug]`, `refactor/[slug]`).

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] CLEAN CODE & ARCHITECTURE REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Calificación: [0-100] / 100

 🟢 Prácticas Limpias Verificadas:
   - [Punto aprobado]

 🔴 Antipatrones y Código Espagueti Detectados:
   - [Archivo:Línea] -> Antipatrón detectado -> Refactorización sugerida

 💡 Refactorización de Arquitectura:
   - [Sugerencia de modularidad]
========================================================
```
