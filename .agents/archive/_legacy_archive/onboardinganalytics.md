---
trigger: always_on
---

# 📈 SOP Telemetría & Analytics: Manual de Rastreabilidad

Este documento está dirigido a todos los desarrolladores que implementen eventos de seguimiento (Tracking / Telemetry) para que los equipos de Producto y Growth puedan tomar decisiones basadas en datos reales.

En una arquitectura Multi-Tenant, la basura en los datos destruye la capacidad de medir a los inquilinos. 

---

## 1. Nomenclatura Estricta de Eventos (Snake Case)

Los nombres de los eventos de analítica deben ser universales e inmutables. 
Usamos la convención **`objeto_accion`** (Object-Action) todo en `snake_case`.

* ✅ `user_signed_up`
* ✅ `checkout_completed`
* ✅ `tenant_created`
* ❌ `UsuarioEntro` (Prohibido camelCase o PascalCase)
* ❌ `click_btn_comprar` (Prohibido nombres ligados a la UI física)

---

## 2. Metadatos Obligatorios (El Contexto Multi-Tenant)

Cualquier evento que se dispare desde el Frontend o el Backend **debe** llevar un Payload (cuerpo de datos) que incluya el contexto de quién hizo la acción y en qué negocio.

Todos los eventos deben incluir obligatoriamente estos 3 campos de metadatos:
1. `tenant_id`: El ID del negocio/inquilino donde ocurrió el evento.
2. `user_id`: El ID del usuario que hizo clic (o "anonymous" si no tiene sesión).
3. `timestamp`: La fecha y hora UTC exacta.

*Si el Payload de tu evento de telemetría no incluye un `tenant_id`, fallará la revisión de código (PR).*

---

## 3. Rendimiento y No-Bloqueo

Disparar eventos de analítica (hacia Mixpanel, Google Analytics, o nuestra propia BD de telemetría) **jamás debe ralentizar la aplicación**.

* **Asincronía "Fire and Forget":** Las funciones de tracking deben dispararse en segundo plano. Nunca uses un `await` para esperar a que Mixpanel responda antes de redirigir a un usuario a otra página.
* **Aislamiento:** La lógica de telemetría no debe mezclarse con la lógica de negocio crítica. Si el proveedor de analítica se cae (timeout), el usuario aún debe poder realizar su compra.
