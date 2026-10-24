---
trigger: always_on
---

# 💻 01. Higiene del Sistema, Multiplataforma y Variables de Entorno

> **Propósito:** Blindar el entorno de desarrollo para evitar fallos por discrepancias entre sistemas operativos (Windows, Mac, Linux), impedir la corrupción de archivos por sincronización en la nube y garantizar que ninguna aplicación arranque si faltan variables de entorno obligatorias.

---

## 1. Higiene Multiplataforma Obligatoria (Día 0)

Para evitar el error número uno de los equipos de ingeniería (conflictos de saltos de línea `CRLF` vs `LF` y tabulaciones dispares), todo repositorio debe contar con:

1. **`.editorconfig` en la raíz:**
   - Define tabulaciones estándar (2 espacios) y final de línea `lf` obligatorio para todo archivo de texto.
2. **`.gitattributes` en la raíz:**
   - Fuerza `* text=auto eol=lf` para normalizar los saltos de línea al guardar en Git, evitando que commits de Windows ensucien el diff con cambios fantasma en todas las líneas.

---

## 2. Aislamiento de Hardware y Prohibición de Sincronización en la Nube

1. **Regla Anti-Cloud Sync:**
   - **Queda estrictamente prohibido clonar o ejecutar proyectos dentro de carpetas gestionadas por OneDrive, Google Drive, Dropbox o iCloud.**
   - Las sincronizaciones automáticas bloquean descriptores de archivos, corrompen la carpeta `node_modules`, saturan el uso de disco y provocan fallos aleatorios de compilación.
2. **Entorno Windows con WSL2:**
   - En máquinas con Windows, el código fuente y las herramientas de compilación deben residir dentro del sistema de archivos de **WSL2 (Ubuntu)** o en una ruta limpia de disco local (ej. `C:\dev\proyecto`).
3. **Versión de Node Unificada:**
   - Se debe utilizar la versión **LTS activa (Node.js v20+)** mediante gestores de versión (`.nvmrc` o `.node-version` en la raíz).

---

## 3. Validación de Entorno en Tiempo de Compilación (`env.ts`)

**Queda terminantemente prohibido usar `process.env.VARIABLE` directamente en el código de aplicación sin validación previa.**

Toda variable debe ser parseada y tipada en el arranque mediante un módulo central de validación con **Zod** (ej. `lib/env.ts` o `@t3-oss/env-nextjs`). Si una variable obligatoria falta o tiene un formato inválido, **la aplicación debe fallar en el segundo 0** con un mensaje claro en la consola:

### Implementación Universal de `lib/env.ts`:

```typescript
import { z } from "zod";

const envSchema = z.object({
  NODE_ENV: z.enum(["development", "test", "production"]).default("development"),
  PORT: z.coerce.number().default(3000),
  
  // Base de datos / Storage
  DATABASE_URL: z.string().url("DATABASE_URL debe ser una URL válida"),
  
  // Servicios Externos
  NEXT_PUBLIC_APP_URL: z.string().url().optional(),
  API_SECRET_KEY: z.string().min(32, "API_SECRET_KEY debe tener al menos 32 caracteres"),
  
  // Inteligencia Artificial (Si aplica)
  AI_MODEL_NAME: z.string().default("gemini-flash-latest"),
  AI_API_KEY: z.string().min(1).optional(),
});

export const env = envSchema.parse(process.env);
```

### Reglas de Gestión de Secretos:
* **`.env.example`:** Debe estar versionado en Git con todas las llaves documentadas y valores dummy.
* **`.env.local` / `.env`:** **NUNCA** se sube a Git (incluido en `.gitignore`). Se provee al desarrollador mediante un gestor seguro de contraseñas (1Password, Bitwarden, Doppler o Vault).
* **Rotación:** Si un token o credencial se expone o sospecha de filtración, debe ser revocado y rotado inmediatamente en la consola del proveedor.

---

## 4. Antigravity como IDE Oficial Obligatorio y Diagnóstico de Entorno

> **Mandato:** Todo proyecto del equipo **DEBE abrirse y desarrollarse exclusivamente en Google Antigravity IDE**. Ningún otro editor está homologado para operar el ecosistema de agentes, MCPs y gobernanza de reglas.

### 4.1. Configuración de Espacio de Trabajo (.vscode en Antigravity)
Antigravity adopta nativamente los estándares de configuración en la carpeta [`.vscode/`](../.vscode/):
1. **`.vscode/settings.json`:**
   - **Formateo Automático al Guardar:** Configurado con `esbenp.prettier-vscode` para sangría homogénea de 2 espacios.
   - **Auto-corrección ESLint:** Organiza imports y corrige errores de linting en cada guardado (`editor.codeActionsOnSave`).
   - **Saltos de Línea LF Forzados:** Elimina desajustes de Git en Windows (`files.eol: "\n"`).
   - **Soporte Multi-idioma Inline:** Configurado con `i18n-ally` apuntando a `messages/es.json` y `messages/en.json` para previsualización inmediata de cadenas traducidas.
2. **`.vscode/extensions.json`:**
   - Lista oficial de extensiones recomendadas por el equipo (Prettier, ESLint, Tailwind CSS, i18n-ally, Error Lens, Even Better TOML, GitLens).

### 4.2. Diagnóstico de Salud en Día 0 (`scripts/doctor`)
Antes de iniciar cualquier desarrollo, todo miembro del equipo debe correr el script de diagnóstico para verificar que su máquina cumple los requisitos según su rol:

- **En Windows (PowerShell):**
  ```powershell
  .\scripts\doctor.ps1
  # O especificando tu rol directamente:
  .\scripts\doctor.ps1 -Role 1  # Para Awareness (0 dependencias)
  .\scripts\doctor.ps1 -Role 2  # Para Maker
  ```
- **En Mac / Linux / WSL2 (Bash):**
  ```bash
  chmod +x ./scripts/doctor.sh
  ./scripts/doctor.sh
  # O pasando tu rol:
  ./scripts/doctor.sh 1
  ```

El script valida:
1. Detección activa de **Antigravity IDE**.
2. Aislamiento estricto de carpetas sincronizadas en la nube (anti-OneDrive/Dropbox).
3. Presencia de Node.js v20+ LTS y credenciales completas de Git.
4. Docker Desktop y demonio activo (solo si el rol requiere Supabase local).
5. Exención total (*zero-friction short circuit*) para el rol **Awareness** en prototipos de venta (<24h).

