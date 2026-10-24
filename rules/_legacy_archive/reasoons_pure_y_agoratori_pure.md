# Reglas de Diseño Visual (HoldCo Design Systems)

Siempre que modifiques o crees código UI (Frontend/React/Tailwind), DEBES verificar en qué ruta física de la arquitectura vive el archivo para aplicar el sistema de diseño correcto. NUNCA mezcles los estilos.

## Regla de Enrutamiento Físico
* Si el archivo vive en `app/[locale]/seven-reasoons/` -> Aplica **Seven Reasoons Pure**.
* Si el archivo vive en `app/[locale]/agoratori/` -> Aplica **Agoratori Pure**.

---

## 1. Seven Reasoons Pure (La Holding)
**Vibra:** Premium, corporativo, ultra-minimalista, limpio, aireado (estilo Apple/Vercel).
* **Fondo:** Primariamente Blanco (`bg-white`) o Slate muy claro (`bg-slate-50`).
* **Tipografía:** Pesos ligeros (`font-light`) para legibilidad. Letras pegadas en títulos grandes (`tracking-tighter`). Títulos de metadata en mayúsculas (`tracking-widest uppercase`).
* **El Degradado Maestro:** `bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)]`.
* **REGLA DE ORO DEL DEGRADADO:** NUNCA se usa como relleno/background sólido de botones o contenedores grandes. Solo se usa para:
  1. Textos (`bg-clip-text text-transparent`).
  2. Bordes de componentes destacados (mediante un wrapper con padding `p-[2px]` y un contenedor hijo con fondo sólido).
* **Logo:** Si se coloca un logo externo, aplicar `grayscale opacity-50 transition-all hover:grayscale-0 hover:opacity-100`.

---

## 2. Agoratori Pure (El Producto Digital)
**Vibra:** Dashboard de alto rendimiento, futurista, neón, modo oscuro dominante.
* **Fondo:** Oscuros dominantes (`bg-slate-950`, `bg-slate-900`, `bg-black`).
* **Acentos:** Azules vibrantes (`blue-600`), cian, o gradientes tecnológicos fríos.
* **Componentes:** Efectos de brillo/neón (`shadow-blue-500/20`), glassmorphism pesado (`backdrop-blur-xl bg-white/5` sobre fondos oscuros).
* **Bordes:** Bordes sutiles grises/transparentes (`border-white/10`).
* **Tipografía:** Pesos estructurados (`font-medium`, `font-bold`) para resaltar datos duros, tablas y métricas (modo SaaS).

---

## 3. Digital Reasoons (Servicios Tecnológicos & Enterprise)
**Vibra:** Tecnológico de vanguardia, confianza corporativa B2B, alta ingeniería y claridad ejecutiva.
* **Fondo:** Primariamente limpio (`bg-white` o `bg-slate-50`), con secciones de alto contraste corporativo (`bg-slate-900` o `bg-slate-950` para terminales, demos interactivas o métricas de infraestructura).
* **Acentos:** Índigo moderno (`indigo-600`) y azul tecnológico (`blue-500`), integrando sutilmente el degradado de 4 colores Seven Reasoons **únicamente en bordes perimetrales o badges destacados**.
* **Tipografía:** Moderna (Inter / Outfit), jerarquía marcada con subtítulos técnicos en `tracking-widest uppercase text-xs`.
* **Componentes:** Tarjetas de la Escalera de Servicios con micro-interacciones hover (`hover:-translate-y-1 hover:shadow-lg`), calculadoras DQI interactivas, logos de clientes (Kellanova, ZF, Mercado Libre) con filtro monocromático que revela color al hover (`grayscale hover:grayscale-0`).
