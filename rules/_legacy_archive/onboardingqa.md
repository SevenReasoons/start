---
trigger: always_on
---

# 🧪 SOP QA & Testing: Manual de Aseguramiento de Calidad

Este documento está dirigido al equipo de **QA (Quality Assurance)** y a los Desarrolladores (Frontend/Backend) al momento de escribir pruebas para su código.

En Agoratori, operamos bajo la filosofía de que "código sin pruebas es código roto por defecto". No desplegamos a producción basándonos en fe, nos basamos en automatización.

---

## 1. La Pirámide de Pruebas

Nuestro ecosistema exige dos tipos principales de pruebas antes de que cualquier código llegue a la rama `main`.

### A. Pruebas Unitarias (Vitest)
Son pruebas ultrarrápidas para validar fragmentos de lógica aislada.
* **¿Qué se prueba?** Validaciones de Zod, utilidades, funciones matemáticas y componentes "tontos" del UI Kit.
* **Ubicación:** El archivo de prueba debe vivir exactamente al lado del archivo que está probando.
  * *Ejemplo:* Si creas `utils.ts`, tu prueba debe llamarse `utils.test.ts`.
* **Herramienta:** Usamos **Vitest** (por su integración nativa y velocidad con Vite/Turborepo).

### B. Pruebas End-to-End / E2E (Playwright)
Son pruebas pesadas que levantan un navegador real y simulan a un humano haciendo clic en la página.
* **¿Qué se prueba?** Flujos críticos de negocio: Inicio de sesión, Creación de un inquilino (Tenant), Checkout de compras, Formularios de múltiples pasos.
* **Ubicación:** Viven en una carpeta separada en `apps/web/e2e/`.
* **Herramienta:** Usamos **Playwright**.

---

## 2. Flujo de Trabajo del Ingeniero QA

Si eres un Automation Tester o QA Engineer, tu flujo es el siguiente:

1. **Lee el Ticket (Jira/Linear):** Entiende los Criterios de Aceptación.
2. **No confíes en el desarrollador:** Tu trabajo es intentar romper la aplicación. 
3. **Identificadores Únicos para Testing:**
   * **Regla de Oro:** Para que Playwright encuentre botones o inputs sin romperse si el diseño cambia, los desarrolladores Frontends **deben** agregar atributos `data-testid` a los elementos interactivos.
   * ✅ **Correcto:** `<button data-testid="submit-checkout">Pagar</button>`
   * ❌ **Incorrecto:** `page.locator('button.bg-red-500')` (El color puede cambiar, el ID de prueba no).

---

## 3. Boilerplate de Pruebas

### Ejemplo: Prueba Unitaria (Vitest) para un Esquema de Zod
```typescript
import { describe, it, expect } from 'vitest';
import { miEsquemaZod } from '@/lib/schemas/mi-dominio';

describe('Validación de Correo', () => {
  it('debería rechazar un correo sin arroba', () => {
    const result = miEsquemaZod.safeParse({ email: 'usuario.com' });
    expect(result.success).toBe(false);
  });

  it('debería aceptar un correo corporativo válido', () => {
    const result = miEsquemaZod.safeParse({ email: 'dev@sevenreasoons.com' });
    expect(result.success).toBe(true);
  });
});
```

### Ejemplo: Prueba E2E (Playwright) para el Login
```typescript
import { test, expect } from '@playwright/test';

test('El usuario puede iniciar sesión exitosamente', async ({ page }) => {
  await page.goto('/login');
  
  // Usando los data-testid acordados con el frontend
  await page.getByTestId('input-email').fill('dev@sevenreasoons.com');
  await page.getByTestId('input-password').fill('Seguridad123!');
  await page.getByTestId('btn-submit-login').click();

  // Verificar que el usuario fue redirigido al dashboard
  await expect(page).toHaveURL('/dashboard');
});
```

---

## 4. Barrera de Integración Continua (CI)

No necesitas correr todas las pruebas manualmente antes de hacer merge. Nuestro pipeline de GitHub Actions se encargará de ello.

1. Abres el Pull Request.
2. GitHub levanta un entorno virtual.
3. Se ejecutan todas las pruebas de Vitest y Playwright automáticamente.
4. **Si una sola prueba falla, el botón de Merge se desactiva físicamente.** No hay excepciones.

¡Si dominas las pruebas, dominarás la estabilidad del código! 🛡️
