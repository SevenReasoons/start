# Agora Pure (Design System)

**Agora Pure** es nuestro estándar visual principal para el desarrollo Front-End en Digitalhub y Agoratori. Este estilo está enfocado en el minimalismo, la limpieza absoluta y en imitar el comportamiento y "look and feel" de las aplicaciones móviles de mensajería (WhatsApp, iMessage). Todo el sistema toma como **baseline exacto** el diseño de la pestaña de Chats.

## Mandamientos Visuales (Baseline de Chats)

Cuando generes o refactorices código de interfaz de usuario, SIEMPRE debes apegarte a las siguientes reglas y medidas exactas:

1. **Cero Contenedores Pesados (Zero-Chunk UI)**
   - El fondo general de las vistas principales siempre debe ser `bg-background` (blanco/negro puro).
   - Evita tarjetas (`bg-white` sobre `bg-slate-50` con sombras) o bordes perimetrales que encierren el contenido.

2. **Listas Fluidas (Chat-like Lists)**
   - **Contenedor del Item:** Usa `flex gap-3 px-4 py-2 cursor-pointer hover:bg-muted/50 transition-colors`.
   - **Separadores:** La separación no debe envolver el item, sino que solo el contenido de texto lleva el borde inferior: `border-b border-border/40`.
   - **Alineación Vertical:** El contenedor de texto debe tener `py-1 flex flex-col justify-center` para que las líneas queden perfectamente centradas con el avatar.
   - **Sin bordes finales:** Asegúrate de que el último elemento no tenga borde inferior: `group-last:border-transparent`.

3. **Avatares Exactos**
   - **Contenedor del Avatar:** Debe estar envuelto en `relative shrink-0 py-1`.
   - **Tamaño:** Exactamente **52x52 píxeles**: `w-[52px] h-[52px]`.
   - **Estilo:** Completamente redondo (`rounded-full`), con un sutil borde (`border border-border/50`) y color de fondo neutro (`bg-muted text-muted-foreground`) en caso de no tener imagen.

4. **Tipografía Milimétrica**
   - **Títulos de Lista (Nombres):** Exactamente `text-[16px] font-semibold text-foreground truncate tracking-tight`.
   - **Subtítulos (Mensajes/Descripciones):** Exactamente `text-[14px] leading-tight text-muted-foreground truncate`.
   - **Metadatos (Fechas/Horas):** Exactamente `text-[13px] text-muted-foreground`.
   - **Cabeceras de Página:** Ultracompactas (ej. `text-lg font-bold mb-2`) para no robar espacio vertical.

5. **Botones de Acción (Pills)**
   - **Tamaño estándar de botón:** `px-6 py-2.5 text-sm font-semibold`.
   - **Forma:** Siempre redondeados `rounded-full`.
   - **Interacción:** `shadow-sm hover:opacity-90 active:scale-95 transition-all`.
   - **Colores:** Usar colores semánticos como `bg-foreground text-background` para los primarios, o colores de marca explícitos si lo requiere la vista.

## Resumen

Nuestra UI debe sentirse 100% como un cliente de mensajería moderno. Toma como guía principal la estructura del componente de Chats y replica sus tamaños (Avatares de 52px, Títulos de 16px y Textos de 14px) en todas las nuevas listas y directorios del sistema.
