---
trigger: always_on
---

# 🚀 Agoratori: SOP de Inducción para Ingenieros (Onboarding)

¡Bienvenido al equipo! Estás entrando a un sistema de **Clase Mundial** preparado para escalar a cientos de desarrolladores colaborando en paralelo.
Este documento (Standard Operating Procedure) está diseñado para explicarte la magia detrás de nuestra arquitectura y darte instrucciones claras para que puedas programar frontend y backend sin romper el ecosistema.

Lee este documento de principio a fin antes de escribir tu primera línea de código. 

> 📚 **Lecturas Adicionales y Especialización:**
> Una vez domines este documento general, asegúrate de leer tu especialidad:
> - [SOP Día 0: Setup y Hardware Requerido](./firstsetup.md)
> - [SOP Nomenclatura: Estándares de Código](./onboardingnomenclatura.md)
> - [SOP Frontend: Diseño y UI](./onboardingfrontend.md)
> - [SOP Backend: Datos y Arquitectura](./onboardingbackend.md)
> - [SOP API: Endpoints, Webhooks e Integraciones](./onboardingapi.md)
> - [SOP IoT: Conectividad Industrial y Sensores](./onboardingiot.md)
> - [SOP IA: Generative UI y Vercel AI SDK](./onboardingai.md)
> - [SOP IA Orquestador: Componentes IA y HITL](./onboardingaicomponents.md)
> - [SOP Telemetría: Analítica y Datos](./onboardinganalytics.md)
> - [SOP Seguridad: Reasoons Security & Protocolo RSI](./onboardingsecurity.md)
> - [SOP QA: Aseguramiento de Calidad y Testing](./onboardingqa.md)
> - [SOP DevOps: CI/CD y Despliegues](./onboardingdevops.md)
> - [SOP Producto: Gestión Ágil y PMs](./onboardingproduct.md)
> - [SOP Diseño: Handoff UI/UX Multi-Tenant](./onboardingdesign.md)

---

## 0. Paso 0: Tu Primer Día (Setup Local)

Antes de que intentes levantar el proyecto y ver la magia, necesitas configurar tu entorno local. Si omites esto, el proyecto simplemente explotará.

1. **Clona el repositorio:** `git clone <url-del-repo>`
2. **Instala las dependencias:** Ubícate en la raíz del proyecto y ejecuta `npm install`. Esto descargará todas las dependencias del monorepo e inicializará *Husky*.
3. **Variables de Entorno (Crítico):** Busca el archivo `.env.example` (o `.env.temp`), duplícalo y renómbralo a `.env.local` dentro de `apps/web`. Pídele a tu Tech Lead las llaves de Supabase (URL y Anon Key) para conectarte a la base de datos de desarrollo.

---

## 1. La Filosofía del Proyecto (Zero-Hardcoding)

En Agoratori no hacemos sitios web simples, construimos **Motores Escalables**. Nuestras reglas inquebrantables son:

* **Prohibido quemar textos o colores:** Nunca escribas `bg-blue-600` o quemes un título estático en un archivo `.tsx`. El marketing y el diseño se leen dinámicamente desde la base de datos (Supabase) inyectando Design Tokens en tiempo de ejecución.
* **Mobile-First por Defecto:** Siempre diseña para celular primero. El diseño de PC se aplica como un extra usando `md:` o `lg:`.
* **Reusabilidad Absoluta:** Si construyes un botón o una sección, debe poder usarse en cualquier inquilino (desde una ferretería hasta un banco corporativo) sin modificar su código interno.
* **Optimización Extrema para Hardware Modesto (Cero Espagueti):** Diseñamos para que cualquier pantalla o componente corra a 60 FPS estables y con consumo mínimo de RAM (~22MB) en tablets económicas de $50 USD (1GB de RAM). Todo componente complejo debe descomponerse en piezas atómicas con carga perezosa (`next/dynamic`), virtualización nativa CSS (`content-visibility: auto`) y cero fugas de memoria en buffers de audio y multimedia (ver `onboardingfrontend.md`).

