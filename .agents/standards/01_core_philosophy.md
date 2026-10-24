---
trigger: always_on
---

# 🏛️ 01. Filosofía Central y Manifiesto de Arquitectura

> **Propósito:** Definir los principios innegociables, la cultura de código y los patrones de arquitectura base para cualquier proyecto de software de nivel enterprise, independientemente de su lenguaje, stack o tamaño.

---

## 1. Los Axiomas Invariables (Core Invariable)

Todo proyecto que utilice este kit debe cumplir estrictamente estos axiomas fundacionales:

1. **API-First Radical:**
   - La interfaz de usuario (Web, Móvil o CLI) no posee privilegios especiales; es simplemente **un consumidor más de la API**.
   - Toda funcionalidad, mutación y regla de negocio debe implementarse primero como un servicio o endpoint tipado y testeable de forma independiente antes de concebir la interfaz visual.
   - Las APIs deben exponer contratos predecibles (OpenAPI / TypeRPC) que permitan a cualquier cliente (apps móviles, integraciones de terceros o scripts) operar sin requerir una interfaz web.
2. **Multi-idioma Nativo por Diseño (i18n Bilingüe Mínimo: ES / EN):**
   - **Ningún proyecto nace monolingüe.** Todo desarrollo incluye desde el Día 0 soporte nativo para **Español (`es`) e Inglés (`en`)** como estándar base, extensible a otros idiomas.
   - Queda estrictamente prohibido quemar texto visible en componentes, vistas o correos electrónicos (`<h1>Bienvenido</h1>` ❌). Todo texto proviene de diccionarios estructurados y tipados (`t('auth.welcome')` ✅).
3. **Zero-Hardcoding & Tipado Estricto (Barrera Zod):**
   - Queda prohibido quemar credenciales, IDs, URLs de entorno o estilos rígidos.
   - La base de datos y los contratos de datos son la fuente única de verdad. Cero tolerancia a `any`.
   - Todo payload entrante (peticiones HTTP, webhooks o respuestas de LLMs) debe validarse con esquemas **Zod** antes de ser procesado.
4. **Mobile-First Radical & Economía de Hardware:**
   - Toda interfaz debe diseñarse y programarse pensando primero en dispositivos móviles táctiles y procesadores modestos, garantizando 60 FPS estables y consumo mínimo de memoria RAM.
5. **Arquitectura Desacoplada e Inmutabilidad:**
   - La lógica de negocio no debe acoplarse a frameworks visuales ni detalles de bajo nivel de almacenamiento. Favorecer la inmutabilidad de datos y funciones puras sobre mutaciones de estado directas.

---

## 2. Selector de Topología del Proyecto

No todos los proyectos tienen la misma escala ni el mismo propósito. Al iniciar un repositorio, se adopta formalmente una de estas **3 Topologías Oficiales**:

### 🏢 Topología A: Enterprise Fullstack Monorepo (Turborepo)
* **Cuándo usar:** Proyectos complejos que integran múltiples aplicaciones (Web, Mobile, Admin, Docs) y comparten lógica, tipos o componentes de diseño.
* **Estructura Estándar:**
  ```text
  repo/
  ├── apps/
  │   ├── web/                  # Aplicación de usuario (Next.js / Remix / Vite)
  │   └── admin/                # Panel de control o back-office
  ├── packages/
  │   ├── ui/                   # @repo/ui: Design System desacoplado del negocio
  │   ├── database/             # @repo/database: Clientes ORM, migraciones y tipos
  │   ├── typescript-config/    # Presets de TS estrictos
  │   └── eslint-config/        # Reglas de linting compartidas
  └── turbo.json
  ```

### 📱 Topología B: Standalone App (Web / Mobile)
* **Cuándo usar:** Aplicaciones B2C, productos en etapa MVP, landings de alta conversión o aplicaciones móviles aisladas (React Native / Flutter).
* **Estructura Estándar:**
  ```text
  repo/
  ├── src/ (o app/)
  │   ├── components/           # UI atómica y componentes de feature
  │   ├── hooks/                # Lógica reactiva reutilizable
  │   ├── lib/                  # Clientes, utilidades y schemas
  │   └── services/             # Integración con APIs externas
  └── public/
  ```

### ⚙️ Topología C: Backend Service / API / Engine
* **Cuándo usar:** Microservicios, APIs REST/GraphQL, workers en segundo plano, motores de cálculo o pipelines de datos (Node / Go / Python).
* **Estructura Estándar:**
  ```text
  repo/
  ├── src/
  │   ├── domain/               # Entidades y reglas de negocio puras
  │   ├── application/          # Casos de uso y orquestación
  │   ├── infrastructure/       # Adaptadores de DB, colas, HTTP y servicios externos
  │   └── interfaces/           # Controladores, rutas y CLI
  ```

---

## 3. Regla de Oro de Dependencias y Bloqueo de Código Espagueti

* **NUNCA** coloques llamadas directas a base de datos dentro de componentes visuales tontos.
* **NUNCA** uses parches manuales (`patch-*.js`) para corregir librerías; documenta la solución o haz un fork formal.
* Si dos módulos requieren la misma función utilitaria, refactoriza inmediatamente hacia una capa compartida (`lib/utils/` o `@repo/shared`).
