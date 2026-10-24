---
trigger: always_on
---

# 📱 07. Frontend, Mobile-First Radical y Rendimiento en Hardware Modesto

> **Propósito:** Definir los estándares de desarrollo de interfaces de usuario para aplicaciones web y móviles: Mobile-First innegociable, experiencia a 60 FPS estables, presupuesto de memoria acotado y erradicación total de fugas de memoria en multimedia.

---

## 1. Paradigma Mobile-First Radical

No diseñamos para monitores 4K y luego "encogemos" la web para teléfonos. **Todo componente se programa primero para pantallas móviles táctiles.**

1. **Jerarquía de Clases:**
   - La clase base de CSS/Tailwind es móvil por defecto (ej. `w-full text-base`).
   - Los modificadores de pantalla grande (`md:`, `lg:`, `xl:`) se aplican exclusivamente como mejora progresiva.
2. **Prohibición de `h-screen` (Uso Obligatorio de `dvh`):**
   - Las barras de URL retráctiles de Safari iOS y Chrome Android tapan el contenido inferior cuando se usa `h-screen`.
   - **Regla estricta:** Utilizar siempre `h-[100dvh]` (Dynamic Viewport Height) para garantizar que la app respete los bordes reales de la pantalla.
3. **Zonas Táctiles de 44x44px (Touch Targets):**
   - Todo botón, ícono interactivo o enlace debe tener un área táctil mínima de **44x44 píxeles** (estándar de Apple y Google de accesibilidad) para evitar pulsaciones erróneas (*Fat-finger syndrome*).
4. **Áreas Seguras (Safe Areas):**
   - El layout raíz debe respetar las áreas seguras (`pt-safe`, `pb-safe`) para que el contenido no quede oculto detrás de la Isla Dinámica, cámaras perforadas o la barra inferior de gestos.

---

## 2. Presupuesto de Rendimiento: Hardware Modesto ($50 USD / 60 FPS)

Nuestra aplicación debe sentirse instantánea en cualquier parte del mundo, incluso en teléfonos de gama de entrada con 1 GB de RAM:

1. **Presupuesto de RAM:**
   - La vista activa de chat o feed no debe exceder los **~25 MB de memoria RAM consumida**.
2. **Virtualización de Listas y Feeds:**
   - Toda lista o feed que supere los 30 elementos debe utilizar virtualización de DOM (ej. `@tanstack/react-virtual`) o la propiedad CSS nativa `content-visibility: auto` con `contain-intrinsic-size` para evitar renderizar nodos fuera de pantalla.
3. **Paginación Inversa por Cursor:**
   - En chats o feeds cronológicos, la paginación hacia el pasado debe consultar por cursor temporal (`.lt("created_at", oldestTimestamp)`) preservando milimétricamente la posición del scroll con `requestAnimationFrame`.

---

## 3. Cero Fugas de Memoria en Multimedia (`Blob` y `ObjectURL`)

Las aplicaciones modernas que manejan audios, imágenes o documentos suelen sufrir colapsos por fugas de memoria invisibles:

1. **Revocación Inmediata de URLs de Blob:**
   - Cada llamada a `URL.createObjectURL(blob)` reserva memoria en el motor del navegador que **nunca es liberada por el Garbage Collector** hasta recargar la página.
   - **Regla Obligatoria:** Invocar siempre `URL.revokeObjectURL(url)` tan pronto como el archivo termine de cargarse, se envíe al servidor o se descarte la grabación.
2. **Singleton de Audio:**
   - Toda reproducción de notas de voz o efectos de sonido debe centralizarse en un único elemento `<audio>` global (`audioPlayerSingleton.ts`), impidiendo que múltiples instancias compitan por buffers de hardware del sistema operativo.

---

## 4. Dieta de GPU (Hardware Acceleration Consciente)

* **Efectos de Desenfoque:** Evitar anidar múltiples capas con `backdrop-filter: blur(24px)` en móviles de gama baja, ya que provocan caídas drásticas de fotogramas (< 20 FPS). Preferir fondos con opacidad sólida (`bg-white/95` o `bg-slate-900/95`).
* **Animaciones:** Restringir las transiciones y micro-interacciones a las propiedades `transform` y `opacity`, las cuales se procesan directamente en el hilo compositor de la GPU sin disparar re-flujos (*reflows*) del árbol DOM.

