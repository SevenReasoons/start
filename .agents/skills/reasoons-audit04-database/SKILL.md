---
name: reasoons-audit04-database
description: >-
  Audita esquemas relacionales PostgreSQL en Supabase contra los estándares (.agents/standards/09):
  Índices B-Tree en llaves foráneas, paginación basada en cursor sin OFFSET lento, integridad
  referencial, restricciones CHECK de montos financieros no negativos y tipos de datos estrictos.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🗄️ Skill: Seven Reasoons Database & PostgreSQL Auditor

> **Propósito:** Auditar esquemas, migraciones SQL e índices relacionales en Supabase PostgreSQL bajo [`.agents/standards/09_backend_and_database.md`](../standards/09_backend_and_database.md) para garantizar escalabilidad, rendimiento en lecturas y consistencia transaccional.

---

## 📋 Lista de Verificación de Auditoría (Database Gate)

### 1. ⚡ Índices B-Tree en Llaves Foráneas
- [ ] PostgreSQL **no indexa automáticamente las llaves foráneas (`FOREIGN KEY`)**. Toda columna que contenga una referencia a otra tabla (ej. `user_id UUID REFERENCES auth.users(id)`) debe contar con un índice explícito:
  ```sql
  CREATE INDEX IF NOT EXISTS idx_orders_user_id ON public.orders(user_id);
  ```
- [ ] Columnas de búsqueda frecuente o filtrado en tiempo real deben contar con índices compuestos acordes al orden de las consultas.

### 2. ⏱️ Paginación por Cursor (Erradicación de `OFFSET`)
- [ ] Prohibido el uso de `OFFSET` en tablas que puedan superar los 1,000 registros, ya que fuerza al motor a escanear y descartar miles de filas en disco.
- [ ] Las consultas paginadas deben utilizar cursores basados en timestamps o IDs secuenciales:
  ```sql
  SELECT * FROM public.messages WHERE created_at < :cursor_timestamp ORDER BY created_at DESC LIMIT 20;
  ```

### 3. 🛡️ Integridad Referencial y Restricciones `CHECK`
- [ ] Toda relación entre tablas debe declarar explícitamente su comportamiento ante eliminación (`ON DELETE CASCADE` para hijos dependientes o `ON DELETE SET NULL` para datos históricos).
- [ ] **Montos Monetarios y Saldos:** Prohibido el uso de `FLOAT` o `REAL` para dinero. Debe utilizarse siempre `NUMERIC(15,2)` acompañado de una restricción `CHECK`:
  ```sql
  balance NUMERIC(15,2) DEFAULT 0.00 CHECK (balance >= 0),
  amount NUMERIC(15,2) NOT NULL CHECK (amount > 0)
  ```

### 4. 🔠 Tipos de Datos y Marcas Temporales
- [ ] **Llaves Primarias:** Uso obligatorio de `UUID` con `DEFAULT gen_random_uuid()` o `BIGINT GENERATED ALWAYS AS IDENTITY`.
- [ ] **Fechas y Horas:** Uso mandatorio de `TIMESTAMPTZ` (con zona horaria UTC). Prohibido el tipo `TIMESTAMP` sin zona horaria.

---

## 📊 Formato de Salida del Reporte de Auditoría

```text
========================================================
 [REASOONS AUDIT] DATABASE & POSTGRESQL REPORT
========================================================
 Archivo(s) Auditado(s): [Ruta]
 Calificación: [0-100] / 100

 🟢 Esquemas e Índices Correctos:
   - [Punto aprobado]

 🔴 Riesgos de Concurrencia o Índices Faltantes:
   - [Archivo:Línea] -> Deficiencia detectada -> Script SQL de corrección

 💡 Sugerencia de Optimización de Consultas:
   - [Recomendación]
========================================================
```
