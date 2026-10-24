---
trigger: always_on
---

# 🏷️ 02. Convenciones de Nomenclatura, Git Flow y Gobernanza de Código

> **Propósito:** Mantener una base de código perfectamente predecible, legible y ordenada mediante convenciones de nombrado universales, control de versiones semántico y candados automáticos pre-commit.

---

## 1. La Matriz Universal de Nomenclatura

| Entorno / Elemento | Convención | Ejemplo Válido | Ejemplo Prohibido |
|---|---|---|---|
| **Carpetas y Archivos** | `kebab-case` | `user-profile.tsx`, `api-client/` | `UserProfile.tsx`, `api_client/` |
| **Componentes e Interfaces / Tipos** | `PascalCase` | `UserProfileCard`, `UserDataResponse` | `userProfileCard`, `user_data` |
| **Funciones, Hooks y Variables** | `camelCase` | `useUserData()`, `formatCurrency()` | `FormatCurrency()`, `format_currency` |
| **Constantes Globales y Enums** | `UPPER_SNAKE_CASE` | `MAX_UPLOAD_SIZE_BYTES`, `AUTH_ROLES` | `maxUploadSize`, `MaxUploadSize` |
| **Base de Datos (Tablas y Columnas)** | `snake_case` | `user_accounts`, `created_at` | `userAccounts`, `CreatedAt` |
| **Selectores de Pruebas E2E** | `kebab-case` | `data-testid="checkout-submit-btn"` | `data-testid="CheckoutBtn"` |

---

## 2. Git Flow y Estrategia de Ramas (Trunk-Based)

En proyectos modernos y ágiles no se usan ramas longevas ni ramas `develop` redundantes. Operamos bajo **Trunk-Based Development**:

1. **Rama Principal (`main`):**
   - Siempre lista para producción y protegida. Nadie hace `git push origin main` directo.
2. **Ramas de Trabajo Efímeras:**
   - Nacen de `main` y viven menos de 48 horas:
     - `feat/[identificador-o-ticket]` (Nuevas funcionalidades)
     - `fix/[identificador-o-ticket]` (Correcciones de errores)
     - `refactor/[modulo]` (Reestructuración sin cambio funcional)
     - `chore/[tarea]` (Actualización de dependencias, scripts de build)

---

## 3. Conventional Commits Obligatorios

Los mensajes de commit deben describir el impacto de forma precisa siguiendo la especificación oficial:

```text
<tipo>(<alcance opcional>): <descripción imperativa en presente>

[cuerpo explicativo opcional]
```

### Tipos Permitidos:
* **`feat:`** Una nueva característica visible para el usuario o API.
* **`fix:`** Un arreglo de un bug existente.
* **`refactor:`** Cambio de código que no arregla un bug ni añade una feature.
* **`perf:`** Mejora de rendimiento o consumo de recursos.
* **`test:`** Añadir o corregir pruebas automáticas.
* **`chore:`** Tareas rutinarias de configuración, dependencias o herramientas.
* **`docs:`** Cambios exclusivamente en documentación.

---

## 4. Candados de Calidad Pre-Commit (Husky & Lint-Staged)

El repositorio debe contar con hooks de Git configurados para que ningún desarrollador pueda confirmar código con fallos:

1. **Pre-commit:**
   - Ejecuta `lint-staged` sobre los archivos modificados:
     - Formateo con Prettier.
     - Linter con ESLint (cero errores o warnings desatendidos).
     - Validación de tipos `tsc --noEmit`.
2. **Commit-msg:**
   - Valida que el mensaje de commit cumpla estrictamente con la convención de `Conventional Commits` vía `@commitlint/cli`.
