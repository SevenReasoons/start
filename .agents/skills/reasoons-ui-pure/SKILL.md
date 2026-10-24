---
name: reasoons-ui-pure
description: >-
  [EXCLUSIVO PROTOTIPOS DE VENTA <24H - ROL AWARENESS] Crea prototipos hiper-estéticos
  e interactivos bajo el estándar Seven Reasoons Pure: Tema Claro, Regla de Oro del degradado
  de 4 colores exclusivo para bordes de 2px con relleno blanco sólido, botón 16px, logo oficial
  y WhatsApp con respuesta en <1h. NO USAR EN SISTEMAS FINALES DE CLIENTES (usar standards/08).
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🛸 Seven Reasoons Pure — Skill Oficial de UI para Prototipos (`reasoons-ui-pure`)

> **Propósito:** Automatizar la creación de prototipos de venta, demos interactivas y MVPs de validación comercial (<24h, Rol Awareness / Arquetipo 1) con el lenguaje visual canónico de **Seven Reasoons Pure**.
> **Ámbito Estricto:** **EXCLUSIVO PARA PROTOTIPOS Y DEMOS COMERCIALES**. No aplicar a sistemas de clientes en producción ni a SaaS B2B, los cuales utilizan los Design Tokens propios del cliente o los Presets neutros de `.agents/standards/08_ui_system_and_a11y.md`.

---

## ⚡ Los 7 Axiomas Innegociables de Seven Reasoons Pure

1. **Tema Claro Obligatorio (Luxury Minimalist Light):**
   - Fondo de página blanco puro (`#ffffff`) con transiciones radiales tenues a pizarra suave (`#f8fafc`).
   - Textos de máximo contraste: títulos en pizarra profundo (`#0f172a` / `text-slate-900`) y cuerpo en gris neutro (`#64748b` / `text-slate-600`).
   - Cero fondos oscuros pesados o grises deprimentes.
2. **La Regla de Oro del Degradado:**
   - Paleta de 4 colores:
     - 🔴 Rojo: `#ef4444` (Tailwind `red-500`)
     - 🟠 Naranja: `#f97316` (Tailwind `orange-500`)
     - 🟢 Verde: `#22c55e` (Tailwind `green-500`)
     - 🔵 Azul: `#3b82f6` (Tailwind `blue-500`)
   - **NUNCA usar el degradado como relleno/fondo.** Su uso es **exclusivo para bordes de 2px** y acentos tipográficos técnicos.
3. **Interiores Sólidos Blancos:**
   - Toda tarjeta y botón CTA que lleve el borde degradado de 2px debe tener su **relleno interior sólido blanco (`#ffffff`)**.
4. **Tipografía Editorial Inter:**
   - Google Fonts `Inter` (pesos 300 Light, 500 Medium, 700 Bold, 800 ExtraBold).
   - Títulos principales con `letter-spacing: -0.05em;` (`tracking-tighter`) y `text-wrap: balance;`.
   - Etiquetas, badges y subtítulos en mayúsculas con `letter-spacing: 0.1em;` (`tracking-widest`).
5. **Botón CTA Oficial:**
   - Borde degradado de 2px (`p-[2px] bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)]`).
   - Relleno interior blanco sólido, radio `rounded-2xl` (16px).
   - Micro-animación al hover: elevación `-translate-y-1` y sombra difusa `shadow-2xl`.
6. **Logotipo Oficial en Footer:**
   - URL: `https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png`
   - Centrado, `opacity-50`, `filter: grayscale(100%)`.
   - Al pasar el cursor: `opacity-100` y `filter: grayscale(0%)` con transición suave (300ms).
   - Leyenda obligatoria: *"Made with love by Seven Reasoons"*.
7. **Contacto Directo por WhatsApp:**
   - Enlace oficial: `https://wa.me/525649328703` (Tel: `5649328703`).
   - Compromiso de servicio innegociable: *"Respondemos en menos de una hora"*.

---

