---
trigger: always_on
---

# 🏢 11. Motor Multi-Tenant, Enrutamiento Dinámico y Marca Blanca

> **Propósito:** Definir la arquitectura para soportar múltiples marcas, inquilinos u organizaciones sobre una única base de código fuente sin duplicar componentes ni filtrar datos entre clientes.

---

## 1. El Cerebro de Tráfico: `middleware.ts` y Enrutamiento Dinámico

Todo el tráfico entrante a la aplicación es interceptado por el middleware central de Next.js, el cual analiza el subdominio o la ruta y reescribe la petición internamente hacia el segmento dinámico:

```text
Petición Entrante:
cliente-a.tuapp.com/es/dashboard  ──►  apps/web/app/[locale]/[tenant]/dashboard/page.tsx
cliente-b.tuapp.com/en/dashboard  ──►  apps/web/app/[locale]/[tenant]/dashboard/page.tsx
```

### Reglas de Enrutamiento y Composición con i18n:
1. **Composición `[locale]/[tenant]`:**
   - La estructura de carpetas en Next.js App Router combina el idioma y el inquilino en la ruta dinámica: `apps/web/app/[locale]/[tenant]/...`.
   - El middleware extrae primero el `tenant` (desde el subdominio o header) y el `locale` (desde la URL, cookie o `Accept-Language`), inyectando ambos parámetros de forma limpia en el contexto de la solicitud.
2. **Dominio Principal / Raíz:**
   - Si no se detecta ningún subdominio de cliente, el middleware enruta al portal corporativo principal en el idioma correspondiente (`/[locale]/...`).
3. **Validación de Inquilino:**
   - Si el subdominio solicitado no existe o está inactivo en la base de datos, se redirige inmediatamente a una pantalla localizada de error `404 - Organización no encontrada / Organization Not Found`.

---

## 2. Inyección Dinámica de Marca (Design Tokens en Runtime)

El Frontend no sabe de qué color debe pintarse una tienda o dashboard; esa información la provee el backend:

1. **Configuración en Base de Datos:**
   - La tabla de inquilinos (`tenants` u `organizations`) contiene una columna estructurada `branding_config` (JSONB) con sus tokens visuales:
     ```json
     {
       "colors": {
         "primary": "#3B82F6",
         "primaryForeground": "#FFFFFF",
         "accent": "#F59E0B"
       },
       "logoUrl": "https://assets.tuapp.com/tenants/cliente-a/logo.png",
       "fontFamily": "Inter"
     }
     ```
2. **Inyección en Variables CSS:**
   - El layout raíz del tenant inyecta estos valores directamente en el bloque `:root` o mediante un provider de estilos, asegurando que utilidades como `bg-primary` adopten la paleta del inquilino sin recompilar el código.

---

## 3. Barrera de Seguridad Anti-BOLA / IDOR en Ejecución

1. **Validación de Membresía Forzada:**
   - En cualquier petición que involucre un `tenant_id`, el backend verifica en la tabla intermedia `tenant_members` que el usuario autenticado pertenezca activamente a esa organización y cuente con los roles necesarios.
2. **Aislamiento en Consultas:**
   - Toda consulta SQL o filtro de ORM debe incluir obligatoriamente la cláusula `WHERE tenant_id = :sessionTenantId`.

---

## 4. Prevención de Duplicidad de Componentes

* **Prohibido** crear copias de un componente solo para cambiar un botón o título de cliente (ej. `ButtonClienteA.tsx` y `ButtonClienteB.tsx`).
* **Obligatorio:** Utilizar composición mediante `@repo/ui` y variantes dinámicas basadas en los Design Tokens del inquilino.
