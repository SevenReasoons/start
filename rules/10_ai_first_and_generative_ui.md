---
trigger: always_on
---

# 🤖 09. Inteligencia Artificial, Generative UI y Herramientas Agénticas

> **Propósito:** Definir los estándares para construir sistemas AI-First: Generative UI en streaming, herramientas blindadas con Zod, manejo de latencia con Suspense, cortafuegos de privacidad y fallback resiliente de modelos.

---

## 1. La Ley Suprema: Generative UI (Vercel AI SDK)

**Queda prohibido que la Inteligencia Artificial responda exclusivamente con bloques de texto plano o Markdown aburrido.**

Utilizamos el **Vercel AI SDK** con React Server Components (RSC) para hacer *Streaming* de componentes de interfaz reales y accionables:
* Si el usuario solicita: *"Muéstrame el resumen financiero del trimestre"*:
  * ❌ **Incorrecto:** Devolver un texto: *"Tus ingresos fueron $45,000 y tus egresos..."*
  * ✅ **Correcto:** Renderizar en tiempo real el componente interactivo `<FinancialSummaryChart data={quarterData} />` directamente en el chat.

---

## 2. Herramientas del Modelo (Tools) y la Barrera Zod

Para que el modelo interactúe con la base de datos o ejecute acciones en el sistema:

1. **Parámetros Validados con Zod:**
   - Toda herramienta expuesta al LLM debe tener sus argumentos definidos con un esquema Zod estricto.
2. **Cero Tolerancia a Parámetros Inventados:**
   - Si el LLM intenta alucinar un campo no existente, Zod rechaza la ejecución antes de tocar la base de datos o disparar APIs externas:

```typescript
import { tool } from "ai";
import { z } from "zod";

export const searchInventoryTool = tool({
  description: "Busca productos en el inventario por texto o categoría",
  parameters: z.object({
    query: z.string().min(1, "El término de búsqueda es obligatorio"),
    category: z.enum(["electronics", "clothing", "home"]).optional(),
    maxResults: z.number().int().min(1).max(20).default(5),
  }),
  execute: async ({ query, category, maxResults }) => {
    return await inventoryService.search({ query, category, limit: maxResults });
  },
});
```

---

## 3. Manejo de Latencia y Experiencia de Usuario (Suspense)

La generación de respuestas por LLMs puede tomar de 1 a 4 segundos. La interfaz jamás debe congelarse:
1. **Skeletons Interactivos:**
   - Mientras el modelo razona o invoca una herramienta, se renderiza inmediatamente un componente esqueleto animado (`<ChartSkeleton />`).
2. **Streaming por Chunks:**
   - Los datos deben fluir progresivamente hacia el cliente mediante streams reactivos, mejorando la percepción de velocidad.

---

## 4. Cortafuegos de Privacidad Multi-Inquilino

1. **Inyección Dinámica de Contexto:**
   - El System Prompt del agente debe inyectar exclusivamente la información correspondiente al usuario y organización en sesión (`tenant_id`).
2. **Aislamiento Neuronal:**
   - En peticiones corporativas, la memoria personal del usuario se desconecta para garantizar que datos confidenciales de una empresa no se filtren a otro inquilino ni a sesiones públicas.

---

## 5. Resiliencia de Modelos y Fallback Automático

Para evitar interrupciones de servicio si un proveedor de IA sufre caídas o saturación de cuota (Rate Limit `429`):
* Configurar un proveedor secundario o modelo de respaldo en cadena de fallback (ej. si `gemini-flash-latest` arroja error de cuota, el orquestador conmuta automáticamente a un modelo de reserva tipado).
