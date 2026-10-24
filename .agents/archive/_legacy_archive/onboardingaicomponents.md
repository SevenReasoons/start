# Onboarding: AI Components Architecture & Workflows

Este documento define la arquitectura estricta y los patrones de diseño para construir interfaces, orquestadores y APIs de Inteligencia Artificial dentro del ecosistema de Seven Reasoons. 

La filosofía principal es: **"Los Chats no son simples cajas de texto, son interfaces universales modulares (Legos) gobernadas por esquemas estrictos de validación (Guardianes Zod)."**

---

## 1. El Flujo Estándar de Desarrollo (API-First & AI-Last)

Para garantizar la estabilidad y trazabilidad del sistema, **toda nueva funcionalidad impulsada por IA debe construirse estrictamente en este orden:**

1. **Base de Datos y Lógica (DB/SQL):** Construir las tablas, las funciones RPC y la lógica transaccional pura.
2. **Frontend UI (Aislado):** Construir los componentes visuales (Tarjetas, Formularios) sin conectarlos a la IA, asegurando que pasen la auditoría de diseño puro (Reasoons Pure).
3. **APIs (Transaccionales):** Construir los endpoints oficiales (Ej. `/api/wallets/transactions`) que sirvan de puente entre el Frontend aislado y la Base de Datos.
4. **Agentes de IA (Orquestador):** Finalmente, conectar la Inteligencia Artificial para que actúe como un "usuario virtual" que llame a las APIs construidas en el paso 3.

*La IA nunca debe tener atajos directos a la Base de Datos. Debe usar las mismas APIs transaccionales que usaría la interfaz manual.*

---

## 2. Arquitectura "Tori Orchestrator" (Patrón Supervisor)

Nunca se deben crear componentes de chat aislados con lógica de negocio quemada (hardcodeada). Todo sistema conversacional debe adherirse al patrón **Supervisor Agent con Human-In-The-Loop (HITL)**.

La arquitectura se divide en 3 pasos obligatorios:

### Paso 1: El Componente Universal (`<UniversalChat />`)
- **Responsabilidad:** Renderizar los mensajes del usuario, del LLM y las interfaces dinámicas (Tarjetas de Confirmación).
- **Entradas (Props):** Debe ser agnóstico y recibir contexto. Ej: `<UniversalChat agentId="tori.finanzas" context="wallet" />`.
- **Motor:** Debe utilizar el Vercel AI SDK (`useChat` o `useUIState`) para manejar el streaming y la retención del hilo de la conversación.

### Paso 2: El Orquestador y Clasificador (API Router)
Toda entrada del usuario pasa por una única API `/api/ai/orchestrator` gobernada por *Tool Calling*.
- El Orquestador (Gemini) devuelve estrictamente **Texto + JSON**.
- **Texto:** La respuesta empática y natural hacia el usuario.
- **JSON (Tool Call):** La instrucción estructurada que define si el mensaje es solo texto (`isRoutable: false`) o si requiere ejecutar una herramienta/base de datos (`isRoutable: true`).

### Paso 3: Human-In-The-Loop (HITL) y Ejecución Limpia
- Si el Orquestador decide que se requiere una acción (ej. registrar un gasto), **nunca se ejecuta directamente en la base de datos**.
- El frontend debe renderizar una **Tarjeta de Confirmación** mostrando los datos extraídos por el LLM.
- **Ejecución:** Solo cuando el usuario da clic en "Aceptar", el cliente dispara la consulta hacia la API transaccional oficial.

---

## 3. Los 4 Pilares de la Robustez Nivel Dios (10/10)

Para garantizar que el sistema NUNCA falle, todo Agente y API de IA debe implementar los siguientes mecanismos invisibles:

