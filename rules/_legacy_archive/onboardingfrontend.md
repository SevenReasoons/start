---
trigger: always_on
---

# 🎨 SOP Frontend: Manual de Especialización

Este documento profundiza en las reglas y metodologías para desarrollar la Interfaz de Usuario (UI) en el ecosistema Agoratori. Si tu tarea involucra crear pantallas, botones, formularios o animaciones, este es tu manual.

---

## 1. El Ecosistema de UI (Piezas de Lego)

Nuestro frontend está estrictamente dividido en dos capas:

* **Componentes Tontos (Design System Maestro):** Viven en `packages/ui/src/components/ui/` y se importan vía `@repo/ui` (o subrutas como `@repo/ui/Button`). Son botones, inputs, diálogos, selectores y tarjetas con variantes universales y de marca (`srGradient`, `seven-reasoons`) que **no saben nada del negocio**. Solo reciben `props` y emiten eventos.
* **Componentes Inteligentes (Features y Vistas):** Viven en `apps/web/components/features/` o en las vistas dinámicas `apps/web/app/[tenant]/`. Aquí ensamblamos los componentes tontos, los conectamos a Supabase o Server Actions, manejamos el estado de carga y aplicamos la lógica de negocio.

**Regla de Oro:** Nunca metas llamadas a la base de datos dentro de un componente genérico en `packages/ui`.

---

## 2. Zero-Hardcoding: Temas e Idiomas

Desarrollamos una plataforma Marca Blanca. No construimos para un solo cliente.

### 🎨 Textos y Traducciones (i18n)
Nunca escribas textos estáticos en el código.
❌ `<h1>Bienvenido a la tienda</h1>`
✅ `<h1>{t('welcomeMessage')}</h1>`
Todos los textos provienen de los archivos JSON en `apps/web/messages/`.

### 💅 Colores y Design Tokens
Nunca uses clases de color estáticas de Tailwind que aten un componente a una marca.
❌ `className="bg-blue-600 text-white"`
✅ `className="bg-primary text-primary-foreground"`
Nuestra arquitectura inyecta los verdaderos valores hexadecimales (ej. `#ff0000`) en las variables `--primary` y `--primary-foreground` al momento en que el usuario carga la página (basado en la base de datos).

---

## 3. Tailwind Merge: La Regla del `cn()`

Cuando miles de desarrolladores modifican componentes, las colisiones CSS son inevitables. Para evitarlo, usamos la función `cn` importada desde `@/lib/utils` (nunca desde la librería npm `cn`).

* **¿Cómo se usa?**
  Si estás diseñando un componente que recibe un `className` externo, debes envolver los estilos por defecto y los entrantes en `cn()`.
  
  ```tsx
  import { cn } from "@/lib/utils";

  export function MiBoton({ className, ...props }) {
    return (
      <button 
        className={cn("bg-primary text-primary-foreground rounded-md p-4", className)} 
        {...props} 
      />
    );
  }
  ```
  Si el desarrollador que consume `MiBoton` le pasa `className="bg-red-500"`, la función `cn` eliminará inteligentemente `bg-primary` para que el rojo domine sin colisiones.

---

## 4. Diseño Mobile-First y Accesibilidad

No adaptamos el diseño de escritorio a móvil; diseñamos para móvil y mejoramos para escritorio.

1. **Empieza en Móvil:** Tus clases base en Tailwind SIEMPRE deben ser para la pantalla del celular.
   * `className="flex flex-col md:flex-row"` (Primero es columna para celular, luego fila para PC).
2. **Alturas Dinámicas (dvh):** Prohibido usar `h-screen`. En iOS/Android, las barras de búsqueda retráctiles taparán tu contenido. Usa `h-[100dvh]` siempre.
3. **Touch Targets:** Cualquier botón o enlace en móvil debe medir al menos `44x44px`. Evita el *Fat-finger syndrome*.
4. **Testing (data-testid):** El equipo de QA usará automatización (Playwright). Es **obligatorio** que todos los elementos interactivos (botones, inputs, modales) tengan el atributo `data-testid="nombre-del-elemento"` para que las pruebas no se rompan si cambiamos el diseño.

---

## 5. Zod y Formularios: Tu Escudo (Boilerplate)

Ningún formulario se envía al backend sin ser validado localmente primero. Usamos `react-hook-form` acoplado a `@hookform/resolvers/zod`.

