---
trigger: always_on
---

# 🚀 SOP DevOps & CI/CD: Manual de Operaciones y Despliegue

Este documento está dirigido a los ingenieros de **DevOps, Tech Leads y cualquier desarrollador** que necesite entender cómo el código viaja desde su computadora hasta las pantallas de nuestros usuarios.

En Agoratori tenemos una regla absoluta: **Nadie, bajo ninguna circunstancia, despliega a producción desde su terminal local.** Todo se hace a través de pipelines automatizados.

---

## 1. Los Tres Entornos (Environments)

Mantenemos una separación estricta para garantizar que los errores nunca lleguen al cliente final.

1. **Entorno Local (Development):** Tu máquina. Usas `npm run dev` y te conectas a tu instancia local de Supabase (o a la base de datos compartida de Staging, según tu rol).
2. **Entorno Staging (Preview):** Cada vez que abres un Pull Request (PR) en GitHub, **Vercel** crea un clon exacto de la aplicación con tus cambios y te genera una URL temporal (ej. `feat-login-agoratori.vercel.app`). Esto permite a QA probar el código en vivo *antes* de aprobarlo.
3. **Entorno de Producción (Production):** La rama `main`. Solo recibe código ultra-revisado. Despliega al dominio oficial.

---

## 2. El Pipeline de CI/CD (GitHub Actions + Vercel)

Nuestro ciclo de integración y despliegue continuo funciona sin intervención humana.

### Fase 1: Integración Continua (CI) - El Interrogatorio
Cuando creas un Pull Request hacia `main`, GitHub Actions despierta y ejecuta:
* **Linting:** Verifica que no haya advertencias de ESLint ni de formato (Prettier).
* **Type-Checking:** Compila TypeScript para asegurar que no hay `any` ni errores de tipado.
* **Pruebas (QA):** Ejecuta Vitest (Unitarias) y Playwright (E2E).
> 🛑 *Si alguno de estos pasos falla, el botón de Merge se pinta de rojo y queda bloqueado físicamente.*

### Fase 2: Despliegue Continuo (CD) - El Lanzamiento
Una vez que otro desarrollador aprueba tu PR y haces Merge a `main`:
1. Vercel detecta el cambio en la rama `main`.
2. Turborepo utiliza su **caché remota** para no recompilar archivos que no cambiaron, reduciendo el tiempo de despliegue de minutos a segundos.
3. El nuevo código se lanza a Producción de forma ininterrumpida (Zero-Downtime).

---

## 3. Gobernanza de Base de Datos en CI/CD

El código Frontend/Backend se despliega fácil, pero *los datos son sagrados*.

**¿Cómo se aplican los cambios a la Base de Datos?**
1. **Nunca manualmente:** Tienes prohibido usar comandos como `supabase db push` apuntando a Producción.
2. **Pipeline de Supabase:** En GitHub Actions tenemos configurada la acción oficial de Supabase.
3. Cuando tu PR se fusiona a `main`, el pipeline lee la carpeta `supabase/migrations/` e inyecta los nuevos comandos SQL directamente a la base de datos de producción antes de que el servidor de Vercel termine de compilar.
4. Esto garantiza que cuando el nuevo código (que espera nuevas tablas) esté en línea, la base de datos ya estará lista para recibirlo.

---

## 4. Protocolo de Emergencia (Rollbacks)

Si un error crítico (*Bug de Severidad 1*) logra burlar todos nuestros escudos y llega a Producción:

1. **NO intentes hacer un Hotfix (parche rápido) directo en la rama `main`.**
2. **Reversión Instantánea:** Ve al panel de control de Vercel. Busca el despliegue anterior (que funcionaba bien), haz clic en los 3 puntos y selecciona **"Promote to Production" (Rollback)**.
3. En menos de 2 segundos, la plataforma volverá a la versión estable anterior.
4. Una vez a salvo, crea una rama de tipo `fix/`, desarrolla la solución con calma, agrega una prueba de QA para que no vuelva a pasar, y pásalo por el proceso normal de PR.

La automatización es tu escudo. ¡Confía en el pipeline! 🛡️
