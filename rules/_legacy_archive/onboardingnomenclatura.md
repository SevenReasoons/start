---
trigger: always_on
---

# 📝 SOP Nomenclatura: Estándares de Código (Frontend & Backend)

Este documento establece las reglas de nombrado (Naming Conventions) para todo el ecosistema de Agoratori. Un código de "Clase Mundial" debe leerse como si hubiera sido escrito por una sola persona, independientemente de si hay 1,000 ingenieros trabajando en él.

**Si no sigues estas reglas, tu Pull Request será rechazado en la revisión de código.**

---

## 1. Archivos y Carpetas (File System)

El sistema de archivos debe ser predecible en todo el Monorepo.

* **Carpetas/Directorios:** Siempre en `kebab-case` (minúsculas separadas por guiones).
  * ✅ `components/user-profile/`
  * ❌ `components/UserProfile/`
* **Componentes React (Next.js):** Siempre en `PascalCase` (mayúscula inicial).
  * ✅ `UserProfile.tsx`, `Button.tsx`
  * ❌ `userProfile.tsx`, `button.jsx`
* **Archivos de Lógica (Hooks, Utilidades, APIs):** Siempre en `camelCase`.
  * ✅ `useAuth.ts`, `formatDate.ts`, `apiClient.ts`
  * ❌ `UseAuth.ts`, `format-date.ts`

---

## 2. Base de Datos (Supabase / PostgreSQL)

La base de datos sigue el estándar estricto de SQL, que es diferente al de JavaScript.

* **Tablas y Columnas:** Siempre en `snake_case` (minúsculas separadas por guion bajo).
  * ✅ `first_name`, `created_at`, `tenant_id`
  * ❌ `firstName`, `createdAt`
* **Pluralización de Tablas:** Las tablas siempre representan colecciones, deben estar en plural (en inglés).
  * ✅ `users`, `orders`, `products`
  * ❌ `user`, `order`, `product_list`

---

## 3. TypeScript, Zod y Variables (El Puente)

Dado que la base de datos está en `snake_case` y JavaScript en `camelCase`, el tipado debe ser impecable para no causar confusión.

* **Variables y Funciones:** Siempre en `camelCase`.
  * ✅ `const userEmail = "..."`, `function getUserData() {}`
* **Variables Booleanas (Verdadero/Falso):** Siempre deben usar los prefijos `is`, `has`, `should` o `can`. Esto hace que el código se lea como una pregunta en inglés.
  * ✅ `isActive`, `hasPermission`, `shouldRender`
  * ❌ `active`, `permission`, `renderCheck`
* **Eventos en React (Handlers):** Las funciones que manejan eventos deben usar el prefijo `handle`. Las props que reciben los eventos deben usar `on`.
  * ✅ `const handleSubmit = () => {}`, `<Button onClick={handleSubmit} />`
  * ❌ `const submitData = () => {}`, `<Button action={submitData} />`
* **Constantes Globales:** Siempre en `UPPER_SNAKE_CASE`.
  * ✅ `const MAX_LOGIN_ATTEMPTS = 5;`
* **Variables de Entorno (.env):** Siempre en `UPPER_SNAKE_CASE`. Usa el prefijo `NEXT_PUBLIC_` solo si el frontend necesita acceder a ella en el navegador.
  * ✅ `SUPABASE_SERVICE_ROLE_KEY`, `NEXT_PUBLIC_SUPABASE_URL`
* **Esquemas de Zod:** Se usa `camelCase` con el sufijo `Schema`.
  * ✅ `export const userProfileSchema = z.object({...})`
* **Tipos e Interfaces (TypeScript):** Siempre en `PascalCase`. **Prohibido** usar el prefijo `I` que usan otros lenguajes como C# o Java.
  * ✅ `type UserProfile = z.infer<typeof userProfileSchema>;`
  * ❌ `interface IUserProfile {}`

---

## 4. Endpoints y Enrutamiento (URLs)

Las URLs son la cara pública de la aplicación y deben ser amigables para SEO y para los usuarios.

* **Rutas Web y API:** Siempre en `kebab-case`.
  * ✅ `agoratori.com/user-settings`, `/api/v1/create-payment`
  * ❌ `agoratori.com/userSettings`, `/api/v1/create_payment`

---

## 5. Control de Versiones (Ramas y Commits)

Nuestra gobernanza exige convenciones semánticas para Git.

* **Nombres de Ramas:** `tipo/nombre-del-ticket` (en minúsculas `kebab-case`).
  * ✅ `feat/login-multitenant` (Para nuevas funcionalidades)
  * ✅ `fix/checkout-crash` (Para resolver bugs)
  * ✅ `chore/update-dependencies` (Para mantenimiento)
* **Mensajes de Commit (Conventional Commits):** `tipo(scope opcional): mensaje imperativo`
  * ✅ `feat(auth): agrega validación de Zod al login`
  * ❌ `Update login.tsx`, `arreglando un bug`

---

### 💡 Resumen Rápido (Cheat Sheet)
* **Base de Datos:** `snake_case` (`user_id`)
* **Archivos Lógicos/Variables:** `camelCase` (`userId`)
* **Componentes/Tipos:** `PascalCase` (`UserProfile`)
* **Carpetas/Rutas/Git:** `kebab-case` (`user-profile`)
* **Constantes:** `UPPER_SNAKE_CASE` (`MAX_USERS`)
