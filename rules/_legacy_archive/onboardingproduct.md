---
trigger: always_on
---

# 📋 SOP de Producto (PMs): Gestión Ágil y Ciclo de Vida de Tareas

Este documento está dirigido a los **Project Managers (PMs), Product Owners y Analistas de Negocio**. 

En Agoratori, la ingeniería no funciona a base de suposiciones ni mensajes de chat informales. Tenemos un flujo de trabajo asíncrono y documentado. Ningún desarrollador escribirá una línea de código si no existe un *ticket* oficial que lo respalde.

---

## 1. El Mandamiento de Producto: "Definition of Ready" (DoR)

Un ticket (tarea) en Jira, Linear o Trello no está "Listo para Desarrollo" si no cumple con los siguientes elementos. Si envías un ticket incompleto, los desarrolladores tienen órdenes de rechazarlo y devolverlo al *Backlog*.

### Anatomía de un Ticket Perfecto:
1. **User Story (Historia de Usuario):** "Como [rol], quiero [acción] para [beneficio]".
   * *Ejemplo:* "Como cliente VIP, quiero ver mi historial de compras para descargar mis facturas."
2. **Criterios de Aceptación (Crucial para QA):** Una lista en viñetas de las condiciones binarias (Pasa/No Pasa) que QA usará para validar la tarea.
   * *Ejemplo:* "El botón 'Descargar' debe generar un PDF. Si no hay compras, debe mostrar un estado vacío (Empty State)."
3. **Archivos Adjuntos:** Enlaces directos a **Figma** (diseño) o capturas de pantalla, si la tarea tiene impacto visual. No confíes en que el desarrollador imagine el diseño.

---

## 2. Reporte de Bugs (Defectos)

Cuando QA, un usuario o tú detectan un error en Staging o Producción, no se crea un ticket diciendo "El botón no funciona". Se debe seguir este estándar estricto:

* **Entorno:** Especificar si el error ocurre en Producción, Local o Preview.
* **Pasos para reproducir:** 
   1. Entrar a /login. 
   2. Ingresar correo válido. 
   3. Hacer clic en "Entrar".
* **Comportamiento Actual (Actual):** La pantalla se queda en blanco.
* **Comportamiento Esperado (Expected):** Debería redirigir al Dashboard.
* **Evidencia:** Obligatorio adjuntar una captura de pantalla o grabación (Loom/GIF) y los logs de la consola del navegador si es posible.

---

## 3. El Flujo de Vida de una Tarea (Kanban/Scrum)

Así es como una idea se convierte en código en nuestro ecosistema:

1. **To Do / Backlog:** El PM escribe el ticket y lo refina hasta que cumple el *Definition of Ready*.
2. **In Progress (En Progreso):** Un desarrollador toma el ticket. Crea su rama en Git (`feat/numero-de-ticket`). **REGLA DE ORO: Zero Scope Creep.** Una vez que el ticket está en esta fase, no puedes cambiarle los requerimientos. Si el cliente pidió algo nuevo, crea un ticket nuevo para el siguiente ciclo.
3. **Code Review (Revisión de Código):** El desarrollador abre un *Pull Request* (PR). Aquí es donde GitHub Actions y Husky revisan el código.
4. **QA / Testing (En Pruebas):** El código se despliega a un entorno temporal (Staging). El equipo de QA entra a la URL y prueba contra los *Criterios de Aceptación*.
5. **Done (Finalizado):** QA aprueba. El código se fusiona a `main` y se despliega a Producción automáticamente (Vercel).

---

## 4. Comunicación Asíncrona y Respeto al Foco

El ecosistema en el que trabajan nuestros desarrolladores es mentalmente demandante (Monorepo, Next.js, Tipado Estricto).

* **No interrumpas con mensajes de "¿Cómo vamos con esto?":** Todo el estado del proyecto debe vivir en el tablero de tickets. Si necesitas una actualización, lee el ticket.
* **Comentarios en el PR:** Si hay debates sobre cómo se implementó una función desde el punto de vista del negocio, coméntalo directamente en GitHub o en el ticket oficial, no en mensajes privados que se pierden.

¡Si defines bien los tickets, el código fluirá hacia producción a velocidad récord! 🏎️
