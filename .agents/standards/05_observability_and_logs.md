---
trigger: always_on
---

# 🔭 05. Observabilidad, Logging Estructurado y Monitorización de Salud

> **Propósito:** Garantizar visibilidad total del comportamiento de la aplicación en producción. Establecer el formato estándar de logs en JSON, erradicar `console.log` informal y definir los endpoints de comprobación de salud (*Health Checks*) para orquestadores y balanceadores.

---

## 1. La Ley Suprema: Cero `console.log` en Producción

**Queda estrictamente prohibido usar `console.log()` en código destinado a producción.**

`console.log()` no tiene nivel de severidad, no incluye timestamp ISO, no permite filtrado estructurado en Datadog/CloudWatch/Grafana y degrada el rendimiento de Node.js por I/O bloqueante.

Todo log debe generarse a través de un servicio logger unificado (ej. Pino, Winston o wrapper estructurado `lib/logger.ts`).

---

## 2. Formato Estándar de Log Estructurado (JSON)

Cada línea emitida hacia `stdout` o `stderr` debe ser un objeto JSON parseable con esta estructura canónica:

```json
{
  "timestamp": "2026-10-24T00:48:30.123Z",
  "level": "INFO",
  "message": "Sesión de usuario iniciada correctamente",
  "traceId": "req_84f93a11-5b72",
  "context": {
    "module": "auth",
    "action": "login_nip_verify",
    "userId": "usr_9812",
    "tenantId": "tnt_corp_01"
  },
  "durationMs": 42
}
```

### Niveles Canónicos de Severidad:
* **`DEBUG`:** Información detallada para depuración en desarrollo local (ej. parámetros de consulta interna). Desactivado en producción.
* **`INFO`:** Eventos normales y significativos del ciclo de vida (ej. arranque de servidor, orden de compra completada, webhook recibido).
* **`WARN`:** Situaciones anormales pero recuperables (ej. reintento de conexión a API externa, payload casi al límite de tamaño).
* **`ERROR`:** Fallos en la ejecución de una petición (ej. error de validación de base de datos, transacción rechazada). Requiere stack trace e identificación de usuario.
* **`FATAL`:** Errores catastróficos que detienen o desestabilizan el proceso (ej. falta de conexión con la base de datos principal al arrancar).

---

## 3. Rastreo Distribuido con `traceId` (Correlation ID)

Cada petición HTTP entrante debe asociarse a un `traceId` único:
1. Si el cliente envía la cabecera `x-trace-id` o `x-request-id`, el servidor la propaga.
2. Si no viene provista, el middleware genera un UUIDv4 nuevo.
3. El `traceId` se inyecta en:
   - Todas las líneas de log generadas durante la petición.
   - Las cabeceras de respuesta (`X-Trace-Id`).
   - El payload del error (ver regla 03).
   - El contexto enviado a herramientas de monitoreo (Sentry / OpenTelemetry).

---

## 4. Endpoints de Comprobación de Salud (Health Checks)

Toda API o backend debe exponer obligatoriamente los endpoints de salud bajo `/api/health`:

### A. Liveness Probe (`/api/health/liveness`)
* **Propósito:** Responder inmediatamente si el proceso de Node.js está vivo y escuchando peticiones.
* **Respuesta:** `200 OK` con `{ "status": "alive" }`.
* Usado por Kubernetes/Docker/AWS para reiniciar el contenedor si el hilo de eventos colapsa.

### B. Readiness Probe (`/api/health/readiness`)
* **Propósito:** Comprobar si la aplicación está lista para recibir tráfico real validando sus dependencias críticas.
* **Comprobaciones Obligatorias:**
  1. Conexión activa a la base de datos (`SELECT 1;`).
  2. Conexión a Redis / Caché (si aplica).
* **Respuestas:**
  - `200 OK`: Todas las dependencias responden en < 500 ms:
    ```json
    {
      "status": "ready",
      "services": {
        "database": "healthy",
        "cache": "healthy"
      },
      "uptimeSeconds": 1420
    }
    ```
  - `503 Service Unavailable`: Si alguna dependencia crítica falla, el balanceador de carga deja de enviar tráfico a esta instancia.
