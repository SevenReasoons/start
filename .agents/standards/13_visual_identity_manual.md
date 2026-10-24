---
trigger: always_on
description: Manual oficial de identidad visual Seven Reasoons. Estandar innegociable para prototipos, interfaces y landing pages.
---

# 🎨 13. Seven Reasoons - Manual de Identidad Visual

> **Propósito:** Estandarizar los elementos visuales de la marca **Seven Reasoons** para asegurar una experiencia premium, minimalista y coherente en todos sus prototipos de venta y validación comercial.
> **Ámbito de Aplicación:** **EXCLUSIVO PARA PROTOTIPOS** (Rol Awareness / Arquetipo 1 / Demos de Venta <24h).
> **Desacoplamiento con Producción:** Este estilo de marca NO se traslada a software de clientes en producción ni a SaaS B2B, los cuales utilizan sus propios Design Tokens o los presets de `.agents/standards/08_ui_system_and_a11y.md`.
> **Prioridad de Tema:** **TEMA CLARO OBLIGATORIO POR DEFECTO (Luxury Minimalist Light).** Todo prototipo nace en fondo blanco/aireado.

---

## 0. Prioridad Innegociable: Tema Claro en Prototipos (Luxury Minimalist Light)

Para transmitir máxima sofisticación, orden y profesionalismo (estilo Apple / Stripe), **el Tema Claro es la opción prioritaria y por defecto** para todos los prototipos:
* **Fondo Principal:** Blanco puro (`#ffffff` o `bg-white`) con degradados radiales ultra-sutiles a pizarra tenue (`#f8fafc` o `bg-slate-50`).
* **Superficies y Tarjetas:** Fondo interior blanco sólido (`bg-white`), destacando las tarjetas premium con el borde degradado de 2px y las regulares con `border-slate-100`.
* **Tipografía:** Textos principales en pizarra profundo (`text-slate-900` / `#0f172a`) y textos secundarios en `text-slate-600` (`#475569`).
* **Sombras:** Sombras amplias y difusas de baja opacidad (`shadow-[0_20px_40px_-15px_rgba(0,0,0,0.06)]`), evitando fondos oscuros o pesados.

---

## 1. El Protagonista: El Degradado

La identidad visual se centra en un degradado lineal de cuatro colores específicos que deben ser siempre visibles y vibrantes.

### Colores (Paleta Oficial)
| Color | Hexadecimal | Representación | Variable CSS / Token |
| :--- | :--- | :--- | :--- |
| **Rojo** | `#ef4444` | Rojo Intenso (Tailwind red-500) | `--sr-red: #ef4444;` |
| **Naranja** | `#f97316` | Naranja Vibrante (Tailwind orange-500) | `--sr-orange: #f97316;` |
| **Verde** | `#22c55e` | Verde Lima (Tailwind green-500) | `--sr-green: #22c55e;` |
| **Azul** | `#3b82f6` | Azul Brillante (Tailwind blue-500) | `--sr-blue: #3b82f6;` |

> [!IMPORTANT]
> **LA REGLA DE ORO**: El degradado **NUNCA** se utiliza como relleno (*background*) de botones o elementos grandes. Su uso es **exclusivo para bordes** y acentos tipográficos técnicos, para mantener la elegancia y la legibilidad.

### Implementación Técnica

#### A. Tailwind CSS (Valor Arbitrario)
Para asegurar que los cuatro colores sean visibles (ya que Tailwind estándar soporta hasta 3 paradas nativas), se debe usar el valor arbitrario:
```html
bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)]
```

#### B. CSS Nativo
```css
:root {
  --sr-gradient: linear-gradient(to right, #ef4444, #f97316, #22c55e, #3b82f6);
}
```

---

## 2. Tipografía

* **Familia Principal:** `Inter` (Google Fonts).
* **Pesos Priorizados:** `Light (300)`, `Regular (400)`, `Medium (500)` y `Bold (700)`.
* **Espaciado y Tracking:**
  - Títulos principales (`<h1>`, `<h2>`): `tracking-tighter` (o `letter-spacing: -0.05em`).
  - Badges, etiquetas y labels en mayúsculas: `tracking-widest` (o `letter-spacing: 0.1em`).

---

## 3. Componentes Clave

### A. Botones de Llamada a la Acción (CTA)
* **Estructura:** Borde degradado de 2px con relleno sólido (blanco en modo light o `slate-900` / `#0f172a` en modo dark).
  > **REGLA DE ORO:** El degradado solo va en el borde perimetral. El interior del botón siempre es sólido.
* **Radio de curvatura:** `rounded-2xl` (16px) para un aspecto moderno y suave.
* **Micro-interacción Hover:** Desplazamiento vertical `-translate-y-1` y sombra profunda `shadow-2xl` (o `shadow-[0_20px_35px_-10px_rgba(59,130,246,0.3)]`).

#### Patrón HTML/Tailwind para Botón CTA (Tema Claro Prioritario):
```html
<div class="inline-block p-[2px] rounded-2xl bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)] transition-all duration-200 hover:-translate-y-1 hover:shadow-2xl hover:shadow-blue-500/20">
  <button class="w-full px-6 py-3 rounded-[14px] bg-white hover:bg-slate-50 text-slate-900 font-semibold text-sm flex items-center justify-center gap-2 transition-colors">
    <span>Iniciar Experiencia</span>
  </button>
</div>
```

### B. Bordes de Tarjetas
* **Tarjetas Highlight / Premium:** Llevan el borde degradado completo de 2px envolviendo un fondo sólido interior blanco (`bg-white` en tema claro).
* **Tarjetas Estándar / Secundarias:** Llevan bordes sutiles neutros (`border-slate-100` / `border-slate-200`).

---

## 4. Logotipo Oficial

* **URL Oficial:**
  ```text
  https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png
  ```
* **Uso en Footer:** Siempre centrado, con opacidad reducida (`opacity-50`) y en escala de grises (`grayscale`), volviendo a color total y opacidad 100% al pasar el cursor (`hover:opacity-100 hover:grayscale-0`).

```html
<footer class="w-full py-8 flex flex-col items-center justify-center gap-4">
  <img 
    src="https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png" 
    alt="Seven Reasoons Logo" 
    class="h-8 w-auto opacity-50 grayscale hover:opacity-100 hover:grayscale-0 transition-all duration-300"
  />
  <p class="text-xs text-slate-500 font-light tracking-wide">
    Made with love by Seven Reasoons &bull; Respondemos en menos de una hora
  </p>
</footer>
```

---

## 5. Datos de Contacto Oficiales

* **WhatsApp Oficial:** `5649328703` (México `+52 56 4932 8703`).
* **Enlace Directo Oficial:**
  ```text
  https://wa.me/525649328703
  ```
* **Texto de Promesa:** Siempre acompañar el botón de contacto con el compromiso de atención ágil:
  > *"Respondemos en menos de una hora."*

---

## 6. Tono de Comunicación y Filosofía Estética

* **Carácter:** Premium, minimalista y directo.
* **Espaciado Generoso:** Priorizar el espacio negativo (márgenes y paddings amplios) para permitir que el contenido "respire".
* **Firma de Calidad:** Todo desarrollo, prototipo o pantalla debe incluir el sello corporativo:  
  **"Made with love by Seven Reasoons"**.
