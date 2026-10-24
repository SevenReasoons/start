---
trigger: always_on
---

# 🤖 SOP IA & Generative UI: Manual de Ingeniería de Inteligencia Artificial

Este documento está dirigido a los **AI Engineers y Fullstack Developers** encargados de crear Copilotos, agentes conversacionales o funciones impulsadas por Modelos de Lenguaje (LLMs) dentro de la plataforma.

Nuestra plataforma es **AI-First**, pero no construimos simples chatbots de texto. Construimos interfaces dinámicas y accionables.

---

## 1. La Ley Suprema: Generative UI (Vercel AI SDK)

Prohibido que nuestra IA responda exclusivamente con bloques de texto plano o Markdown aburridos. 
Usamos el **Vercel AI SDK** (React Server Components) para hacer *Streaming* de componentes UI reales.

* Si un usuario pide "Muéstrame mis ventas del mes", la IA no debe responder: *"Tuviste 5 ventas..."*
* La IA debe renderizar el componente `<SalesChart />` dinámicamente en el chat.

---

## 2. Tools (Herramientas del LLM) y la Barrera Zod

Para que la IA interactúe con nuestra base de datos (ej. buscar inventario, crear una cita), se le otorgan herramientas (Tools). Las alucinaciones son el mayor enemigo de la IA, por lo tanto:

1. **Tipado Estricto:** Toda herramienta que se le pase al modelo DEBE tener sus parámetros definidos usando los esquemas oficiales de Zod (`apps/web/lib/schemas/ai/`).
2. **Cero Tolerancia a `any`:** Si la IA intenta llamar a una herramienta de la base de datos inventando un parámetro, Zod lo interceptará y fallará la ejecución de forma segura.

**Boilerplate Estándar para Tools de IA:**
```typescript
import { tool } from 'ai';
import { miEsquemaZod } from '@/lib/schemas/ai/mi-herramienta';

export const getWeather = tool({
  description: 'Obtener el clima de una ciudad',
  parameters: miEsquemaZod, // Esquema importado centralizado
  execute: async ({ city, unit }) => {
    return fetchWeatherAPI(city, unit);
  },
});
```

---

## 3. Estados de Carga (Suspense) y Latencia

Los modelos de lenguaje son lentos (pueden tardar 3-5 segundos en generar el componente).
* **Regla de UX:** Es obligatorio diseñar e implementar "Skeletons" o componentes de carga (loaders) mientras la IA procesa la respuesta.
* **Prohibido bloquear el Thread:** Todas las llamadas de IA deben ser asíncronas y estar envueltas en React `<Suspense>` para no congelar la pantalla del usuario.

---

## 4. Privacidad y Multi-Tenant en Prompts

Nunca expongas los datos de un inquilino a otro.
Cuando construyas el *System Prompt* (Las instrucciones del sistema), debes inyectar programáticamente el contexto del usuario extrayendo su identidad del token JWT y buscando sus datos en Supabase.
* ✅ `"Eres el asistente virtual de la marca [Nombre de BD]. Tu misión es vender [Productos de BD]."`

---

## 5. Arquitectura Agéntica Jerárquica de 4 Niveles

En Seven Reasoons no creamos mega-prompts monstruosos que intentan hacer todo. La arquitectura se estructura en 4 niveles de especialización:

1. **Nivel 0: Acompañante Personal del Usuario (`user_profiles`)**
   - Personalizado con `tori_name`, `tori_personality` y `tori_rid`.
   - **Permiso Estricto de Solo Lectura:** Recibe recuerdos de notas (`<user_mind_context_read_only>`).
   - **Cero Mutaciones Directas:** Si el usuario solicita crear, editar o borrar algo, marca `isRoutable = true`, identifica `targetDomain` y `extractedAction`, y delega en TORI.
2. **Nivel 1: Maestro Orquestador Central (`tori`)**
   - Recibe la solicitud enrutada y consulta la función SQL `get_routable_subagents` para clasificar la intención y derivar al supervisor de dominio.
3. **Nivel 2: Sub-Agentes Supervisores de Dominio (`sys_ai_agents`)**
   - Ejemplos: `tori.notas`, `tori.finanzaspersonales`, `tori.shopping`, `tori.legal`.
   - Validan el ámbito con el **Firewall de Contexto** y seleccionan el especialista ejecutor.
4. **Nivel 3: Sub-Sub-Agentes Ejecutores Especialistas (`sys_ai_agents`)**
   - Ejemplos: `tori.notas.postit`, `tori.notas.transcripcionaudio`, `tori.notas.sintesis`, `tori.finanzaspersonales.gasto`.
   - Generan el payload estructurado forzado por su `output_schema` (`jsonSchema`) para entregarlo a la API First.

