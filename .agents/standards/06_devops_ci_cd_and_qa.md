---
trigger: always_on
---

# 🚀 06. DevOps, Pipelines CI/CD y Calidad de Pruebas (QA Gate)

> **Propósito:** Definir los tres entornos de ejecución, el pipeline automatizado de integración y entrega continua (CI/CD), la pirámide de pruebas obligatoria y el protocolo de reversión inmediata (*Rollback*) ante incidentes.

---

## 1. La Ley Suprema: Cero Despliegues Manuales

**Nadie, bajo ninguna circunstancia, despliega a Producción desde una terminal local.**
Todo despliegue de código o base de datos debe ser el resultado estricto de un pipeline automatizado de integración y entrega continua que haya superado todos los controles de calidad.

---

## 2. Los Tres Entornos Obligatorios (Environments)

1. **Entorno Local (Development):**
   - Máquina del desarrollador. Ejecuta `npm run dev` conectándose a contenedores locales o base de datos de pruebas (Staging).
2. **Entorno de Vista Previa (Staging / Preview):**
   - Se crea automáticamente por cada Pull Request (PR) abierto en GitHub.
   - Genera una URL de previsualización aislada (ej. `pr-142.app-preview.com`) para que QA, Producto y Diseño prueben el cambio en vivo antes del merge.
3. **Entorno de Producción (Production):**
   - La rama protegida `main`. Solo recibe código mediante PRs aprobados y que hayan completado el pipeline verde.

---

## 3. Pipeline de CI/CD (GitHub Actions)

Cada Pull Request hacia `main` ejecuta obligatoriamente en paralelo:

```text
Pull Request hacia main
        │
        ├── 1. Linting & Formatting   (Prettier + ESLint)
        ├── 2. Type-Checking          (tsc --noEmit)
        ├── 3. Pruebas Unitarias      (Vitest)
        ├── 4. Pruebas E2E Críticas   (Playwright)
        └── 5. Compilación / Build    (turbo run build)
        │
        └── ¿Fallo en algún paso? ──► [Bloqueo Físico del Merge en GitHub]
```

---

## 4. Pirámide de Pruebas y Atributos `data-testid` Obligatorios

No se prueba manualmente; se automatiza:

1. **Pruebas Unitarias (Vitest):**
   - Co-ubicadas junto al archivo que prueban (`archivo.test.ts`).
   - Validan esquemas Zod, funciones matemáticas y transformadores puros.
2. **Pruebas E2E (Playwright):**
   - Viven en `e2e/*.spec.ts`.
   - Simulan flujos críticos completos (Onboarding, Login, Wizards, Checkout).
3. **Atributo `data-testid` Obligatorio:**
   - Para evitar que los cambios de CSS o traducciones rompan las pruebas E2E, todo botón de acción, input o modal interactivo DEBE tener un `data-testid`:
   - ✅ **Correcto:** `<button data-testid="wizard-next-step-btn">Siguiente</button>`
   - ❌ **Prohibido:** `page.locator('button.bg-blue-600')`

---

## 5. Migraciones de Base de Datos sin Caídas (Zero-Downtime)

Las migraciones de esquema deben seguir el principio de **Cambios Hacia Adelante Compatibles**:
1. **Paso 1 (Expandir):** Añadir la nueva columna como opcional o crear la nueva tabla. Desplegar el código que escribe en ambas.
2. **Paso 2 (Migrar datos):** Script de migración en background para llenar registros históricos.
3. **Paso 3 (Contraer):** Desplegar el código que solo lee de la nueva estructura y, en una migración posterior, eliminar la columna vieja.
* **Nunca** renombrar o borrar columnas en uso activo sin este ciclo de 3 pasos.

---

## 6. Protocolo de Rollback en Menos de 5 Segundos

Si una versión introdujo una regresión crítica en producción:
1. **Reversión Instantánea de Hosting:**
   - En el panel de hosting (Vercel / AWS / Cloudflare), apuntar el alias de producción al despliegue anterior (*Instant Rollback* en < 5 segundos).
2. **Reversión en Git:**
   - Ejecutar `git revert [hash-del-commit-defectuoso]` y abrir el PR correctivo. Nunca forzar la rama `main` con `git reset --hard`.

---

## 7. Definition of Done (DoD)

Un ticket de desarrollo solo se considera terminado cuando:
- [ ] El código cuenta con tipos estrictos (cero `any`).
- [ ] Las entradas están blindadas con esquemas Zod.
- [ ] Pasa pruebas unitarias de Vitest y E2E de Playwright.
- [ ] Elementos interactivos cuentan con `data-testid`.
- [ ] No introduce fugas de memoria ni llamadas `console.log`.
- [ ] El PR cuenta con la aprobación de al menos un revisor.
