---
trigger: always_on
---

# ⚙️ SOP Backend & Data: Manual de Especialización

Este documento profundiza en la arquitectura de datos, validaciones y conexión con Supabase en el ecosistema Agoratori. Eres el arquitecto de la lógica; tu código debe ser irrompible.

---

## 1. El Paradigma API-First y Tipado Estricto

En este monorepo, **TypeScript es la ley**. El frontend no debe adivinar qué forma tienen los datos que recibe de Supabase.

Nuestra estructura de datos se maneja de forma limpia y desacoplada:
* 🗄️ **`packages/supabase/` (`@repo/supabase`)**: Paquete modular que encapsula clientes SSR (`client`, `server`, `middleware`) y los tipos autogenerados (`src/types.ts`).
* 🛡️ **`apps/web/lib/schemas/` & `apps/web/lib/env.ts`**: Esquemas de validación con Zod para endpoints, server actions y variables de entorno.

---

## 2. Ciclo de Vida de un Cambio en la Base de Datos (Migraciones)

Prohibido hacer cambios estructurales directo en la interfaz gráfica (UI) de producción. Todo cambio debe rastrearse en Git.

1. **Crea la Migración:** Usa el CLI de Supabase localmente (`supabase migration new nombre_del_cambio`).
2. **Escribe el SQL:** Define tus nuevas tablas, columnas o políticas RLS en el archivo generado en `supabase/migrations/`.
3. **Regenera los Tipos:** Ejecuta el comando de generación:
   ```bash
   cd packages/supabase && npm run update-types
   ```
4. **Exportación Inmediata:** Se actualiza `packages/supabase/src/types.ts`. Inmediatamente, todo el monorepo hereda el nuevo tipado exacto.
5. **No uses `any`:** Si intentas engañar al compilador usando `any`, Husky y el linter te bloquearán el commit. **Debes mapear tus interfaces correctamente.**

---

## 3. Barrera de Fuego: Zod y Server Actions

Supabase tiene RLS, pero no queremos depender únicamente de la base de datos para rechazar datos basura. Usamos Zod en las **Server Actions** (`apps/web/app/actions/`) para validar todo antes de tocar la base de datos.

**Boilerplate Estándar para una Server Action Segura:**
```typescript
"use server";
import { createClient } from "@repo/supabase/server"; // Cliente SSR seguro del paquete desacoplado
import { miEsquemaZod } from "@/lib/schemas/mi-dominio"; // Esquema centralizado de Zod

export async function crearRegistro(formData: FormData) {
  // 1. Instanciar cliente seguro (Lee las cookies del usuario automáticamente)
  const supabase = await createClient();

  // 2. Extraer y Validar con Zod
  const rawData = Object.fromEntries(formData.entries());
  const validData = miEsquemaZod.safeParse(rawData);

  if (!validData.success) {
    return { error: "Datos inválidos", details: validData.error.flatten() };
  }

  // 3. Inserción con Tipado Estricto
  const { data, error } = await supabase
    .from("mi_tabla")
    .insert([validData.data])
    .select();

  if (error) return { error: error.message };
  return { success: true, data };
}
```

---

## 4. Multi-Tenant en la Base de Datos (RLS)

Agoratori soporta cientos de inquilinos. **La privacidad de los datos es crítica.**

* Cada tabla que pertenezca a un cliente (ej. `orders`, `products`) debe tener una columna obligatoria `tenant_id`.
* Debes garantizar que las políticas **Row Level Security (RLS)** en Postgres fuercen que el usuario autenticado solo pueda hacer `SELECT`, `UPDATE` o `DELETE` sobre filas que coincidan con su contexto de inquilino.
* Nunca confíes en el ID del tenant enviado por el cliente en el body de una petición; siempre extráelo del token JWT seguro de Supabase (`auth.uid()` o una función de base de datos personalizada).

---

## 5. Inyección Dinámica (El Rol del Backend)

El Frontend no sabe cómo pintarse de rojo o cómo llamarse "Seven Reasoons". Esa es tu responsabilidad.