---

## 6. Catálogo Global Compartido (Stateless Blueprints)

**PROHIBIDO clonar o duplicar 1,000 agentes por cada usuario o empresa nueva.**
* Todos los agentes de Reasoons residen en `public.sys_ai_agents` con `tenant_id IS NULL`.
* Son **operadores sin estado**: solo contienen prompts, modelos, schemas Zod y minutos ahorrados.
* No guardan datos de usuarios. El aislamiento se logra en tiempo de ejecución inyectando criptográficamente el `auth_user_id` y `owner_rid` del usuario autenticado.

---

## 7. Descubrimiento Dinámico SQL (`get_routable_subagents`)

* **Cero Hardcoding en TypeScript:** Está prohibido quemar listas de agentes en enums estáticos.
* TORI y el despachador descubren qué agentes están activos y autorizados mediante la función RPC:
  ```sql
  get_routable_subagents(p_parent_id, p_context_scope, p_tenant_id)
  ```
* Esto permite añadir 50 nuevos especialistas en base de datos sin tener que re-compilar ni desplegar el frontend.

---

## 8. Firewall de Contexto y Escudo de Privacidad R-Mind

1. **Aislamiento de Ámbitos (`context_scope`):**
   - `'personal'`: Solo disponible en chat y vida personal del usuario.
   - `'business'`: Solo disponible dentro de workspaces empresariales autorizados (`tenant_users`).
   - `'public'`: Disponible en ambos (ej. `@tori.ortografia`, `@tori.legal`, `@tori.go`).
2. **Escudo de Privacidad de R-Mind:**
   - Si un usuario interactúa con un agente corporativo (`context_scope === 'business'`), el contexto de la mente personal se **apaga a cero** automáticamente para evitar filtraciones de intimidad hacia perfiles de trabajo.

---

## 9. Trazabilidad Soberana (Ley de Agencia & RIDs)

Cada acción agéntica debe firmarse con la dualidad de identidades:
* `owner_rid`: Sujeto que posee el dato o cuenta (Principal).
* `creator_rid` / `service_rid`: Agente sintético que operó la acción (Agent).

---

## 10. Medición Atómica de Créditos de IA (`aiMeter`)

* **Fórmula Oficial Agoratori:**
  $$\text{Créditos} = \frac{\text{Tokens Entrada} + \text{Tokens Salida}}{500}$$
* Se descuentan de forma atómica en PostgreSQL mediante la RPC `consume_ai_credits_v2` con bloqueo de fila (`SELECT ... FOR UPDATE`), impidiendo el doble gasto concurrente.

---

## 11. 📋 Protocolo de Creación de Nuevos Agentes (Checklist Obligatorio)

Cuando vayas a crear un nuevo agente en el sistema, debes cumplir estrictamente estos 5 pasos:

1. **Inserción en Base de Datos (`sys_ai_agents`):**
   - Asignar `id` y `username` únicos (ej. `tori.inventario.conteo`).
   - Definir `hierarchy_level` (2 para supervisor, 3 para ejecutor fino).
   - Asignar `parent_id` (ej. `tori.inventario` o `tori`).
   - Asignar `context_scope` (`'personal' | 'business' | 'public'`).
   - Definir `service_rid` (UUID soberano oficial del agente).
   - Asignar `saved_minutes_per_call` (minutos reales que ahorra al humano).
   - Definir `output_schema` (JSON Schema estricto que describe el payload que el modelo debe retornar).
   - Si es agente de plataforma, asegurar `tenant_id IS NULL`.
2. **Definición de Esquema Zod (`apps/web/lib/schemas/ai/`):**
   - Crear el esquema Zod equivalente al `output_schema` para doble validación en tiempo de ejecución.
3. **Validación de Descubrimiento SQL:**
   - Probar en SQL: `SELECT * FROM get_routable_subagents(parent_id, context_scope, tenant_id);`. El agente debe aparecer automáticamente sin tocar código de TypeScript.
4. **Conexión API-First Segura:**
   - El agente debe entregar sus datos a un servicio API transaccional, inyectando `owner_rid` (usuario o tenant) y `creator_rid` (el `service_rid` del agente).
5. **Registro de Consumo y Minutos:**
   - Llamar a `recordAIConsumption({ serviceRid, savedMinutes, ... })` para registrar los minutos ahorrados y descontar los créditos correspondientes.