## 🏗️ Flujo de Construcción de un Prototipo Seven Reasoons Pure

Cuando el usuario te pida crear o adaptar un prototipo al estilo Seven Reasoons Pure, sigue esta secuencia exacta:

### Paso 1: Estructura HTML Base
Monta el documento con los recursos oficiales en el `<head>`:
```html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>[Nombre del Proyecto] — Prototipo &bull; Seven Reasoons</title>
  <!-- Google Fonts: Inter -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/styles.css" />
  <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="sr-body">
  <!-- 1. Tarjeta Highlight con Borde Degradado de 2px -->
  <main class="sr-card-border">
    <div class="sr-card-inner">
      <!-- Badge de Estado -->
      <div class="sr-badge">
        <span class="sr-live-dot"></span>
        <span>PROTOTIPO FUNCIONAL &bull; SEVEN REASOONS</span>
      </div>

      <!-- Título de la Solución -->
      <h1 class="sr-title">[Nombre del Proyecto]</h1>
      <p class="sr-desc">[Propuesta de valor clara, concisa y sin rodeos]</p>

      <!-- Área de Demostración Interactiva -->
      <div id="demoContent" class="sr-interactive-area">
        <!-- Renderizado por JS con KPIs y elementos reales -->
      </div>

      <!-- Botón CTA Oficial con Regla de Oro -->
      <div class="sr-cta-border">
        <button id="primaryAction" class="sr-cta-button">
          <i data-lucide="sparkles" class="sr-icon-cta"></i>
          <span>Interactuar con Demostración</span>
        </button>
      </div>

      <!-- Enlace Oficial WhatsApp -->
      <div class="sr-whatsapp-box">
        <a href="https://wa.me/525649328703" target="_blank" rel="noopener noreferrer" class="sr-whatsapp-link">
          <i data-lucide="message-circle" class="sr-whatsapp-icon"></i>
          <span>WhatsApp Oficial: 5649328703 &bull; Respondemos en menos de una hora</span>
        </a>
      </div>
    </div>
  </main>

  <!-- 2. Footer Oficial Seven Reasoons -->
  <footer class="sr-footer">
    <img 
      src="https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png" 
      alt="Seven Reasoons Logo" 
      class="sr-logo"
    />
    <p class="sr-footnote">Made with love by Seven Reasoons</p>
  </footer>

  <script src="js/mock-data.js"></script>
  <script src="js/app.js"></script>
</body>
</html>
```

---

### Paso 2: El Core CSS de Seven Reasoons Pure (`css/styles.css`)

