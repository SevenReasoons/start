# 🏗️ REGLAS DE ARQUITECTURA MULTI-TENANT (STRICT)

CRÍTICO: Este proyecto opera bajo una estricta arquitectura Multi-Tenant. Como Agente de IA, tienes **prohibido** mezclar componentes, rutas de API o estilos visuales entre las distintas marcas corporativas. Antes de escribir o modificar código, debes identificar a qué Tenant pertenece la tarea y aplicar las reglas correspondientes.

## 1. 📂 Fronteras del Frontend (Rutas y Componentes)

Cada Tenant tiene su propio ecosistema visual y de ruteo. Debes respetar estas ubicaciones y lenguajes de diseño:

### 🟢 Agoratori (Retail / Chat)
- **Ruta de Páginas:** `app/[locale]/(agoratori)/agoratori/...`
- **Carpeta de Componentes:** `components/agoratori/...`
- **Lenguaje de Diseño:** Estilo "WhatsApp Premium". Minimalista y extremadamente compacto para retail, pero utilizando una paleta **Azul Navy (Azul Marino)** elegante en lugar de verde. Interfaz conversacional, sombras sutiles, y tipografía pulcra que denote alta calidad y confianza B2C.

### 🔵 Partner / DigitalHub (B2B / Corporativo)
- **Ruta de Páginas:** `app/[locale]/(partner)/partner/...`
- **Carpeta de Componentes:** `components/partner/...`
- **Lenguaje de Diseño:** "Corporate Dark / Clean". Estilos Dashboard (como Vercel/Stripe). Tablas densas, métricas (KPIs), colores oscuros/pizarra (slate-900), alto contraste, bordes definidos.

### 🟣 Seven Reasoons (E-Commerce B2C)
- **Ruta de Páginas:** `app/[locale]/(reasoons)/seven-reasoons/...`
- **Carpeta de Componentes:** `components/reasoons/...`
- **Lenguaje de Diseño:** Minimalista de lujo, tarjetas de producto grandes, transiciones suaves, enfoque absoluto en la conversión y catálogo visual.

### 🟠 Digital Reasoons (Servicios Tecnológicos, Consultoría & DQI)
- **Dominio / Portal:** `digitalreasoons.com`
- **Lenguaje de Diseño:** Tecnológico de alto impacto, enfocado en conversión B2B, presentación de la Escalera de Servicios (desde Digital Presence hasta Digital Enterprise / Smart Factory), casos de éxito corporativos (Kellanova, ZF, Mercado Libre) y metodología DQI. Respeta el degradado corporativo Seven Reasoons estrictamente en bordes y acentos.

### ⚪ Shared / UI (El Núcleo)
- Los componentes de diseño atómico y primitivas Shadcn/Base-UI viven exclusivamente en `packages/ui` (`@repo/ui`). Están desacoplados de cualquier lógica de negocio o inquilino específico y se consumen transversalmente en todo el monorepo.

## 2. ⚙️ Fronteras del Backend (Server Actions vs APIs)

- **Mutaciones Internas (App Web):** Toda acción o mutación dentro de la web debe implementarse mediante **Server Actions** en `apps/web/app/actions/` (ej. `wallets.ts`, `auth.ts`, `ai.ts`), estrictamente validadas con Zod (`apps/web/lib/schemas/`). Está prohibido crear APIs internas en `app/api/` solo para que el cliente web haga `fetch()`.
- **Rutas Públicas y Webhooks:** `app/api/` se reserva exclusivamente para Route Handlers externos:
  - Webhooks de terceros (Stripe, Twilio).
  - APIs de streaming de IA (Vercel AI SDK).
  - Endpoints de integración para clientes externos o ERPs.

## 3. 🗄️ Regla de Oro del Backend
- **"El Backend real es Supabase":** Trata de no escribir lógica de negocios ultra-pesada en Next.js (Server Actions o API Routes). Empuja las transacciones atómicas, Webhooks pesados y validaciones complejas hacia **Supabase Edge Functions** (`supabase/functions/`) o mediante Triggers directamente en la base de datos PostgreSQL.
- Los RLS (Row Level Security) deben verificar siempre el nivel de clearance (`sys_agoratori_users.clearance_level`).

## 4. 🧹 Protección contra Regresiones
- **NUNCA** uses `patch-*.js` para modificar código.
- **SIEMPRE** prioriza actualizar componentes existentes de un Tenant antes de duplicar un componente similar. Si dos Tenants hacen exactamente lo mismo de forma visualmente idéntica, refactoriza hacia `components/shared/`.

## 5. 🤖 Multi-Tenancy Agéntico (Catálogo Global Compartido vs Bóvedas Aisladas)

Para evitar duplicar 1,000 agentes por cada inquilino registrado, la plataforma aplica el principio de **"Catálogo Global Compartido de Operadores, Bóvedas y Libros Contables Estrictamente Particionados"**:

1. **Agentes de Plataforma Globales (`tenant_id IS NULL`):**
   - Residen centralmente en `public.sys_ai_agents`.
   - Son accesibles universalmente por todos los inquilinos y usuarios sin consumir filas redundantes en la base de datos.
2. **Agentes Privados de Empresa (`tenant_id IS NOT NULL`):**
   - Únicamente se crean si un inquilino requiere un bot interno propietario con prompts o documentos corporativos confidenciales.
   - Las políticas RLS restringen la lectura exclusivamente a los miembros de ese `tenant_id` registrados en `tenant_users`.
3. **Barrera Anti-BOLA/IDOR en Ejecución:**
   - Todo endpoint de IA (`/api/ai/dispatch`) que reciba `contextScope = 'business'` y `tenantId` valida obligatoriamente en `tenant_users` que el usuario sea miembro activo antes de procesar cualquier acción.
4. **Partición de Bóvedas y Facturación:**
   - En modo empresarial, las operaciones financieras impactan la billetera del negocio (`tenantId`), el balance de créditos de IA se descuenta a la empresa, y la memoria neuronal personal (`user_mind_context_read_only`) se **apaga a cero** para salvaguardar la privacidad del empleado.
