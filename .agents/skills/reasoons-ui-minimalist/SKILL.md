---
name: reasoons-ui-minimalist
description: >-
  [PRODUCCIÓN & CLIENTES FINALES] Elimina estilos genéricos en interfaces profesionales de
  clientes usando Luxury Minimalist Light, tokens propios y directrices de Google Chrome
  Modern Web. NO inyecta el degradado ni branding de Seven Reasoons Pure (usa standards/08).
license: Apache-2.0
metadata:
  author: Seven Reasoons & Antigravity
  version: 1.0.0
---

# 💎 Skill: Elegant & Minimalist Modern Web Architecture (`reasoons-ui-minimalist`)

> **Misión Suprema:** Erradicar de raíz los "estilos genéricos", las interfaces amateur y el código inflado generado por agentes de IA. Toda pantalla producida debe sentirse como una pieza de software de **$50,000 USD (estilo Stripe / Linear / Apple / Vercel)**.

---

## 🚫 1. Lista Negra Innegociable: Lo Que NUNCA se Debe Programar

Los siguientes antipatrones quedan terminantemente prohibidos en cualquier proyecto:

| Antipatrón Genérico | Por Qué Está Prohibido | Reemplazo Moderno Obligatorio |
| :--- | :--- | :--- |
| **Colores Primarios Puros** (ej. `#0000ff`, `#ff0000`, `#00ff00`) | Parecen de plantilla escolar de los años 90. | Paletas curadas HSL / Tailwind (ej. `slate-900`, `blue-600`, `emerald-500`). |
| **Bordes Duros Grises** (`1px solid #cccccc` o `#999`) | Ensucian la vista y aumentan la carga cognitiva. | Bordes ultra-sutiles (`border-slate-100` / `border-slate-200/70` o `border-black/5`). |
| **Botones Cuadrados sin Micro-Interacción** | Se sienten planos, estáticos y sin vida. | `rounded-2xl` (14-16px), micro-elevación hover (`-translate-y-0.5`) y sombra suave. |
| **Fuentes de Sistema por Defecto** (`Arial`, `Times`, `sans-serif` genérico) | Falta de personalidad y jerarquía tipográfica. | Google Fonts curadas: `Inter`, `Plus Jakarta Sans`, `Outfit` con tracking óptico. |
| **Textos Huérfanos o Títulos Rotos** | Arruinan la estética editorial en móvil y desktop. | `text-wrap: balance;` en títulos y `text-wrap: pretty;` en párrafos. |
| **Fondos Grises deprimidos o "HTML clásico"** | Falta de aire y luminosidad. | Blanco puro (`#ffffff`) con transiciones radiales tenues a `slate-50` (`#f8fafc`). |
| **Scrollbars Feos de Sistema Operativo** | Rompen la estética en Windows/Linux. | `scrollbar-width: thin; scrollbar-color: #cbd5e1 transparent;`. |

---

## 📐 2. El Sistema de Diseño "Luxury Minimalist Light"

### A. Anatomía del Espacio Blanco (Negative Space)
* **Regla del 60-30-10:**
  - **60% Espacio Dominante:** Superficies limpias, blancas y luminosas (`#ffffff` y `#f8fafc`).
  - **30% Estructura y Contraste:** Textos en alto contraste (`#0f172a` / `text-slate-900`) y bordes neutros (`#e2e8f0`).
  - **10% Acento Técnico:** Indicadores en vivo (verde esmeralda `#16a34a`), enlaces y bordes degradados de 2px.
* **Paddings Generosos:** Si dudas entre `p-4` y `p-6`, elige `p-6` o `p-8`. Deja que el contenido respire.

### B. Tipografía Editorial de Clase Mundial
```css
/* Escala Tipográfica de Máxima Elegancia */
h1, h2, h3 {
  font-family: 'Inter', -apple-system, sans-serif;
  letter-spacing: -0.04em; /* tracking-tight / tracking-tighter */
  text-wrap: balance;
  color: #0f172a;
}

.label-caps {
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em; /* tracking-widest */
  text-transform: uppercase;
  color: #64748b;
}
```

### C. Sistema de Sombras Tenues ("Diffuse Glows")
Nunca uses sombras negras duras (`box-shadow: 0 4px 6px rgba(0,0,0,0.4)`). Emplea sombras de gran radio y bajísima opacidad:
```css
/* Sombra de Tarjeta Elevada Premium */
box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.05), 0 0 1px 1px rgba(0, 0, 0, 0.02);

/* Sombra Hover Interactivo */
box-shadow: 0 25px 50px -12px rgba(59, 130, 246, 0.2);
```

---

## ⚡ 3. Integración con Google Chrome Modern Web Guidance

Aprovecha las capacidades nativas de la web moderna para evitar JavaScript innecesario:

1. **Campos de Formulario que Crecen Dinámicamente:**
   ```css
   textarea, input.dynamic {
     field-sizing: content; /* Evita librerías JS pesadas de auto-resize */
   }
   ```

2. **Validación Solo Tras la Interacción del Usuario:**
   ```css
   /* Muestra error visual solo después de que el usuario interactuó y salió del campo */
   input:user-invalid {
     border-color: #ef4444;
     outline-color: #ef4444;
   }
   ```

3. **Micro-Transiciones Fluidas con Curva Spring:**
   ```css
   .smooth-transition {
     transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
   }
   ```

4. **Transiciones de Vista Nativas (View Transitions API):**
   ```javascript
   function navigateWithTransition(updateDomFn) {
     if (document.startViewTransition) {
       document.startViewTransition(updateDomFn);
     } else {
       updateDomFn();
     }
   }
   ```

---

## 🛠️ 4. Checklist Rápido de Calidad para el Agente

Antes de entregar cualquier código HTML/CSS/JS, el agente debe verificar mentalmente:
- [ ] ¿El fondo es blanco aireado (`#ffffff` / `#f8fafc`) y no un gris monótono?
- [ ] ¿Los botones tienen radio moderno (`rounded-2xl` / 14-16px) y relleno sólido?
- [ ] ¿Las tipografías usan pesos cuidados (Light 300, Medium 500, Bold 700) con tracking cerrado en títulos?
- [ ] ¿Los bordes son de 1px ultra-sutiles (`border-slate-100`) o de 2px con degradado en elementos estrella?
- [ ] ¿Las métricas numéricas están acompañadas de etiquetas claras y badges de contexto?
- [ ] ¿Se respeta la Regla de Oro (degradado NUNCA de fondo, solo en bordes)?
- [ ] ¿La interfaz se siente rápida, viva y digna de un producto de alta gama?
