---
trigger: always_on
---

# ⚙️ 09. Backend, Capa de Datos y Persistencia Relacional

> **Propósito:** Definir la arquitectura de la capa de datos, tipado estricto extremo a extremo, control de versiones del esquema mediante migraciones en Git, seguridad a nivel de fila (RLS/RBAC) y estándares de paginación.

---

## 1. El Paradigma de Tipado Estricto de Datos

En este ecosistema, la base de datos es la única fuente de verdad y TypeScript es la ley:

1. **Tipos Autogenerados:**
   - Queda prohibido escribir interfaces manuales para tablas o vistas de la base de datos.
   - Los tipos deben autogenerarse directamente desde el esquema oficial:
     ```bash
     npm run update-types
     ```
2. **Cero Tolerancia a `any`:**
   - Si una columna puede ser nula (`null`), el tipo de TypeScript debe reflejar `string | null`. Forzar el tipo con `!` o `as string` está terminantemente prohibido.

---

## 2. Migraciones Estrictas en Git (Cero Clics en Producción)

1. **Inmutabilidad del Esquema:**
   - **Queda estrictamente prohibido alterar tablas, vistas o funciones desde dashboards gráficos en entornos de Staging o Producción.**
   - Toda mutación de estructura se realiza mediante archivos de migración SQL numerados secuencialmente y versionados en el repositorio:
     ```text
     supabase/migrations/20261024000100_create_users_table.sql
     ```
2. **Reversibilidad y Determinismo:**
   - Las migraciones deben ser idempotentes (`CREATE TABLE IF NOT EXISTS`, `ADD COLUMN IF NOT EXISTS`).

---

## 3. Seguridad de Datos: RLS (Row Level Security) y RBAC

Ningún usuario o cliente debe poder consultar o mutar datos ajenos:

1. **RLS Habilitado por Defecto:**
   - Toda tabla que contenga información de usuarios, pedidos o inquilinos DEBE tener Row Level Security activado:
     ```sql
     ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
     ```
2. **Políticas de Aislamiento:**
   - La lectura y escritura debe verificar criptográficamente la identidad de la sesión activa (`auth.uid() = user_id`) o la membresía a la organización (`auth.uid() IN (SELECT user_id FROM tenant_members ...)`).
3. **Defensa en Profundidad (TypeScript):**
   - Aunque la base de datos tenga RLS, los Server Actions y controladores deben validar la pertenencia antes de consultar, evitando solicitudes inútiles a la base de datos.

---

## 4. Transacciones Atómicas y Funciones Almacenadas (RPC)

Cuando una operación involucre múltiples cambios dependientes (ej. debitar saldo y generar una factura):
* **Prohibido** hacer múltiples `await db.table.insert()` sueltos en el código de backend. Si el segundo paso falla, los datos quedan corruptos.
* **Obligatorio:** Utilizar transacciones atómicas (`db.transaction()`) o Funciones Almacenadas de PostgreSQL (`RPC`) con bloqueos de fila selectivos (`SELECT ... FOR UPDATE`), garantizando que la operación se complete en su totalidad o se revierta (*Rollback*) limpiamente.

---

## 5. Estándares de Paginación

Para optimizar el uso de memoria y la velocidad de respuesta, toda consulta de listas debe paginarse siguiendo esta regla:

### A. Paginación por Cursor (Cursor-Based)
* **Cuándo usar:** Feeds en tiempo real, listas de chat, notificaciones o desplazamiento infinito (*Infinite Scroll*).
* **Parámetros:** `cursor` (último ID o timestamp) y `limit`.
* **Ventaja:** Cero duplicados o saltos de registros si se insertan nuevos datos concurrentes mientras el usuario navega.

### B. Paginación por Desplazamiento (Offset-Based)
* **Cuándo usar:** Tablas administrativas densas, catálogos con números de página visibles (ej. `1, 2, 3...`) o reportes exportables.
* **Parámetros:** `page` y `pageSize` (máximo permitido: 100 registros por solicitud).

---

## 6. Persistencia Multi-idioma (i18n) y Servicios API-First

1. **Modelado de Datos Bilingües (ES / EN):**
   - Para entidades con textos dinámicos gestionados por usuarios o administradores (ej. catálogo de productos, categorías, artículos):
   - Utilizar columnas de tipo `JSONB` estructuradas con las llaves de idioma mínimas obligatorias:
     ```sql
     ALTER TABLE products ADD COLUMN title JSONB NOT NULL DEFAULT '{"es": "", "en": ""}'::jsonb;
     ALTER TABLE products ADD COLUMN description JSONB NOT NULL DEFAULT '{"es": "", "en": ""}'::jsonb;
     ```
   - Esquema Zod de validación para campos localizados:
     ```typescript
     export const localizedStringSchema = z.object({
       es: z.string().min(1, "El texto en español es obligatorio"),
       en: z.string().min(1, "English text is required"),
     });
     ```
2. **Preferencia de Idioma del Usuario:**
   - La tabla de perfiles de usuario debe almacenar la preferencia de idioma del usuario (`preferred_locale VARCHAR(5) DEFAULT 'es' CHECK (preferred_locale IN ('es', 'en'))`), permitiendo al backend enviar correos, notificaciones push o SMS en el idioma correcto del destinatario.
3. **Capa de Servicios Desacoplada (API-First Core):**
   - Ninguna regla de negocio vive en la capa visual. Toda lógica reside en servicios de dominio (`src/services/` o Server Actions en `app/actions/`) que reciben DTOs validados con Zod y retornan tipos inmutables, reutilizables transversalmente por la Web, apps móviles y APIs públicas.