**Boilerplate Estándar para Formularios:**
```tsx
"use client";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { miEsquemaZod, type MiEsquemaTipo } from "@/lib/schemas/mi-dominio";
import { Input, Button } from "@repo/ui";

export function FormularioSeguro() {
  const form = useForm<MiEsquemaTipo>({
    resolver: zodResolver(miEsquemaZod),
  });

  const onSubmit = (data: MiEsquemaTipo) => {
    // Los datos aquí ya están validados y son 100% seguros
    console.log(data);
  };

  return (
    <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
      <Input {...form.register("email")} placeholder="Tu correo" />
      {form.formState.errors.email && (
        <span className="text-destructive text-sm">{form.formState.errors.email.message}</span>
      )}
      <Button type="submit">Enviar</Button>
    </form>
  );
}
```

---

## 6. Next.js App Router: Server vs Client Components

El rendimiento lo es todo. Por defecto, **TODO** en `apps/web` es un Componente de Servidor (Server Component).

* **Componentes de Servidor (Por Defecto):** Úsalos para hacer Fetching de datos (ej. consultar a Supabase directamente), leer cookies, y renderizar HTML estático ultra rápido. **No tienen acceso a `useState` ni a `onClick`.**
* **Componentes de Cliente (`"use client"`):** Úsalos **exclusivamente** en los archivos más pequeños posibles (hojas del árbol) cuando necesites interactividad, hooks de React, o consumir librerías del navegador. 

**Regla de Oro de Rendimiento:** Nunca pongas `"use client"` en la cima de un `layout.tsx` o un `page.tsx` grande, ya que obligarás a los clientes a descargar un bloque masivo de JavaScript. Aísla la interactividad (ej. envuelve solo tu `<BotonInteractuar />` en su propio archivo cliente).

¡Sé impecable con tu código, respeta los componentes tontos y diviértete creando experiencias de clase mundial! 🚀

---

## 7. Arquitectura SSO Universal (Pasaporte Universal)

El flujo de autenticación (SSO) sigue un patrón de diseño estrictamente modular y granular, para permitir su uso desde cualquier punto del monorepo:

1. **Átomos (UI Kit):** Componentes base (`Button.tsx`, `Input.tsx`, `Select.tsx`) que viven en `packages/ui/src/components/ui/` (`@repo/ui`). Son agnósticos de estado y puramente visuales.
2. **Moléculas (Auth Steps):** Cada fase de autenticación es un componente aislado en `apps/web/components/auth/`:
   * `PhoneStep.tsx` (Ingreso de número)
   * `OtpStep.tsx` (Verificación SMS)
   * `PinStep.tsx` (Login rápido)
   * `CreatePinStep.tsx` (Alta de NIP)
3. **Orquestador (Organismo):** `SsoManager.tsx` gestiona el estado local (`step`), las conexiones a Supabase y pasa callbacks a las moléculas.
4. **Página (Plantilla):** La ruta `apps/web/app/[tenant]/login/page.tsx` es meramente un contenedor que envuelve al `SsoManager` en un entorno de marca (Brand Wrapper).

**Regla de Oro del SSO:** NUNCA crees un archivo monolítico gigante de login. Cada paso del flujo debe poder ser extraído y usado independientemente si el negocio lo requiere.

---

## 8. Arquitectura de Alto Rendimiento, Anti-Espagueti y Optimización para Hardware Modesto (Estándar R-Chat & Móvil)

Nuestra plataforma está diseñada para ser una experiencia premium no solo en iPhones o MacBooks de última generación, sino también en **dispositivos de entrada de $50 USD** (tablets y celulares con 1GB a 4GB de RAM, CPUs Cortex-A53 de 4 núcleos y GPUs Mali-G31).

Para garantizar 60 FPS estables, cero fugas de memoria y un código completamente modular libre de "código espagueti", toda vista interactiva debe cumplir los siguientes 7 mandamientos técnicos:

### 1. Descomposición Modular de Monolitos (Anti-Espagueti)
* **Prohibido el "Monolito de 2,500 líneas":** Nunca concentres estado de entrada (input typing), reproductores de audio, conexiones realtime, cifrado y lista de items en un solo archivo.
* **Aislamiento de Input State:** La barra de entrada de texto (`ChatInputBar`) debe mantener su propio estado local (`inputText`, grabación de voz, adjuntos). Al escribir a 120 palabras por minuto, **bajo ninguna circunstancia** debe re-renderizarse el historial de mensajes o elementos superiores.
* **Componentes Despachadores Memoizados:** Usa `React.memo` con comparadores de props precisos (`prev.message.id === next.message.id`, etc.) en elementos de lista (`ChatMessageItem`) delegando a burbujas atómicas con responsabilidad única (`ChatTextBubble`, `ChatVoiceBubble`, `ChatActionCardBubble`).

