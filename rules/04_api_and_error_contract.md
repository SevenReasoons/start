---
trigger: always_on
---

# 📡 03. Contrato Universal de API y Manejo de Errores

> **Propósito:** Definir el contrato de comunicación inmutable para todas las APIs, Server Actions y servicios del proyecto, eliminando respuestas arbitrarias y estandarizando el formato de éxito, error, paginación e idempotencia.

---

## 1. El Formato Estándar de Respuesta (The Unified Envelope)

Toda API, Server Action o Endpoint interno o externo DEBE devolver una respuesta estructurada bajo este sobre (*envelope*) estricto:

### A. Respuesta Exitosa (`success: true`)
```typescript
interface ApiSuccessResponse<T> {
  success: true;
  data: T;
  meta?: {
    page?: number;
    pageSize?: number;
    totalCount?: number;
    nextCursor?: string | null;
  };
}
```

*Ejemplo JSON:*
```json
{
  "success": true,
  "data": {
    "id": "usr_9812",
    "name": "Alex Morales",
    "email": "alex@empresa.com"
  }
}
```

---

### B. Respuesta de Error Unificada (`success: false`)

Inspirada en el estándar **RFC 7807**, ningún endpoint debe retornar mensajes planos como `"Error 500"` o `{ "err": "algo falló" }`. El formato oficial es:

```typescript
interface ApiErrorDetail {
  field?: string;
  message: string;
  code?: string;
}

interface ApiErrorResponse {
  success: false;
  error: {
    code: string;               // Código máquina identificador en UPPER_SNAKE_CASE (ej. INVALID_PAYLOAD)
    message: string;            // Mensaje seguro y legible para mostrar al usuario final
    details?: ApiErrorDetail[]; // Lista de errores específicos de validación (ej. issues de Zod)
    traceId: string;            // Identificador único de correlación para soporte técnico y logs
    timestamp: string;          // ISO 8601
  };
}
```

*Ejemplo JSON:*
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Los datos enviados no cumplen con los requisitos mínimos de validación.",
    "details": [
      {
        "field": "email",
        "message": "El formato de correo corporativo no es válido.",
        "code": "invalid_string"
      }
    ],
    "traceId": "req_84f93a11-5b72",
    "timestamp": "2026-10-24T00:48:00.000Z"
  }
}
```

---

## 2. Mapeo Canónico de Códigos de Estado HTTP

Todo endpoint REST debe utilizar el código HTTP semántico correspondiente:

| Código | Significado | Cuándo Aplicar |
|---|---|---|
| **`200 OK`** | Éxito estándar | Consultas (`GET`) y mutaciones con retorno (`PUT`/`PATCH`). |
| **`201 Created`** | Recurso creado | Creación de nuevas entidades (`POST`). |
| **`400 Bad Request`** | Petición malformada | Errores de sintaxis o payload no interpretable. |
| **`401 Unauthorized`** | No autenticado | Token ausente, expirado o firma inválida. |
| **`403 Forbidden`** | Sin autorización | Usuario autenticado pero sin permisos para este recurso (RBAC). |
| **`404 Not Found`** | No encontrado | El recurso solicitado no existe o fue eliminado. |
| **`409 Conflict`** | Conflicto | El recurso ya existe (ej. email duplicado o clave única en conflicto). |
| **`422 Unprocessable`** | Validación fallida | El JSON es sintácticamente válido pero falló la barrera Zod. |
| **`429 Too Many Req`** | Rate Limit | Excedido el límite de solicitudes por minuto/IP. |
| **`500 Internal Error`** | Error del servidor | Excepción no controlada. Se oculta el stack trace al cliente. |

---

## 3. Barrera de Validación Zod en Controladores

Toda entrada debe procesarse mediante `safeParse`:

```typescript
// apps/web/app/api/users/route.ts
import { NextResponse } from "next/server";
import { createUserSchema } from "@/lib/schemas/user";
import { formatZodError } from "@/lib/utils/api-errors";

export async function POST(req: Request) {
  const traceId = crypto.randomUUID();
  try {
    const rawBody = await req.json();
    const result = createUserSchema.safeParse(rawBody);

    if (!result.success) {
      return NextResponse.json(
        {
          success: false,
          error: {
            code: "VALIDATION_ERROR",
            message: "Datos de usuario inválidos.",
            details: formatZodError(result.error),
            traceId,
            timestamp: new Date().toISOString(),
          },
        },
        { status: 422 }
      );
    }

    const newUser = await userService.create(result.data);
    return NextResponse.json({ success: true, data: newUser }, { status: 201 });
  } catch (error) {
    // Log interno estructurado con traceId (ver regla 04)
    logger.error("Error no controlado al crear usuario", { error, traceId });

    return NextResponse.json(
      {
        success: false,
        error: {
          code: "INTERNAL_SERVER_ERROR",
          message: "Ocurrió un error inesperado al procesar la solicitud.",
          traceId,
          timestamp: new Date().toISOString(),
        },
      },
      { status: 500 }
    );
  }
}
```

---

## 4. Idempotencia en Operaciones Críticas

Para endpoints que involucren cargos monetarios, creación de órdenes o transacciones sensibles:
1. El cliente debe enviar una cabecera: `Idempotency-Key: [UUIDv4]`.
2. El servidor almacena la clave en caché (Redis o DB) durante 24 horas.
3. Si la petición se reintenta por desconexión de red, el servidor devuelve la respuesta idéntica previamente guardada sin duplicar la mutación.

---

## 5. Negociación de Idioma en la API (i18n Bilingüe Nativo)

Toda API debe soportar internacionalización nativa mediante cabeceras estándar HTTP:

1. **Cabecera `Accept-Language`:**
   - La API inspecciona la cabecera `Accept-Language: es` o `Accept-Language: en` (con fallback por defecto a `es` o al locale configurado en el proyecto).
2. **Localización Dual del Error:**
   - **`error.code` (Para el Cliente):** Permanece como un identificador canónico en `UPPER_SNAKE_CASE` (ej. `USER_NOT_FOUND`). El cliente web/móvil lo utiliza como clave en sus diccionarios de traducción (`t("errors." + error.code)`).
   - **`error.message` (Para Consumidores Directos):** La API devuelve el mensaje formateado en el idioma solicitado (`"Usuario no encontrado"` o `"User not found"`), garantizando que clientes que no posean diccionarios locales (ej. Postman, cURL, scripts CLI) reciban feedback legible en su idioma.

---

## 6. Principio API-First: Desacoplamiento de Clientes

1. **La Web es un Cliente Más:**
   - Queda estrictamente prohibido crear lógica de negocio acoplada a componentes de React, Server Actions opacos o páginas web.
   - Todo servicio debe ser consumible por:
     - La aplicación web (Next.js / Vite / Remix).
     - Aplicaciones móviles nativas (React Native / iOS / Android).
     - Agentes de Inteligencia Artificial (mediante tools de API).
     - Webhooks e integraciones B2B externas.
2. **Documentación Viva del Contrato:**
   - Los contratos de datos deben estar tipados de punta a punta con Zod y ser exportables a especificación **OpenAPI 3.1** o clientes SDK tipados automáticamente.