---

## 2. Topología del Ecosistema (Turborepo)

Usamos un **Monorepo** gestionado por Turborepo. Esto nos permite mantener un monolito web desacoplado y preparado para escalar a aplicaciones móviles o dashboards administrativos futuros:

* 🧩 **`packages/ui/` (`@repo/ui`)**: Nuestro Design System centralizado (Shadcn + Base UI + Tailwind CSS v4). Contiene los componentes visuales primitivos (`packages/ui/src/components/ui/`) y utilidades (`packages/ui/src/lib/utils.ts`). Está configurado con exportaciones multiplataforma para importarse tanto de forma directa (`import { Button, Input } from "@repo/ui"`) como por submódulos (`import { Button } from "@repo/ui/Button"`).
* 🗄️ **`packages/supabase/` (`@repo/supabase`)**: Paquete desacoplado de base de datos y autenticación. Expone clientes seguros para navegador (`@repo/supabase/client`), servidor (`@repo/supabase/server`) y middleware (`@repo/supabase/middleware`), además de los tipos de TypeScript autogenerados (`src/types.ts`).
* 🛡️ **`apps/web/lib/schemas/` & `apps/web/lib/env.ts`**: Esquemas de validación Zod organizados por dominio (`wallets.ts`, `auth.ts`, `ai.ts`) y validación estricta de variables de entorno al arranque.
* ⚡ **`apps/web/app/actions/`**: Server Actions nativas para mutaciones y consultas seguras del frontend (sin exponer rutas API internas innecesarias).
* 🌐 **`apps/web/`**: El monolito web multi-tenant principal construido en Next.js (App Router).

---

## 3. El Motor Multi-Tenant (El Enrutador)

R-OS y el ecosistema Agoratori alojan múltiples marcas y espacios en un solo código fuente. Todo el tráfico es recibido y orquestado por el archivo **`apps/web/middleware.ts`**, el cual analiza el subdominio de la petición y lo reescribe internamente a la carpeta dinámica:
📁 `apps/web/app/[tenant]/page.tsx`

### Espacios y Tenants Soportados:
1. **R-OS (`reasoons.localhost:3000` / `reasoons.com`):** Espacio central del Sistema Operativo de Vida (Bóvedas, Identidad, Tori AI, Dashboard).
2. **Shops (`shops.localhost:3000` / `shops.com`):** Escaparate público y comercio electrónico multi-tienda.
3. **Tenants Dinámicos:** Cualquier otro subdominio consulta la configuración del inquilino en Supabase y renderiza su experiencia visual personalizada mediante Design Tokens.

---

## 4. Paradigma API-First y Tipado Estricto (Backend/Data)

**Todo el sistema habla un solo idioma matemático.**
1. Si creas o modificas una tabla en Supabase, sincronizas los tipos ejecutando:
   ```bash
   cd packages/supabase && npm run update-types
   ```
   Esto actualiza `packages/supabase/src/types.ts` automáticamente desde la nube vía Supabase CLI.
2. Todas las llamadas a la base de datos están estrictamente tipadas con `Database` de `@repo/supabase`. Si se renombra una columna, TypeScript lo detectará inmediatamente antes de compilar.
3. Todo formulario, Server Action o Endpoint público valida sus datos de entrada mediante los esquemas de Zod en `apps/web/lib/schemas/`.

---

## 5. CSS y Diseño Colaborativo (Tailwind Merge Seguro)

Para que cientos de desarrolladores diseñen en paralelo sin destruir las cascadas CSS, usamos una función vital: **`cn()`** (que une `clsx` y `tailwind-merge`).

**❌ Lo que NO debes hacer:**
Concatenar strings manualmente: `className={"bg-primary " + className}`

**✅ Lo que SÍ debes hacer:**
Envolver todo en `cn()`: `className={cn("bg-primary text-white", className)}`
Esto permite que, si un componente hereda un nuevo color, Tailwind Merge resuelva las colisiones matemáticamente, dejando activo únicamente el último estilo enviado.