### A. Trazabilidad Legal y de Auditoría (Audit Trails) ⚖️
Todo agente de IA tiene peso legal en Seven Reasoons. Cualquier movimiento transaccional (ej: mover dinero, firmar un documento) originado por una IA **debe ser registrado en los logs de auditoría como si la IA fuera un empleado.**
- **created_by:** El ID del humano que aprobó la acción (HITL).
- **agent_id:** El ID del agente de IA que propuso o procesó el movimiento (Ej. `tori.legal`).
- **api_used:** El nombre exacto de la Tool/API que el agente invocó.

### B. Lógica de Autocorrección (Self-Healing / Retry Loops) 🔄
- Si el LLM devuelve un JSON malformado o que rompe las reglas del esquema Zod, el servidor no debe arrojar un error "500" al usuario.
- El backend debe atrapar el error de validación, rebotarlo silenciosamente de vuelta al LLM con el mensaje de error de Zod, y forzar al modelo a corregirse automáticamente.

### C. Autorización Estricta (RLS & Agent RBAC) 🔐
- El Orquestador nunca debe confiar ciegamente en el nombre del agente.
- Antes de delegar una tarea a un especialista, el Orquestador debe validar el Token JWT del usuario contra la tabla `supabase_agents_schema` (usando Row Level Security) para verificar que el tenant/usuario tiene el *clearance* para hablar con dicho agente.

### D. Poda de Memoria (Context Window Trimming) 🧠
- Las conversaciones largas agotan el límite de tokens y degradan el razonamiento del LLM.
- El orquestador debe aplicar algoritmos de resumen de historial (Summarization) o búsqueda vectorial (RAG) en lugar de enviar hilos de 5,000 mensajes completos a la API en cada petición.

---

## 4. Los Guardianes Zod (Strict Typings)

El uso de **Zod** es obligatorio y no negociable en todas las capas de la IA para prevenir alucinaciones e inyecciones. Las rutas de IA deben tener esquemas que validen la Entrada, la Herramienta (Tool) y la Ejecución final.

### Ejemplo de Guardián para el Clasificador (Tool Schema)
```typescript
import { z } from 'zod';

export const aiRouterSchema = z.object({
  isRoutable: z.boolean().describe("True si el usuario quiere realizar una acción en el sistema, False si solo está platicando."),
  routeTo: z.enum(["finance_agent", "legal_agent", "support_agent", "null"]).describe("A qué especialista delegar la acción."),
  action: z.string().describe("El identificador de la acción a ejecutar, ej: 'register_expense'"),
  confidence: z.number().min(0).max(1).describe("Nivel de confianza de la clasificación."),
  extractedData: z.record(z.any()).describe("Los parámetros extraídos del mensaje del usuario (Ej: monto, concepto)."),
  toriMessage: z.string().describe("Mensaje empático que Tori le dirá al usuario.")
});
```

> *"Un chat moderno no adivina bases de datos, estructura la intención y delega a las APIs oficiales de la plataforma, siempre bajo el permiso humano explícito y dejando un rastro legal impecable."*

---

## 5. Arquitectura "Prompt-as-a-Service" (Zero-Hardcoding en IA)

Está estrictamente prohibido quemar (hardcodear) en el código de las APIs:
- El modelo de lenguaje a usar (ej: `gemini-2.5-flash`).
- La temperatura (ej: `0.3`).
- El System Prompt.
- La personalidad del Agente.

**El flujo obligatorio es:**
1. El **Frontend** descarga la lista de agentes disponibles desde la base de datos (`sys_ai_agents`).
2. Cuando el usuario selecciona un agente, el frontend extrae su perfil completo (`model`, `temperature`, `system_prompt`, `personality`).
3. El frontend envía todo este objeto `agentConfig` como parte del payload JSON hacia la API Orquestadora.
4. La **API** utiliza este payload inyectándolo directamente en el Vercel AI SDK, actuando como un simple motor ciego que obedece al 100% lo definido en la base de datos.

Este diseño garantiza que si un modelo queda obsoleto o queremos modificar el comportamiento de un agente, **solo actualizamos la base de datos de Supabase**, y el cambio se refleja instantáneamente sin tener que hacer *deploy* de nuevo código.
