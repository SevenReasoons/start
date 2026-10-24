---
name: reasoons-audit03-backend
description: >-
  Audita código de backend, Server Actions y bases de datos Supabase contra los estándares
  oficiales (.agents/standards/04 y 09): Seguridad a nivel de fila (RLS) en 100% de tablas,
  validación Zod de payloads de entrada, contrato de error RFC 7807, traceId e Idempotency-Key.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# ⚙️ Skill: Seven Reasoons Backend & Data Layer Auditor

> **Propósito:** Auditar Server Actions, Route Handlers, APIs y esquemas de base de datos PostgreSQL en Supabase para certificar el cumplimiento estricto de [`.agents/standards/04_api_and_error_contract.md`](../standards/04_api_and_error_contract.md) y [`.agents/standards/09_backend_and_database.md`](../standards/09_backend_and_database.md).

---

## 📋 Lista de Verificación de Auditoría (Backend Gate)

### 1. 🛡️ Row Level Security (RLS) en el 100% de Tablas
- [ ] **Activación Explícita:** Toda tabla creada mediante migración SQL debe contar con `ALTER TABLE [nombre_tabla] ENABLE ROW LEVEL SECURITY;`.
- [ ] **Políticas Definidas:** Ninguna tabla con RLS activo puede quedar sin políticas `CREATE POLICY`, ya que denegaría el acceso completo de forma silenciosa.
- [ ] **Aislamiento Multitenant/Usuario:** Verificar que las políticas comparen estrictamente `auth.uid() = user_id` o `current_setting('app.current_tenant_id') = tenant_id`.

### 2. 🛡️ Barrera Zod en Runtime
- [ ] Toda Server Action o Route Handler debe validar el cuerpo (`request.json()`) y los parámetros (`params`/`searchParams`) contra un esquema Zod antes de ejecutar lógica de negocio o queries a DB.
- [ ] Cero uso de `any` en tipado de payloads entrantes o respuestas.

### 3. 📡 Contrato de Comunicación y Errores (RFC 7807)
- [ ] Las respuestas de error deben implementar el formato estándar de Problem Details:
  ```json
  {
    "type": "https://api.holding.com/errors/invalid-input",
    "title": "Datos de entrada invalidos",
    "status": 422,
    "detail": "El campo 'email' no tiene un formato valido",
    "instance": "/api/v1/leads",
    "traceId": "trace-uuid-v4"
  }
  ```
- [ ] Todo error devuelto debe propagar el `traceId` para trazabilidad inmediata en logs.

### 4. 🔁 Idempotencia en Mutaciones Críticas
- [ ] Endpoints o Server Actions que procesen cobros, pagos, transferencias o creación de órdenes deben requerir la cabecera `Idempotency-Key`.
- [ ] Si se detecta una petición duplicada con la misma clave en su ventana de expiración, el backend debe retornar la respuesta previa cacheada sin re-ejecutar cobros ni transacciones.

### 5. 🗄️ Control de Esquema por Migraciones en Git
- [ ] Todo cambio en la estructura de base de datos debe residir en archivos numerados bajo `supabase/migrations/[timestamp]_[descripcion].sql`.
- [ ] Prohibido depender de cambios manuales o no versionados realizados directamente en el dashboard web de Supabase.

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] BACKEND & DATA QUALITY REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Calificación: [0-100] / 100

 🟢 Cumplimientos:
   - [Item aprobado]

 🔴 No Conformidades Críticas:
   - [Archivo:Línea] -> Violación detectada -> Solución requerida

 💡 Recomendaciones de Refactorización:
   - [Sugerencia de optimización]
========================================================
```