* En la tabla `tenants`, existe la columna `landing_config` (JSON).
* Tu trabajo es asegurar que el esquema Zod para ese JSON esté perfectamente tipado, validando que campos críticos como `design_tokens` existan.
* Cualquier nueva funcionalidad o módulo configurable que el negocio pida, debe reflejarse primero en la estructura JSON del backend, antes de que el frontend intente leerla.

---

## 6. Autodocumentación Continua (La Regla del Código Hablador)

La documentación de las tablas no vive en un archivo de Word externo, vive inyectada en el código para que los desarrolladores y la IA la consuman en tiempo real.

1. **En PostgreSQL (`COMMENT ON`):** Toda tabla o columna crítica que crees en una migración DEBE llevar un comentario oficial. Al regenerar los tipos, Supabase convertirá estos comentarios en JSDoc.
   * ✅ `COMMENT ON COLUMN public.orders.total IS 'Monto en centavos para evitar errores decimales.';`
   * *Impacto:* El desarrollador Frontend verá este mensaje flotando en VS Code al pasar el ratón por encima de `order.total`.
2. **En Zod (`.describe`):** Todos los esquemas complejos en `apps/web/lib/schemas/` deben usar la función de descripción. Esto es crítico para que la Generative UI y los Copilotos entiendan los datos.
   * ✅ `tenant_id: z.string().uuid().describe("ID del inquilino dueño de la fila. Jamás debe exponerse cruzado.")`

---

## 7. Protocolo Reasoons Security & RSI (Seguridad a Nivel de Dato)

Para el manejo de credenciales de usuario, NIP, segundo celular y guardianes:
* Consulta el [SOP Seguridad: Reasoons Security & RSI](./onboardingsecurity.md).
* Los datos de respaldo (`backup_phone`, `preferred_login_method`) se sincronizan en `auth.users.user_metadata` y tablas protegidas por RLS.
* El inicio de sesión rutinario usa NIP de 7 dígitos con cero consumo de SMS.
* Los RPCs de quórum social (`get_user_guardians`) requieren al menos 3 de 4 guardianes para validar transacciones de alta custodia.

---

## 8. Soberanía Jurídica Agéntica (Ley de Agencia & RIDs) y Consumo Atómico

En Seven Reasoons, los agentes sintéticos ejecutan operaciones en nombre de personas físicas o entidades legales respetando el marco de **Ley de Agencia**:

1. **Dualidad Soberana de RIDs:**
   - **`owner_rid` (El Principal / Dueño):** Es el RID soberano de la cuenta (`sys_rid_accounts.rid` o `tenant_id`). Es inyectado por el servidor desde la sesión autenticada; el cliente o el prompt de la IA no pueden sobreescribirlo.
   - **`creator_rid` / `service_rid` (El Agente / Trabajador):** Es el UUID soberano asignado al agente en `sys_ai_agents` o `user_profiles.tori_rid`.
   - **Trazabilidad:** Cada nota, post-it o asiento contable almacena `owner_rid`, `creator_rid`, `creator_type` ('agent' | 'human') y `agent_slug`.
2. **Consumo Atómico de Créditos de IA (`consume_ai_credits_v2`):**
   - El cobro de cómputo no se realiza mediante operaciones en memoria del servidor web.
   - Se ejecuta en PostgreSQL mediante la RPC `consume_ai_credits_v2` aplicando `SELECT ... FOR UPDATE` sobre `sys_rid_asset_balances`, garantizando que jamás existan colisiones de saldo ni dobles gastos concurrentes.
3. **Core Ledger Inmutable (`asp_ledger`):**
   - Las mutaciones contables y financieras son estrictamente **Append-Only** de partida doble (Débito = Crédito). Los saldos se auditan criptográficamente mediante raíces de Merkle (`asp_merkle_roots`).

¡Tu misión es garantizar que los cimientos de la aplicación no se caigan, independientemente de qué locuras visuales haga el equipo Frontend! 🏗️