### 2. Carga Perezosa en Docks y Modales (`next/dynamic` + Montaje Condicional)
* **El Problema del DOM Oculto:** Si un componente padre (ej. `MobileChatDock`) importa estáticamente 4 modales gigantes de 800 a 3,000 líneas y los renderiza con `isOpen={false}`, React compila e inicializa en el JS Heap decenas de hooks, variables y listeners, consumiendo de 35MB a 50MB de memoria muerta.
* **Regla Obligatoria:** Importa modales y paneles pesados mediante `next/dynamic` con `{ ssr: false }`, y móntalos **exclusivamente de forma condicional**:
  ```tsx
  const MobileNotesModal = dynamic(() => import("./MobileNotesModal").then(m => m.MobileNotesModal), { ssr: false });

  // En el JSX:
  {isNotesModalOpen && (
    <MobileNotesModal isOpen={isNotesModalOpen} onClose={() => setIsNotesModalOpen(false)} />
  )}
  ```
  Esto reduce el consumo de RAM inicial en más del 70% en dispositivos económicos.

### 3. Virtualización Nativa CSS (`content-visibility: auto`)
* En lugar de cargar librerías de virtualización pesadas que complejizan el scroll y los layouts dinámicos, utiliza el motor nativo del navegador mediante clases utilitarias de contención:
  ```css
  @utility chat-bubble-item {
    content-visibility: auto;
    contain-intrinsic-size: auto 68px;
  }
  @utility chat-conversation-item {
    content-visibility: auto;
    contain-intrinsic-size: auto 76px;
  }
  ```
* **Impacto:** Chromium y WebKit omiten por completo el trabajo de cálculo de layout y pintura GPU para todos los nodos que se encuentran fuera del viewport.

### 4. Paginación Inversa Determinista por Cursor
* Nunca cargues 500 o 1,000 elementos de golpe en el DOM.
* **Carga Inicial Acotada:** Solicita únicamente los 30 a 35 mensajes más recientes.
* **Centinela Superior con IntersectionObserver:** Coloca un centinela `<div ref={topSentinelRef} />` arriba de la lista.
* **Consulta por Cursor:** Usa `.lt("created_at", oldestMessage.createdAtIso)` para paginar hacia el pasado sin duplicados ni saltos.
* **Preservación Milimétrica del Scroll:**
  ```typescript
  const prevHeight = scrollContainer.scrollHeight;
  // Tras prepender los mensajes antiguos:
  requestAnimationFrame(() => {
    scrollContainer.scrollTop = scrollContainer.scrollHeight - prevHeight;
  });
  ```

### 5. Cero Fugas de Memoria en Multimedia (`Blob` y `ObjectURL`)
* Cada llamada a `URL.createObjectURL(blob)` reserva un bloque de memoria RAM en el motor del navegador que **nunca es liberado por el Garbage Collector** hasta que la página se recarga.
* **Regla Obligatoria:** Llama siempre a `URL.revokeObjectURL(url)` tan pronto como un archivo se suba, se descarte una grabación o termine de reproducirse un audio.
* **Singleton de Audio:** Centraliza la reproducción en un único reproductor (`chatAudioPlayer.ts`) con un único elemento `<audio>` para evitar que múltiples ondas de audio compitan por hardware o filtren buffers.

### 6. Local-First Caching con IndexedDB
* Utiliza almacenes locales estructurados (`chatVaultDb.ts`) para persistir datos ya procesados o descifrados.
* Al alternar entre vistas o conversaciones, los datos se recuperan de IndexedDB en **0 ms**, eliminando spinners de carga y liberando al procesador móvil de calcular descifrados repetitivos.

### 7. Dieta de GPU (Hardware Acceleration Consciente)
* Evita anidar múltiples capas con `backdrop-filter: blur(24px)` o sombras gaussianas intensas en móviles, ya que colapsan GPUs integradas (Mali-G31 / PowerVR) a menos de 15 FPS.
* Prefiere fondos translúcidos sólidos con opacidad alta (`bg-white/90`, `bg-slate-900/90`) y micro-animaciones CSS puras (`@utility animate-bubble-in`) limitadas a `transform` y `opacity` (hilo del compositor de GPU).