---

## 6. Gobernanza y Barreras (Git Hooks)

No te preocupes por arruinar el código en producción; el repositorio te detendrá primero.
Tenemos instalados **Husky** y **lint-staged**. 

Cada vez que intentes hacer un `git commit`, el sistema:
1. Formateará automáticamente tus archivos `.ts/.tsx` (Prettier).
2. Revisará y corregirá errores de sintaxis (ESLint).
3. **Bloqueará el commit** si intentas inyectar tipos `any` o romper reglas de TypeScript.

---

## 7. El Flujo Universal de Desarrollo (API-First & AI-Client)

Para garantizar la estabilidad y escalabilidad, el desarrollo de cualquier nueva funcionalidad debe seguir estrictamente el siguiente flujo:

1. **Datos (Backend):** Crear tablas, RPCs y lógica pura en Supabase.
2. **Frontend UI (Aislado):** Construir tarjetas, modales y vistas en `packages/ui` o `apps/web/components/features` sin tocar la IA.
3. **APIs (Transaccionales):** Construir los endpoints oficiales (Ej. `/api/transactions`) que puentean el Frontend y la DB.
4. **Agentes de IA (Integración Final):** Conectar a la Inteligencia Artificial tratándola como un "cliente humano" que debe usar las APIs del Paso 3, sin atajos a la Base de Datos.

## 8. Instrucciones Claras por Especialidad

### 👨‍💻 Si eres Frontend Developer (Creando UI)
1. Ve a `packages/ui/src/components/ui/`.
2. Crea tu componente visual usando Tailwind y Radix/Base UI. Asegúrate de exportarlo en `packages/ui/src/index.ts`.
3. Importa `cn` internamente desde `../../lib/utils` (o `@repo/ui/lib/utils` al consumirlo).
4. Ve a `apps/web/components/features/` o tus vistas en `apps/web/app/[tenant]/` y ensámblalo importándolo directamente desde `@repo/ui`.

### 🗄️ Si eres Backend/Data Developer (Supabase & Zod)
1. Haz los cambios en la base de datos de Supabase.
2. Ejecuta `npm run update-types` en `packages/supabase/` para regenerar `packages/supabase/src/types.ts`.
3. Ve a `apps/web/lib/schemas/` y crea o actualiza los esquemas de Zod correspondientes para validar las entradas.
4. Conecta tus Server Actions en `apps/web/app/actions/` consumiendo `@repo/supabase/server` y validando estrictamente con Zod antes de mutar la base de datos.

### 🛡️ Si trabajas en Seguridad y Autenticación (Protocolo RSI)
1. Revisa obligatoriamente el [SOP Seguridad: Reasoons Security & RSI](./onboardingsecurity.md).
2. Respeta la **regla de oro del 100%**: Cualquier usuario debe poder alcanzar los 100 puntos RSI sin comprar llaves físicas. La llave física es un **Bonus Militar (+10 pts / 110 pts)**.
3. El inicio de sesión predeterminado es siempre con el **NIP de 7 dígitos**; los envíos de SMS quedan estrictamente reservados para rescate de contraseña (costo cero diario).
4. El drawer y modales de seguridad (`RightSecurityDrawer.tsx` y `SecurityLevelsModal.tsx`) utilizan estrictamente los 5 niveles con su código de color (Rojo, Naranja, Verde, Azul, Morado).

### 🚀 Ciclo de Trabajo Básico y Git Flow
1. Haz `npm run dev` en la raíz (usando Turborepo, esto levantará todas las aplicaciones).
2. Escribe tu código.
3. Haz `git add .` y `git commit -m "feat: nuevo componente"`. ¡Observa cómo Husky limpia tu código mágicamente antes de guardarlo!