```css
:root {
  /* Paleta Oficial Seven Reasoons */
  --sr-red: #ef4444;
  --sr-orange: #f97316;
  --sr-green: #22c55e;
  --sr-blue: #3b82f6;
  --sr-gradient: linear-gradient(to right, var(--sr-red), var(--sr-orange), var(--sr-green), var(--sr-blue));

  /* Superficies en Tema Claro (Luxury Minimalist Light) */
  --bg-page: #f8fafc;
  --card-bg: #ffffff;
  --text-main: #0f172a;
  --text-muted: #64748b;
  --border-subtle: #e2e8f0;
  --border-light: #f1f5f9;
  --area-bg: #f8fafc;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body.sr-body {
  min-height: 100dvh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: radial-gradient(circle at 50% 0%, #ffffff 0%, var(--bg-page) 100%);
  color: var(--text-main);
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  padding: 2.5rem 1rem;
  line-height: 1.5;
  -webkit-font-smoothing: antialiased;
}

/* Tarjeta Highlight: Borde Degradado de 2px con Interior Blanco Sólido */
.sr-card-border {
  width: 100%;
  max-width: 540px;
  padding: 2px;
  border-radius: 24px;
  background: var(--sr-gradient);
  box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.07), 0 0 1px 1px rgba(0, 0, 0, 0.02);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.sr-card-inner {
  background: var(--card-bg);
  border-radius: 22px;
  padding: 2.5rem 2rem;
  text-align: center;
}

/* Badge Superior con Pulsing Dot */
.sr-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.35rem 0.85rem;
  border-radius: 9999px;
  background: #f1f5f9;
  border: 1px solid var(--border-subtle);
  color: #475569;
  font-size: 0.7rem;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  margin-bottom: 1.25rem;
}

.sr-live-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--sr-green);
  box-shadow: 0 0 8px rgba(34, 197, 94, 0.6);
  animation: srPulse 2s infinite ease-in-out;
}

@keyframes srPulse {
  0%, 100% { transform: scale(1); opacity: 1; }
  50% { transform: scale(1.25); opacity: 0.7; }
}

/* Títulos y Tipografía */
.sr-title {
  font-size: 2.15rem;
  font-weight: 800;
  letter-spacing: -0.05em;
  color: var(--text-main);
  text-wrap: balance;
  margin-bottom: 0.5rem;
}

.sr-desc {
  color: var(--text-muted);
  font-size: 0.95rem;
  font-weight: 400;
  line-height: 1.6;
  text-wrap: pretty;
  margin-bottom: 1.75rem;
}

/* Área Interactiva */
.sr-interactive-area {
  background: var(--area-bg);
  border: 1px solid var(--border-subtle);
  border-radius: 16px;
  padding: 1.25rem;
  margin-bottom: 1.5rem;
  text-align: left;
}

/* BOTÓN CTA OFICIAL SEVEN REASOONS (LA REGLA DE ORO) */
.sr-cta-border {
  display: block;
  width: 100%;
  padding: 2px;
  border-radius: 16px;
  background: var(--sr-gradient);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
}

.sr-cta-border:hover {
  transform: translateY(-3px);
  box-shadow: 0 20px 35px -10px rgba(59, 130, 246, 0.25);
}

.sr-cta-button {
  width: 100%;
  min-height: 50px;
  background: #ffffff;
  color: #0f172a;
  border: none;
  border-radius: 14px;
  font-family: 'Inter', sans-serif;
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  transition: background 0.2s ease;
}

.sr-cta-button:hover {
  background: #f8fafc;
}

.sr-icon-cta {
  width: 18px;
  height: 18px;
  color: var(--sr-blue);
}

/* WhatsApp Box */
.sr-whatsapp-box {
  margin-top: 1.5rem;
  padding-top: 1.25rem;
  border-top: 1px solid var(--border-subtle);
}

.sr-whatsapp-link {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-muted);
  text-decoration: none;
  font-size: 0.8rem;
  font-weight: 500;
  transition: color 0.2s ease;
}

.sr-whatsapp-link:hover {
  color: #16a34a;
}

.sr-whatsapp-icon {
  width: 16px;
  height: 16px;
  color: #22c55e;
}

/* Footer y Logotipo */
.sr-footer {
  margin-top: 2.5rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  text-align: center;
}

.sr-logo {
  height: 28px;
  width: auto;
  opacity: 0.5;
  filter: grayscale(100%);
  transition: all 0.3s ease;
  cursor: pointer;
}

.sr-logo:hover {
  opacity: 1;
  filter: grayscale(0%);
}

.sr-footnote {
  font-size: 0.75rem;
  font-weight: 400;
  color: #94a3b8;
  letter-spacing: 0.05em;
}
```

---

## 🚀 Implementación Rápida con Scaffolding Oficial

Para generar de inmediato un proyecto con esta estructura, invoca en la terminal:

```powershell
# En Windows (PowerShell):
.\scripts\init-project.ps1 -Role 1 -Archetype [1-18] -ProjectName "[nombre]"

# En Linux / Mac / WSL2 (Bash):
./scripts/init-project.sh 1 [1-18] "[nombre]"
```

El proyecto se creará automáticamente en **Tema Claro**, con la **Regla de Oro** en cada botón y tarjeta, datos simulados de la industria en `js/mock-data.js`, y listo para correr con `npx vercel dev` o abrir directamente en el navegador con cero dependencias externas.
