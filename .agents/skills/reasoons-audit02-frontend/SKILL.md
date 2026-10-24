---
name: reasoons-audit02-frontend
description: >-
  Audita código frontend en Next.js y React contra los estándares oficiales Seven Reasoons
  (.agents/standards/07 y 08): Mobile-First (100dvh), touch targets de 44x44px, arquitectura
  atómica (atoms, molecules, organisms, templates), accesibilidad WCAG 2.1 AA, yPure UI
  desacoplada para handoff a Senior.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🔍 Skill: Seven Reasoons Frontend & UI Auditor

> **Propósito:** Auditar exhaustivamente componentes y páginas en Next.js / React para certificar el cumplimiento estricto de [`.agents/standards/07_frontend_and_mobile_first.md`](../standards/07_frontend_and_mobile_first.md) y [`.agents/standards/08_ui_system_and_a11y.md`](../standards/08_ui_system_and_a11y.md).

---

## 📋 Lista de Verificación de Auditoría (Frontend Gate)

Al ejecutar esta skill sobre cualquier archivo o directorio de interfaz, el agente debe verificar y emitir un reporte con los siguientes 6 puntos:

### 1. 📱 Mobile-First Radical & Unidades de Pantalla
- [ ] **Prohibición de `h-screen`:** Detectar si se utiliza `h-screen`. **Debe reemplazarse obligatoriamente por `h-[100dvh]`** para evitar que las barras móviles de Safari y Chrome tapen el contenido.
- [ ] **Jerarquía de Clases:** Las clases base de CSS/Tailwind deben ser móviles (ej. `w-full text-base`), dejando `md:`, `lg:`, `xl:` exclusivamente como mejora progresiva para pantallas grandes.
- [ ] **Áreas Seguras:** Los contenedores principales deben contemplar safe areas (`pt-safe`, `pb-safe`) ante barras de navegación y notches móviles.

### 2. 👆 Touch Targets de 44x44px Mínimo
- [ ] Todo botón, icono clickeable, toggle o enlace debe tener un área táctil mínima de **44x44 píxeles** (`min-h-[44px] min-w-[44px]` o padding envolvente equivalente).
- [ ] Verificar espaciado suficiente entre botones contiguos para evitar pulsaciones erróneas (*Fat-finger syndrome*).

### 3. 🧱 Arquitectura Atómica (Atomic Design)
- [ ] **Ubicación Canónica:** Comprobar que los componentes residen en su nivel correspondiente:
  - `atoms/`: Elementos indivisibles (`Button`, `Badge`, `Input`, `Spinner`).
  - `molecules/`: Unidades funcionales (`SearchBar`, `FormField`, `StatCard`).
  - `organisms/`: Bloques complejos (`Navbar`, `Sidebar`, `ProductGrid`, `DataTable`).
  - `templates/`: Layouts estructurales con slots (`StoreTemplate`, `DashboardTemplate`).
  - `app/`: Páginas Next.js que únicamente instancian templates y organismos sin maquetación inline.
- [ ] **Pure UI:** Átomos y moléculas deben recibir datos y callbacks mediante `props` estrictamente tipadas con TypeScript (`interface Props`). Prohibido acoplar llamadas duras a APIs o Supabase dentro de componentes de presentación.

### 4. ♿ Accesibilidad (WCAG 2.1 AA)
- [ ] **Contraste de Color:** Mínimo 4.5:1 en textos estándar y 3:1 en textos grandes (`text-slate-900` sobre fondos blancos / `text-slate-600` para secundarios).
- [ ] **Navegación por Teclado:** Elementos interactivos deben exhibir anillos de foco visibles (`focus:ring-2 focus:ring-offset-2`).
- [ ] **Etiquetas Semánticas y ARIA:** Botones sin texto visible (ej. solo iconos) deben incluir `aria-label`. Imágenes deben contar con `alt` descriptivo.

### 5. 🌐 Internacionalización (i18n)
- [ ] **Zero Hardcoded Text:** Cero cadenas de texto quemadas en componentes (`<h1>Bienvenido</h1>` ❌). Todo texto debe resolverse mediante diccionarios tipados (`{t('common.welcome')}` ✅).
- [ ] Formateo de monedas y fechas mediante la API nativa `Intl` (`new Intl.NumberFormat()`, `new Intl.DateTimeFormat()`).

### 6. 🎨 Desacoplamiento de Marca (Prototipos vs. Producción)
- [ ] Si es un **prototipo rápido (<24h)**: Verificar cumplimiento del Manual Seven Reasoons Pure (Tema Claro, degradado de 4 colores exclusivo para bordes de 2px, interior blanco sólido, botón CTA 16px, WhatsApp directo).
- [ ] Si es un **proyecto de cliente en producción**: Verificar que **NO** se utilice el degradado de Seven Reasoons y que se respeten los Design Tokens propios del cliente o presets neutros de `08_ui_system_and_a11y.md`.

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] FRONTEND & UI QUALITY REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Calificación: [0-100] / 100

 🟢 Cumplimientos:
   - [Item aprobado]

 🔴 No Conformidades Críticas:
   - [Archivo:Línea] -> Violación detectada -> Solución requerida

 💡 Recomendaciones de Refactorización:
   - [Sugerencia de optimización]
========================================================
```