### 🌿 Reglas de Git y Pull Requests
**NUNCA HAGAS PUSH DIRECTO A `main`**. El repositorio te lo impedirá de todos modos.
1. Crea una rama para tu tarea usando prefijos estándar: 
   * `feat/nombre-de-la-tarea` (para nuevas funcionalidades)
   * `fix/nombre-del-bug` (para arreglar errores)
   * `chore/actualizacion` (para tareas de mantenimiento)
2. Sube tu rama al repositorio remoto (`git push origin tu-rama`).
3. Abre un **Pull Request (PR)** y solicita la revisión de al menos un compañero antes de fusionar el código.

---

## 9. 📋 Checklist Obligatorio de Conformidad para Nuevos Desarrollos (Definition of Done)

Todo nuevo desarrollo (frontend, backend, API o agente de IA) debe superar este checklist antes de considerarse listo para producción:

### 🛡️ 1. Seguridad e Identidad Criptográfica (Zero-Trust)
- [ ] **Identidad Forzada en Servidor:** `user_id` y `owner_rid` se extraen obligatoriamente de la sesión autenticada (`supabase.auth.getUser()`). Jamás se confía en valores enviados en el body o query por el cliente.
- [ ] **Protección Anti-BOLA / IDOR:** Si la operación involucra una empresa o tenant (`tenant_id`), se verifica la membresía activa en `tenant_users`.
- [ ] **Defensa en Profundidad:** Las consultas y mutaciones filtran explícitamente por `user_id` en código TypeScript además de las políticas RLS en PostgreSQL.

### 🤖 2. IA Agéntica Jerárquica y Cero Hardcoding
- [ ] **Registro en `sys_ai_agents`:** Nuevos agentes se configuran en base de datos con `hierarchy_level` (1, 2 o 3), `parent_id`, `context_scope`, `service_rid`, `saved_minutes_per_call` y `output_schema`.
- [ ] **Catálogo Global Compartido:** Los agentes de plataforma tienen `tenant_id IS NULL`. Está **estrictamente prohibido** duplicar agentes por cada usuario o empresa.
- [ ] **Enrutamiento Dinámico SQL:** TORI y los supervisores descubren sub-agentes en tiempo real mediante `get_routable_subagents`. Prohibido crear listas duras o enums estáticos en código.
- [ ] **Acompañante Nivel 0:** El agente personal del usuario tiene acceso de **estrictamente solo lectura** a recuerdos (`<user_mind_context_read_only>`). Para mutar el sistema, delega activando `isRoutable: true`.
- [ ] **Escudo de Privacidad:** En interacciones de negocio (`context_scope === 'business'`), el contexto de R-Mind personal se desconecta automáticamente a cero.

### 🏛️ 3. Transacciones y Grado Bancario (Core Ledger)
- [ ] **Partida Doble Inmutable:** Movimientos financieros o de balance se asientan como **Append-Only** en `asp_ledger` (prohibido `UPDATE` en saldos).
- [ ] **Consumo Atómico de Créditos:** Toda invocación de IA verifica créditos con `hasSufficientAICredits` y descuenta mediante la RPC transaccional `consume_ai_credits_v2` con bloqueo de fila.
- [ ] **Trazabilidad Soberana (Ley de Agencia):** Toda mutación firma obligatoriamente `owner_rid` (dueño del activo) y `creator_rid` (agente ejecutor o usuario).

### ⚡ 4. Calidad de Código y Tipado Estricto
- [ ] **Doble Barrera Zod:** Toda entrada y salida de datos cuenta con validación estricta Zod en `apps/web/lib/schemas/`.
- [ ] **Cero Errores de Tipado:** `npm run check-types` (`turbo run check-types`) debe finalizar con código de salida 0 en los 7 paquetes del monorepo.
- [ ] **Pruebas en Hardware Modesto:** La UI debe responder con fluidez de 60 FPS sin fugas de memoria en dispositivos modestos.

---

¡Eso es todo! Estás a los mandos de un Ferrari arquitectónico de Grado Bancario. Trátalo con respeto, sigue las reglas y dominarás el ecosistema. 🏎️💨
