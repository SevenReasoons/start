---
name: reasoons-audit05-performance
description: >-
  Audita el rendimiento extremo y consumo de recursos contra los estándares (.agents/standards/07):
  Límite de RAM (~25MB), virtualización en listas >30 elementos, erradicación de fugas de memoria
  en multimedia (URL.revokeObjectURL), singleton de audio y animaciones a 60 FPS aceleradas por GPU.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# ⚡ Skill: Seven Reasoons Performance & Hardware Diet Auditor

> **Propósito:** Auditar el consumo de memoria, procesamiento en GPU y fluidez a 60 FPS estables bajo [`.agents/standards/07_frontend_and_mobile_first.md`](../standards/07_frontend_and_mobile_first.md) para garantizar que la aplicación corra de forma instantánea incluso en teléfonos móviles de entrada ($50 USD / 1 GB RAM).

---

## 📋 Lista de Verificación de Auditoría (Performance Gate)

### 1. 🧠 Fugas de Memoria en Blobs y Multimedia
- [ ] **Revocación Inmediata de URLs:** Cada uso de `URL.createObjectURL(blob)` debe tener su contraparte destructiva `URL.revokeObjectURL(url)` tan pronto como el archivo termine de procesarse o enviarse.
- [ ] **Singleton de Audio:** Prohibido instanciar elementos `new Audio()` en bucles o componentes locales. Debe centralizarse en un único reproductor singleton (`audioPlayerSingleton.ts`).

### 2. 📜 Virtualización de DOM
- [ ] Todo feed, historial, chat o tabla que pueda superar los **30 elementos** debe implementar virtualización (ej. `@tanstack/react-virtual`) o la propiedad CSS nativa `content-visibility: auto` con `contain-intrinsic-size` para no colapsar el árbol DOM.
- [ ] En scrolls infinitos, la paginación hacia el pasado debe utilizar cursores temporales con `requestAnimationFrame` para mantener inmóvil la posición del scroll.

### 3. 🎮 Dieta de GPU y 60 FPS
- [ ] **Propiedades Compositoras:** Toda transición o animación en CSS o Framer Motion debe limitarse a las propiedades `transform` y `opacity` (procesadas en la GPU sin disparar re-flujos/reflows del DOM).
- [ ] Prohibido animar propiedades pesadas como `width`, `height`, `top`, `margin`, `padding` o `filter`.
- [ ] Evitar el anidamiento de múltiples capas con `backdrop-filter: blur(24px)` en layouts móviles, prefiriendo fondos sólidos con opacidad alta (`bg-white/95`).

### 4. 📦 Tamaño de Paquete e Hidratación
- [ ] Cero librerías pesadas para operaciones triviales (ej. importar `moment.js` o `lodash` completo en lugar de funciones nativas de JavaScript o `Intl`).
- [ ] Uso de importaciones dinámicas (`next/dynamic` con `ssr: false`) en componentes pesados como visores de PDF, editores Rich Text o gráficos interactivos.

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] PERFORMANCE & 60 FPS REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Calificación: [0-100] / 100

 🟢 Optimizaciones Verificadas:
   - [Punto aprobado]

 🔴 Cuellos de Botella y Riesgos de Memoria:
   - [Archivo:Línea] -> Problema detectado -> Solución requerida

 💡 Ganancia Estimada de FPS / Memoria:
   - [Estimación de mejora]
========================================================
```
