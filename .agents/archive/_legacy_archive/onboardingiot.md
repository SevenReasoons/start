---
trigger: always_on
---

# 🏭 SOP IoT & Connectivity-First: Integración de Hardware y Sensores

Este documento está dirigido a los **Data Engineers, Backend Developers e Ingenieros de IoT** encargados de conectar nuestra plataforma con el mundo físico (Sector Industrial, PLCs, Sensores, Dispositivos Edge).

Agoratori es **Connectivity-First**. Sin embargo, la física de la recolección de datos industriales requiere un cuidado extremo para no colapsar la base de datos principal.

---

## 1. La Ley del Tráfico: Next.js NO es para IoT

Los sensores industriales y PLCs suelen enviar datos en alta frecuencia (ej. 10 a 100 veces por segundo).
* **Regla Estricta:** ESTÁ ESTRICTAMENTE PROHIBIDO apuntar un sensor, PLC o microcontrolador de alta frecuencia hacia un endpoint de Next.js (`app/api/...`).
* **¿Por qué?** Next.js (Serverless) no está diseñado para mantener conexiones abiertas persistentes (WebSockets prolongados o MQTT) ni para recibir ráfagas masivas sostenidas. Las funciones Serverless morirán por *Timeout* y destruirán el presupuesto de Vercel.

---

## 2. La Capa de Ingestión (Ingestion Layer)

Para recibir datos industriales, usamos una **Capa de Ingestión** especializada (Broker MQTT, WebSockets en Edge Functions o servidores persistentes en Rust/Node.js).

* **Protocolos Aceptados:** Dependiendo del PLC, recibiremos datos vía **MQTT**, **OPC UA** (a través de un Gateway Edge), o **WebSockets**.
* **El Puente (Zod en el Edge):** Los PLCs suelen enviar datos crudos, a veces en formatos hexadecimales o JSON anidados. La Capa de Ingestión tiene la responsabilidad absoluta de limpiar, normalizar y pasar esos datos por los **Esquemas de Zod** (`apps/web/lib/schemas/`) antes de siquiera intentar enviarlos a la base de datos.

---

## 3. Batching (Agrupación de Inserciones)

Si tienes 1,000 sensores enviando 1 lectura por segundo, intentar hacer 1,000 sentencias `INSERT` por segundo en PostgreSQL quemará la CPU de la base de datos (Supabase).

* **Micro-Batching:** La Capa de Ingestión debe recolectar los datos en la memoria caché (ej. Redis o colas en memoria) durante un bloque de tiempo (ej. 5 o 10 segundos).
* **Bulk Insert:** Después de ese tiempo, debe insertar todas las lecturas de los sensores en una sola transacción masiva a Supabase (`.insert([{...}, {...}, {...}])`).

---

## 4. Separación de Datos: Time-Series vs Transaccional

El diseño de la base de datos para IoT es radicalmente diferente al de una tienda online.

1. **Datos Transaccionales:** Tablas como `users` o `tenants`. Son pequeñas, se actualizan poco y requieren integridad extrema.
2. **Datos de Series de Tiempo (Time-Series):** Tablas como `sensor_readings` o `plc_telemetry`. Son masivas (millones de filas por día) y son de solo inserción (Append-only).
   * No uses UUIDs como llaves primarias en tablas de sensores, usa un compuesto del `sensor_id` y el `timestamp` para acelerar las búsquedas por fecha.
   * *Si el volumen es extremo*, el equipo de base de datos deberá configurar extensiones específicas (como particionamiento en PostgreSQL) para que las consultas de las gráficas (ej. "Ventas o Presión en las últimas 24 hrs") sigan siendo instantáneas.

---

## 5. Autenticación de Hardware (Cero Confianza IoT)

Los sensores y PLCs no tienen usuarios ni contraseñas humanas. ¿Cómo sabemos que la lectura viene de un dispositivo real y no de un atacante?

* **Prohibido el acceso anónimo:** Todo dispositivo que envíe datos a la Capa de Ingestión debe autenticarse.
* **Tokens de Dispositivo / mTLS:** Los dispositivos deben provisionarse desde la plataforma web con un Token único de Larga Duración (asociado a un `tenant_id` y `device_id`) o utilizar certificados mTLS. Si el token es revocado en la plataforma, el dispositivo pierde el acceso inmediatamente.

---

## 6. Protección contra Sensores "Rogue" (Rate Limiting)

En el mundo físico, los sensores se rompen o entran en cortocircuito, provocando que envíen miles de lecturas basura por segundo (lo que en IoT se conoce como *Babbling Idiot*).

* **Circuit Breakers (Interruptores Automáticos):** La Capa de Ingestión debe tener un límite estricto de eventos por segundo por dispositivo.
* Si un PLC excede el límite anormalmente, el servidor Edge debe bloquear su IP o su Token temporalmente y disparar una alerta al Inquilino (`tenant_id`), en lugar de dejar que el sensor defectuoso sature la base de datos de producción.
