---
trigger: always_on
---

# 🎨 07. Sistema de Diseño, Presets Visuales y Accesibilidad (a11y)

> **Propósito:** Definir el sistema de diseño universal, los 3 presets visuales canónicos, el estándar de modales y asistentes multi-paso (Wizards), y los requisitos innegociables de accesibilidad WCAG 2.1 AA.

---

## 1. Los 3 Presets Visuales Canónicos (HoldCo / Multi-Tenant)

Para evitar la colisión de estilos entre marcas o secciones, la aplicación debe operar bajo uno de estos 3 temas oficiales declarados a nivel de contenedor o ruta:

### ⚪ Preset 1: Luxury Minimalist Light
* **Vibra:** Exclusivo, aireado, elegancia corporativa B2C (estilo Apple / Stripe).
* **Fondo:** Blanco puro (`bg-white`) con zonas de resalto en `bg-slate-50`.
* **Tipografía:** Pesos finos o medios (`font-normal`, `font-medium`), títulos con tracking cerrado (`tracking-tight text-slate-900`).
* **Bordes y Sombras:** Bordes sutiles `border-slate-200/70`, sombras difusas amplias `shadow-[0_8px_30px_rgb(0,0,0,0.04)]`.

### ⬛ Preset 2: Corporate Stealth Dark
* **Vibra:** Profesional B2B, alta densidad de datos, analítica ejecutiva (estilo Vercel / Linear).
* **Fondo:** Pizarra profundo (`bg-slate-950` y `bg-slate-900`).
* **Tipografía:** Alto contraste, textos en `text-slate-100` y metadata en `text-slate-400 text-xs`.
* **Bordes y Acentos:** Bordes nítidos `border-white/10`, acentos en índigo o esmeralda con fondos `bg-white/5`.

### ⚡ Preset 3: High-Tech Cyber Dashboard
* **Vibra:** Tiempo real, monitoreo industrial, IoT o trading (estilo Bloomberg / Datadog).
* **Fondo:** Negro absoluto (`bg-black` o `bg-zinc-950`).
* **Acentos:** Colores vibrantes (cian, violeta eléctrico), cifras numéricas en fuentes monoespaciadas (`font-mono`).
* **Brillo:** Efectos de resplandor sutiles (`shadow-blue-500/15`) y tarjetas translúcidas.

---

## 2. Estándar de Modales y Overlays ("Frosted Glass")

1. **Montaje Seguro con Portal:**
   - Todo modal flotante DEBE montarse mediante `createPortal(..., document.body)` para evitar quedar atrapado en contextos de apilamiento (*stacking contexts*) o filtros de desenfoque de componentes padre.
2. **Backdrop y Caja:**
   - Backdrop: `fixed inset-0 bg-slate-950/60 backdrop-blur-md z-[999]`.
   - Contenedor: `max-w-[480px] bg-white/95 dark:bg-slate-900/95 backdrop-blur-2xl border border-white/20 rounded-[28px] shadow-2xl overflow-hidden`.
3. **Botón de Cierre Accesible:**
   - Debe contar con botón `✕` con `aria-label="Cerrar ventana"`, soporte para tecla `Escape` y trampa de foco (*Focus Trap*).

---

## 3. Estándar para Wizards y Formularios Multi-Paso

Los flujos de verificación, onboarding o checkout deben reducir la fricción cognitiva al mínimo absoluto:

1. **Bordes Fantasma (*Ghost Borders*):**
   - Para resaltar tarjetas interactivas o pasos activos, utilizar la técnica del contenedor padre con padding perimetral de 2px (`p-[2px]`) con degradado o color de marca, envolviendo un contenedor hijo con fondo sólido.
2. **Cajas de PIN / OTP Numérico:**
   - Utilizar casillas independientes de 1 dígito con avance de foco automático al escribir y retroceso automático al borrar (`Backspace`), con tipo `inputMode="numeric"`.
3. **Selectores de Rueda Cilíndrica (Estilo iOS):**
   - Para seleccionar fechas, horarios o categorías en móvil, preferir listas con efecto de rueda de tambor cilíndrica vertical con amortiguación inercial (*momentum scrolling*).

---

## 4. Accesibilidad Universal Innegociable (WCAG 2.1 Nivel AA)

1. **Contraste de Color:**
   - La relación de contraste entre texto y fondo debe ser de al menos **4.5:1** para texto normal y **3:1** para texto grande (18px+ o 14px bold).
2. **Navegación 100% por Teclado:**
   - Todo elemento accionable debe mostrar un anillo de foco visible e inequívoco al navegar con la tecla `Tab`:
     ```css
     focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2
     ```
3. **Iconos y Botones sin Texto:**
   - Todo botón que contenga solo un icono debe incluir obligatoriamente el atributo `aria-label` descriptivo:
     ```tsx
     <button aria-label="Buscar en el catálogo" data-testid="search-btn">
       <SearchIcon aria-hidden="true" />
     </button>
     ```
4. **Jerarquía Semántica:**
   - Cada página o vista debe tener **exactamente un único encabezado `<h1>`**. Los subtítulos deben seguir el orden `<h2>`, `<h3>` sin saltarse niveles.
