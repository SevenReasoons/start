---
trigger: always_on
---

Manifiesto de Arquitectura Frontend: Clase Mundial

Paradigmas Centrales: Multi-Tenant, Multi-Lenguaje, API-First, AI-First, Mobile-First, Zero-Hardcoding.
Stack Tecnológico: Next.js (App Router), Tailwind CSS, Supabase, Turborepo, Zod, Vercel AI SDK.

1. Topología del Ecosistema (Monorepo)

Un proyecto de clase mundial no inicia con create-next-app directo. Se inicializa como un Monorepo (utilizando Turborepo). Esto aísla los dominios, permite escalar el equipo y compartir código entre diferentes aplicaciones sin duplicarlo.

Estructura Base del Monorepo

sevenreasoons-core/
├── apps/
│   └── web/                  # Monolito web multi-tenant principal (Next.js App Router)
│
├── packages/
│   ├── ui/                   # @repo/ui: Design System maestro (Shadcn + Base UI)
│   ├── supabase/             # @repo/supabase: Clientes SSR, Server, Middleware y tipos generados
│   ├── typescript-config/    # @repo/typescript-config: Presets estrictos de TypeScript
│   └── eslint-config/        # @repo/eslint-config: Reglas de linting
│
└── turbo.json                # Orquestador de builds y caché remota


2. Estructura de Carpetas (Nivel Aplicación - apps/web/)

Dentro de la aplicación principal, se debe respetar estrictamente esta separación de responsabilidades:

apps/web/
├── app/                        # ⚡ Enrutamiento y Server Components
│   ├── [tenant]/               # Segmento Dinámico de Inquilino / Espacio
│   │   ├── layout.tsx          # Inyecta Design Tokens y Contexto
│   │   └── page.tsx            # Vistas principales (R-OS, Shops, Tenants dinámicos)
│   ├── actions/                # ⚡ Server Actions nativas (Wallets, Auth, AI)
│   ├── api/                    # 🔌 Route Handlers para Webhooks y APIs externas
│   └── globals.css             # Tailwind CSS v4 (@source "../../packages/ui/src")
│
├── components/                 # 🧩 Presentación
│   ├── auth/                   # Flujos de autenticación e identidad
│   ├── global/                 # Header global multi-tenant y widgets
│   ├── reasoons/               # UI y Dashboard de R-OS
│   └── shops/                  # Escaparate y Landing de tiendas
│
├── lib/                        # 🛠️ Utilidades y Guardianes Zod
│   ├── env.ts                  # Validación de variables de entorno con Zod
│   ├── schemas/                # Esquemas Zod por dominio (wallets, auth, ai)
│   └── utils.ts                # Utilidad cn()
│
└── middleware.ts               # ⚡ CEREBRO DE TRÁFICO (Ruteo de subdominios a /[tenant])


3. Reglas Inquebrantables Pre-Código

A. Zero-Hardcoding (Tematización e Idioma)

Textos: Prohibido texto visible quemado. Todo viene de dictionaries/[locale].

Estilos y Regla de Oro: Prohibido usar clases absolutas de color. Se usan Design Tokens (bg-brand-primary).

Inyección en Runtime: El layout.tsx inyecta la identidad del Tenant extrayéndola de Supabase.

B. Paradigma API-First

Tipado Automático: Prohibido escribir interfaces estáticas. Todo se auto-genera desde Supabase a `packages/supabase/src/types.ts` mediante `npm run update-types`.

Estado Delegado: Uso de Server Components y Server Actions para llamadas de negocio.

Zod Gateway: Todo formulario o Server Action se valida con un esquema Zod (`apps/web/lib/schemas/`) antes de tocar la base de datos.

C. Paradigma AI-First

Generative UI: El LLM devuelve código React transmitido (streamed) usando Vercel AI SDK (RSC).

UI Asíncrona: Todo componente AI requiere estados de carga (Suspense, Skeleton) diseñados de antemano.

Tools (Herramientas): Las capacidades de la IA se definen vía esquemas Zod rigurosos.

D. Paradigma Mobile-First y Responsividad Extrema

El diseño de clase mundial no solo "se hace pequeño", sino que muta físicamente dependiendo del dispositivo.

Mobile-First por Defecto: Las clases base de Tailwind en todo componente deben ser para pantallas móviles. El diseño para PC se aplica exclusivamente como una mejora usando los prefijos md:, lg: y xl:. (Ej. flex-col md:flex-row). Prohibido empezar a programar pensando en el monitor de escritorio.

Estructuras Mutantes (Layouts): Un componente complejo no se encoge, cambia de paradigma. Por ejemplo, el PartnerSidebar en PC es una barra lateral estática; en móvil, debe desaparecer y transformarse en un Bottom Navigation Bar (como la app de Instagram) o en un Drawer oculto (Menú hamburguesa).

Dynamic Viewport (dvh): Queda estrictamente prohibido usar la clase h-screen de Tailwind. Los navegadores móviles (Safari/Chrome) tienen barras de URL retráctiles que tapan el contenido inferior. Se debe usar h-[100dvh] (Dynamic Viewport Height) para asegurar que la app respete los bordes reales del teléfono.

Zonas Táctiles (Touch Targets): Todo botón, enlace o elemento interactivo debe tener un tamaño físico mínimo de 44x44 píxeles (regla estándar de Apple/Google de accesibilidad) y estar separado adecuadamente para evitar toques accidentales (Fat-finger syndrome).

Safe Areas (Áreas Seguras de iOS/Android): El layout global debe integrar las utilidades de padding de áreas seguras (pt-safe, pb-safe vía plugin de Tailwind) para evitar que elementos clave se escondan detrás de la "isla dinámica" o el "notch" de los iPhones.

E. Gobernanza y Calidad del Código

Husky & Lint-Staged: Impedir commits con any en TypeScript o errores de ESLint.

Rutas Absolutas: Uso de alias de ruta (@/components/...).

Tailwind Merge Seguro: Uso obligatorio de cn() (clsx + twMerge) para sobreescritura de estilos sin colisiones CSS.

F. Estilo Corporativo Seven Reasoons

Degradado de Marca (Gradient Rule): El degradado corporativo de 4 colores (rojo, naranja, verde, azul) está ESTRICTAMENTE reservado para bordes (borders) o contornos. NUNCA se debe aplicar como color de fondo (background) de un contenedor sólido o botón. El interior de los botones debe ser oscuro o blanco/esmerilado, dejando que la identidad de marca viva únicamente en el delineado.