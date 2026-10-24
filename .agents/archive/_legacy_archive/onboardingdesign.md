---
trigger: always_on
---

# 🎨 SOP Diseño UI/UX: Handoff y Sistema de Diseño Multi-Tenant

Este documento está dirigido a **Diseñadores UI/UX y Product Designers**. 

En Agoratori no dibujamos pantallas, construimos **Sistemas de Diseño Escalar (Design Systems)**. Dado que somos una plataforma Multi-Tenant (Marca Blanca), tu diseño en Figma se traducirá matemáticamente a miles de clientes diferentes. No puedes usar colores fijos.

---

## 1. La Ley Suprema: "Design Tokens" (Semantic Naming)

En nuestro código, está estrictamente prohibido usar colores como "Azul" o "Rojo". Los desarrolladores Frontend inyectan los colores dinámicamente desde la base de datos usando **Design Tokens**.

### Tu trabajo en Figma:
Nunca nombres tus estilos de color o texto por su valor físico. Usa nombres semánticos que el código pueda heredar 1:1.

* ❌ **Prohibido:** `Brand/Blue`, `Text/Dark-Grey`, `Button/Green`
* ✅ **Obligatorio:** 
  * `--primary` (Color principal de la marca, ej. para el botón principal).
  * `--secondary` (Color secundario de la marca).
  * `--destructive` (Color para errores o borrar, usualmente rojo, pero semántico).
  * `--muted` (Para textos secundarios o fondos tenues).
  * `--primary-foreground` (El color del texto que va *encima* del color primary, usualmente blanco o negro para contraste).

> 💡 **Por qué importa:** Cuando un nuevo cliente (Inquilino) entra a la plataforma, el desarrollador solo cambia el valor hexadecimal de `--primary` en la base de datos, y **todo tu diseño cambia de identidad automáticamente** sin tocar una línea de código.

---

## 2. Construcción con Auto Layout (Flexbox)

Nuestro frontend está construido con *Tailwind CSS* (que usa Flexbox y CSS Grid). 
* Todo, absolutamente todo lo que diseñes en Figma, debe usar **Auto Layout**.
* No uses posicionamiento absoluto ni agrupes elementos a la fuerza. El código no entiende de elementos flotando libremente.
* Si el texto crece (ej. si se traduce al alemán, que tiene palabras muy largas), tu botón o tarjeta en Figma debe empujar los demás elementos hacia abajo, exactamente como lo haría el navegador.

---

## 3. Paradigma Mobile-First y Accesibilidad

Nuestros desarrolladores tienen órdenes de programar para móviles primero. Tu diseño debe reflejarlo.

1. **Empieza en Móvil:** Diseña primero tu *Frame* en tamaño estándar de celular (ej. iPhone 14 - 390px de ancho). El diseño de escritorio es solo una expansión de ese modelo base.
2. **Regla del Dedo Gordo (Touch Targets):** Cualquier botón, ícono clickeable o enlace debe tener un área de impacto (*bounding box* en Figma) de mínimo **44x44 píxeles**. Esto es un estándar inquebrantable de accesibilidad para móviles.

---

## 4. El Handoff (Entrega a los Desarrolladores)

Antes de pasar el enlace de Figma al equipo de ingeniería o pegarlo en un ticket de Jira, asegúrate de cumplir este checklist:

- [ ] Todos los colores y tipografías están atados a *Variables locales (Tokens)* y no hay valores sueltos.
- [ ] No existen *Instancias Desvinculadas (Detached instances)*. Si usas un botón, debe venir del componente maestro.
- [ ] Todos los íconos están marcados como "Exportables" en formato **SVG**.
- [ ] Los estados de interacción (Hover, Pressed, Disabled) existen visualmente al lado de la pantalla principal. No obligues al desarrollador a adivinar cómo se ve un botón cuando está desactivado.

¡Si sigues estas reglas, el salto de Figma a código Next.js será mágico y sin fricciones! 🪄