---

## 5. Internacionalización Frontend Obligatoria (i18n Bilingüe: ES / EN)

Todo frontend debe nacer preparado para operar en múltiples idiomas, con soporte mínimo para **Español (`es`) e Inglés (`en`)**:

1. **Enrutamiento por Segmento de Idioma (`[locale]`):**
   - Las rutas de páginas públicas y privadas se organizan bajo `app/[locale]/...` (ej. `/es/dashboard`, `/en/dashboard`).
   - El middleware detecta automáticamente el idioma preferido del usuario mediante cabeceras `Accept-Language` o cookies guardadas, redirigiendo de forma transparente.
2. **Diccionarios Estructurados y Tipados:**
   - Los textos residen en archivos JSON organizados por dominio en `messages/es.json` y `messages/en.json`.
   - **Tipado Estricto de Llaves:** El cliente de i18n debe autocompletar las claves de traducción en TypeScript. Si se referencia una llave inexistente, el compilador debe emitir un error de tipo.
   - ❌ **Prohibido:** `<span>Continuar</span>`
   - ✅ **Obligatorio:** `<span>{t('common.continue')}</span>`
3. **Formateo Internacional Nativo (`Intl` API):**
   - **Monedas:** Queda prohibido concatenar símbolos a mano (`"$ " + price` ❌). Usar siempre:
     ```typescript
     new Intl.NumberFormat(locale, { style: "currency", currency: "USD" }).format(amount);
     ```
   - **Fechas y Horas:** Usar `new Intl.DateTimeFormat(locale, { dateStyle: "medium" }).format(date)`.
   - **Pluralización:** Gestionada mediante reglas de pluralización ICU en los diccionarios (`{count, plural, =0 {sin mensajes} =1 {un mensaje} other {# mensajes}}`).
4. **SEO Multi-idioma y Accesibilidad:**
   - La etiqueta HTML raíz debe reflejar el idioma activo: `<html lang={locale}>`.
   - En páginas públicas indexables, incluir etiquetas canónicas y enlaces alternativos `hreflang` en el `<head>`:
     ```html
     <link rel="alternate" hrefLang="es" href="https://app.com/es/precios" />
     <link rel="alternate" hrefLang="en" href="https://app.com/en/pricing" />
     ```

---

## 6. Arquitectura Atómica Profesional (Atomic Design) y Handoff a Senior

Para proyectos profesionales desarrollados en Next.js (estándar de rol **Maker** hacia arriba), la organización de componentes DEBE seguir la jerarquía de **Atomic Design** para garantizar hiper-escalabilidad y reutilización:

```text
src/components/ (o components/)
├── atoms/        # Elementos visuales indivisibles: Button, Badge, Input, Label, Icon, Spinner
├── molecules/    # Combinación funcional de 2+ átomos: SearchBar, FormField, StatCard, AvatarDropdown
├── organisms/    # Bloques complejos autónomos: Navbar, Sidebar, ProductGrid, DataTable, CartDrawer
├── templates/    # Layouts estructurales con slots/children: DashboardTemplate, StoreTemplate
└── app/          # Páginas en Next.js App Router (Composición pura sin maquetación inline)
```

### Protocolo de Handoff Perfecto a Ingenieros Senior (Architect / Consultant)
1. **Población de Props Estrictas (Pure UI):**
   - Todos los átomos, moléculas y organismos se maquetan como **componentes puros de presentación**.
   - Toda interacción, dato o estado se recibe mediante `props` tipadas con interfaces TypeScript (`interface ProductCardProps { ... }`).
   - Cero llamadas directas a APIs o Supabase acopladas en los componentes visuales.
2. **Reutilización de Estilos en Next.js:**
   - Prohibido el código CSS caótico, estilos repetidos o inline `style={{ ... }}` innecesarios.
   - Se utilizan tokens de diseño coherentes y clases estructuradas para que la adición de nuevas pantallas sea instantánea.
3. **Flujo de Trabajo entre Niveles:**
   - El **Maker** entrega la aplicación 100% maquetada a nivel atómico, responsive (Mobile-First) y tipada.
   - El **Senior (Consultant/Architect)** recibe el código y **no pierde tiempo rediseñando**: únicamente conecta los hooks de Supabase, Server Actions, estados globales o contratos de API directamente sobre las `props` ya listas del Maker.

