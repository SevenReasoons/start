---
name: reasoons-ux-flows
description: >-
  Especializada en el diseño de Experiencia de Usuario (UX) para Flujos Multi-Paso,
  Wizards de Onboarding, Embudos de Conversión, Checkouts y Modales de Verificación.
  Aplica la filosofía Zero-Clutter & Ghost Borders, PIN pads sin ruido visual, selectores
  cilíndricos continuos y reducción radical de fricción cognitiva.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🧭 Skill: Seven Reasoons UX Flows & Wizards (`reasoons-ux-flows`)

> **Propósito:** Diseñar y estructurar la experiencia de usuario (UX) en flujos complejos: **Onboardings**, **Wizards Multi-Paso**, **Checkouts Transaccionales**, **Formularios Guiados** y **Modales de Verificación**, erradicando la fricción cognitiva y la saturación visual.

---

## ⚡ Los 5 Mandamientos de UX en Flujos Multi-Paso

### 1. 👻 Filosofía Zero-Clutter & Ghost Borders
- **Inspiración:** Apple Human Interface Guidelines, Stripe Checkout y Linear.
- **Sin Elementos Inútiles:** Prohibido agregar íconos decorativos redundantes, chevrons innecesarios o cajas sobrecargadas que compitan con la atención del usuario.
- **Bordes Fantasma (*Ghost Borders*):** Todo contenedor de input debe utilizar bordes delicados y de bajo contraste (`border-slate-200/60` a `border-slate-300/70`).

### 2. 🔢 Ranuras de Código y NIP (PIN Pad UX)
1. **Sin etiquetas numéricas inferiores:** Prohibido poner números `1, 2, 3... 7` debajo de cada ranura.
2. **Sin rellenos falsos:** Las ranuras vacías deben ser limpias (`bg-slate-50/50 border-slate-200/60`), sin puntos grises simulados.
3. **Casilla activa (Foco):** Trazo suave y halo difuminado tenue: `border-slate-400/80 bg-white ring-4 ring-slate-900/5 shadow-xs`.
4. **Casilla llena (Oculta):** Contorno blanco con borde delicado (`border-slate-300/70 bg-white`) y punto negro sólido centrado (`w-2.5 h-2.5 rounded-full bg-slate-900`). **Prohibido pintar toda la casilla de negro**.
5. **Toggle de visibilidad:** Usar botón tipo *pill* minimalista con ícono de ojo (`Ver NIP` / `Ocultar NIP`). Prohibido usar checkboxes HTML nativos toscos.
6. **Contador discreto:** Discreto (`X de Y`) y con ícono verde esmeralda al completarse (`✓ Listo`).

### 3. 🗓️ Selectores de Fecha y Hora (Cilindro Continuo Estilo Apple)
1. **Sin caja exterior:** El contenedor del selector debe ser transparente y sin bordes exteriores envolventes.
2. **Dos líneas horizontales continuas:** La selección se delimita exclusivamente por dos líneas horizontales delgadas (`border-y border-slate-200/90`) que atraviesan las columnas de lado a lado.
3. **Columnas unificadas:** No encapsular día, mes y año en 3 cajas separadas ni añadir divisores verticales pesados.
4. **Sin chevrons ni etiquetas:** Prohibido añadir flechas arriba/abajo (`ChevronUp`/`ChevronDown`) ni etiquetas ("DÍA", "MES", "AÑO"). El scroll táctil/mouse y click directo es la interacción natural.
5. **Fila seleccionada:** Tipografía nítida en primer plano (`font-medium text-slate-900 text-lg sm:text-xl`).
6. **Filas adyacentes:** Atenuadas en tono gris suave (`text-slate-400 opacity-60`).

### 4. 🔀 Progresión y Memoria del Estado
- **Indicador de Progreso Discreto:** Barra delgada superior (2px a 4px) con transición CSS suave (`transition-all duration-300`).
- **Navegación Reversible:** El usuario siempre puede regresar al paso anterior sin perder los datos ya introducidos.
- **Validación Paso a Paso:** No permitir avanzar al siguiente paso si el actual no pasa la validación Zod correspondiente.

### 5. 🎯 Jerarquía de Botones y Acciones
- **Acción Primaria (Continuar / Enviar):** Botón principal ancho completo (`w-full`), altura táctil mínima de 44px (`py-3.5`), radio `rounded-2xl` y feedback de carga (*loading spinner* discreto).
- **Acción Secundaria (Atrás / Cancelar):** Texto sutil o botón fantasma neutro (`variant="ghost"`).

---

## 📐 Anatomía Canónica de un Wizard en Next.js

```tsx
<div className="w-full max-w-md mx-auto bg-white rounded-3xl p-6 sm:p-8 shadow-xl border border-slate-100/80 space-y-6">
  {/* WizardHeader: Indicador de paso y título */}
  <div className="text-center space-y-1">
    <span className="text-[11px] font-bold uppercase tracking-widest text-slate-400">Paso 2 de 4</span>
    <h2 className="text-2xl font-bold tracking-tight text-slate-900">Configura tu Perfil</h2>
  </div>

  {/* WizardStep: Contenido activo sin scroll innecesario */}
  <div className="space-y-4">
    {children}
  </div>

  {/* WizardFooter: Acciones de avance */}
  <div className="pt-2 space-y-2">
    <button className="w-full py-3.5 px-6 rounded-2xl font-semibold bg-slate-900 text-white hover:bg-slate-800 transition-all shadow-md">
      Continuar
    </button>
    <button className="w-full py-2 text-xs font-medium text-slate-500 hover:text-slate-800 transition-colors">
      Volver al paso anterior
    </button>
  </div>
</div>
```
