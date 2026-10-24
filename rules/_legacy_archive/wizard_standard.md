---
trigger: always_on
---

# Estándar de Diseño de Wizards y Flujos Multi-Paso (Seven Reasoons & Agoratori)

Este documento define la regla obligatoria de diseño, interacción y UX/UI para todos los **Wizards**, **Onboardings**, **Formularios Multi-Paso**, **Checkouts** y **Modales de Verificación** del ecosistema.

---

## 1. Filosofía Central: *Zero-Clutter & Ghost Borders*
* **Inspiración:** Apple HIG, Stripe, Linear y Reasoons Pure.
* **Prohibido sobrecargar:** Nunca agregar elementos decorativos redundantes que compitan con la acción del usuario (chevrons excesivos, etiquetas obvias, fondos pesados).
* **Bordes tenues (*Ghost Borders*):** Todo contenedor de input debe utilizar bordes delicados, de bajo contraste y líneas tenues (`border-slate-200/60` a `border-slate-300/70`).

---

## 2. Anatomía del Contenedor de Wizard
```tsx
<div className="w-full max-w-md mx-auto bg-white rounded-3xl p-6 sm:p-8 shadow-xl border border-slate-100/80 space-y-5">
  {/* Cabecera institucional opcional (Logo Reasoons o Agoratori) */}
  {/* WizardHeader */}
  {/* WizardStep (Contenido activo) */}
  {/* WizardFooter (Acciones) */}
</div>
```

---

## 3. Jerarquía Tipográfica de la Cabecera
* **Título:** `text-2xl sm:text-3xl font-bold text-slate-900 tracking-tight mb-1 text-center`
* **Subtítulo:** `text-xs sm:text-sm font-normal text-slate-500 text-center`
* **Texto de ayuda o avisos:** `text-[11px] font-medium text-slate-400`

---

## 4. Ranuras de Código y NIP (Estilo PIN Pad)
1. **Sin etiquetas numéricas inferiores:** Prohibido poner números `1, 2, 3... 7` debajo de cada ranura.
2. **Sin rellenos falsos:** Las ranuras vacías deben ser limpias (`bg-slate-50/50 border-slate-200/60`), sin puntos grises simulados.
3. **Casilla activa (Foco):** Trazo suave y halo difuminado tenue: `border-slate-400/80 bg-white ring-4 ring-slate-900/5 shadow-xs`.
4. **Casilla llena (Oculta):** Contorno blanco con borde delicado (`border-slate-300/70 bg-white`) y punto negro sólido centrado (`w-2.5 h-2.5 rounded-full bg-slate-900`). **Prohibido pintar toda la casilla de negro**.
5. **Toggle de visibilidad:** Usar botón tipo *pill* minimalista con ícono de ojo (`Ver NIP` / `Ocultar NIP`). **Prohibido usar checkboxes HTML nativos toscos**.
6. **Contador:** Discreto (`X de Y`) y con ícono verde esmeralda al completarse (`✓ Listo`).

---

## 5. Selectores de Fecha y Hora (Apple-Style Cylinder Wheel)
1. **Sin caja exterior:** El contenedor del selector debe ser transparente y sin bordes exteriores envolventes.
2. **Dos líneas horizontales continuas:** La selección se delimita exclusivamente por dos líneas horizontales delgadas (`border-y border-slate-200/90` o `h-[1px] bg-slate-200`) que atraviesan las columnas de lado a lado.
3. **Columnas unificadas:** No encapsular el día, mes y año en 3 cajas separadas ni añadir barras divisorias verticales.
4. **Sin chevrons ni etiquetas:** Prohibido añadir flechas arriba/abajo (`ChevronUp`/`ChevronDown`) ni etiquetas superiores ("DÍA", "MES", "AÑO"). El scroll táctil/mouse y click directo es la interacción natural.
5. **Fila seleccionada:** Tipografía nítida en primer plano (`font-medium text-slate-900 text-lg sm:text-xl`).
6. **Filas adyacentes:** Muted en tono gris suave (`text-slate-400 opacity-60`).
7. **Confirmación inferior:** Línea de texto limpia y minimalista, **sin fondos de colores, sin bordes ni cajas tipo tarjeta**.

---

## 6. Jerarquía de Botones y Navegación
* **Acción Primaria (Continuar / Enviar):**
  `Button variant="seven-reasoons"` con `w-full py-3.5 rounded-2xl font-semibold shadow-md transition-all`.
* **Acción Secundaria (Volver / Cancelar):**
  Texto enlace minimalista `text-xs text-slate-400 hover:text-slate-700 font-medium inline-flex items-center gap-1 transition-colors cursor-pointer`.

---

## 7. Transiciones entre Pasos
Usar Framer Motion con transiciones fluidas de eje horizontal:
```tsx
<motion.div
  key={stepId}
  initial={{ opacity: 0, x: 20 }}
  animate={{ opacity: 1, x: 0 }}
  exit={{ opacity: 0, x: -20 }}
  transition={{ duration: 0.25, ease: "easeOut" }}
>
  {/* Contenido del paso */}
</motion.div>
```
