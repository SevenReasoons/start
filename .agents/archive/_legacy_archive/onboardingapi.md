---
trigger: always_on
---

# 🔌 SOP API & Integraciones: Manual de Endpoints

Este documento está dirigido a los **Backend y Fullstack Developers** encargados de exponer datos al exterior, crear webhooks o conectar servicios de terceros.

En Next.js (App Router), la forma en que el frontend interno se comunica con el backend ha cambiado, pero las reglas para el mundo exterior siguen siendo estrictas.

---

## 1. Regla de Oro: ¿Server Action o API Route?

Antes de crear un Endpoint, debes preguntarte **quién** va a consumirlo:

* **Para uso interno (Nuestra App Web):** **PROHIBIDO** crear endpoints en `app/api/...`. Si nuestra propia interfaz web necesita guardar un formulario o leer datos, usa **Server Actions** o llamadas directas a Supabase (RSC). Son más rápidas y seguras.
* **Para uso externo (APIs Públicas, Webhooks, Mobile Apps):** Usa **Route Handlers** (`app/api/route.ts`). Aquí es donde expones la plataforma a otros sistemas (ej. cuando Stripe nos avisa de un pago, o cuando un Inquilino quiere conectar su propio ERP).

---

## 2. Autenticación y Autorización (Máquina a Máquina)

Las APIs públicas no tienen navegador, por lo tanto, **no hay cookies de sesión**.

1. **Tokens de API:** Toda petición a un endpoint de la plataforma (ej. `/api/v1/orders`) debe incluir un Header `Authorization: Bearer <API_KEY>`.
2. **Resolución del Tenant (Multi-Tenant):** Esa `API_KEY` debe estar vinculada en la base de datos a un `tenant_id` específico. 
3. **Aislamiento Cero Confianza:** Cuando el backend valida el Token, inyecta el `tenant_id` en el contexto. **NUNCA** aceptes el `tenant_id` si viene en el cuerpo (body) del JSON (sería una vulnerabilidad grave donde un cliente podría escribir en la base de datos de otro).

---

## 3. Versionamiento Obligatorio (v1, v2)

Una vez que un cliente externo integra nuestra API, **no podemos romperla**.
* Todos los Endpoints públicos deben vivir bajo carpetas de versión: `app/api/v1/nombre-del-recurso/route.ts`.
* Si las reglas de negocio o los esquemas cambian de forma que rompan la compatibilidad (Breaking Change), no modificas la `v1`, creas la `v2`.

---

## 4. Estructura de Respuesta Estándar

Nuestra API nunca debe sorprender al consumidor. Todas las respuestas deben seguir este formato de envoltura (Wrapper), independientemente del recurso:

**✅ Respuesta Exitosa (200 OK / 201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "123",
    "status": "active"
  },
  "error": null,
  "meta": {
    "timestamp": "2026-10-07T16:00:00Z"
  }
}
```

**❌ Respuesta con Error (400 / 401 / 404 / 500):**
```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "El correo es inválido",
    "details": ["email must contain @"]
  }
}
```

---

## 5. Zod: El Guardián de la Puerta (Rate Limiting)

Al igual que en el resto de la aplicación:
1. Ningún cuerpo de petición (JSON `req.json()`) pasa a la base de datos sin antes ser validado por los esquemas Zod en `apps/web/lib/schemas/`.
2. **Rate Limiting (Protección DDoS):** Todos los endpoints públicos **deben** estar envueltos en un *Rate Limiter* (ej. Redis / Vercel KV) para limitar la cantidad de peticiones por segundo que un mismo Token o IP puede realizar. Proteger los recursos de Supabase es tu responsabilidad.

---

## 6. Paginación Obligatoria

Nunca, bajo ninguna circunstancia, un endpoint `GET` que devuelva listas debe retornar un array infinito (ej. `SELECT * FROM orders`). 

* Todos los endpoints de listas deben implementar **Paginación** (idealmente basada en Cursores, o alternativamente Offset/Limit) limitando la respuesta a un máximo estricto (ej. 100 registros por página). 
* Los metadatos de la paginación (`next_cursor`, `total_pages`) deben incluirse en el objeto `meta` de la respuesta estándar.

---

## 7. Idempotencia (Operaciones Seguras)

Para endpoints que ejecutan mutaciones críticas (como procesar pagos, crear inventario o webhooks de Stripe), es obligatorio soportar **Llaves de Idempotencia** (`Idempotency-Key` en los Headers).

* Si un cliente de la API sufre un fallo de red y envía la misma petición de "Crear Orden" dos veces en menos de un segundo, el backend debe detectar que la llave de idempotencia es la misma y devolver el resultado guardado de la primera transacción, **no crear un duplicado en la base de datos**.
