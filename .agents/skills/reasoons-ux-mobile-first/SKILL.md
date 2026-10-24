---
name: reasoons-ux-mobile-first
description: >-
  Especializada en Experiencia de Usuario (UX) Móvil y Ergonomía Táctil a 60 FPS.
  Implementa viewport 100dvh para eliminar saltos de barra en iOS/Android, touch targets
  mínimos de 44x44px, navegación en la zona natural del pulgar (Thumb Zone), paneles
  inferiores deslizables (Bottom Sheets) y feedback táctil inmediato.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 📱 Skill: Seven Reasoons Mobile-First UX & Ergonomics (`reasoons-ux-mobile-first`)

> **Propósito:** Garantizar que toda interfaz del ecosistema esté optimizada primordialmente para smartphones y pantallas táctiles, cumpliendo las directrices de ergonomía táctil, cero brincos de viewport y respuesta fluida a 60 FPS.

---

## ⚡ Los 6 Principios Innegociables de UX Móvil

### 1. 📏 Viewport Dinámico: `100dvh` Obligatorio
- **Prohibido usar `100vh` en CSS:** Provoca el molesto "brinco" visual cuando la barra de navegación de Safari (iOS) o Chrome (Android) aparece o se oculta.
- **Solución Obligatoria:** Utilizar siempre `min-h-[100dvh]` o `h-[100dvh]` (Dynamic Viewport Height).

### 2. 👆 Touch Targets Mínimos: `44 x 44 px`
- Todo elemento con el que el usuario interactúe (botones, enlaces, checkboxes, toggles, íconos de cierre) DEBE tener un área de toque efectiva de al menos **44x44 píxeles**:
  ```tsx
  {/* Correcto: padding que expande el área de toque */}
  <button className="min-h-[44px] min-w-[44px] flex items-center justify-center p-2 rounded-xl">
    <CloseIcon className="w-5 h-5" />
  </button>
  ```

### 3. 👍 La Zona Natural del Pulgar (Thumb Zone)
- El 75% de los usuarios navega sosteniendo el teléfono con una sola mano.
- **Acciones Primarias y CTAs:** Deben colocarse en el tercio inferior de la pantalla (zona verde de alcance natural).
- **Acciones Destructivas o Raras:** En la parte superior para evitar toques accidentales.
- **Navegación Móvil:** Preferir Bottom Navigation Bar fija (`bottom-0 fixed`) sobre menús hamburguesa escondidos arriba.

### 4. 📂 Bottom Sheets en Móvil (No Modales Flotantes)
- En pantallas móviles (`< 640px`), los diálogos y menús de opciones deben abrirse desde abajo como **Bottom Sheets** deslizables, nunca como tarjetas flotantes en el centro que tapan la vista y quedan fuera del alcance del pulgar.

### 5. ⚡ Feedback Visual Inmediato (<50ms)
- Todo botón debe reaccionar al instante del toque:
  ```css
  /* Micro-presión táctil sin lag */
  active:scale-[0.98] transition-transform duration-75
  ```
- Al enviar formularios, cambiar inmediatamente el estado del botón a cargando (*spinner* sutil) para evitar dobles toques impacientes.

### 6. 🛑 Prevención de Saltos de Contenido (CLS = 0)
- Usar esqueletos de carga (*skeletons*) con las dimensiones exactas del contenido final.
- Declarar siempre `width` y `height` en imágenes (`next/image`) para que el navegador reserve el espacio antes de la descarga.
