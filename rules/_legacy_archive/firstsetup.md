---
trigger: always_on
---

# 💻 SOP de Provisión IT: Setup y Entrega de Equipos (Día 0)

Este documento está dirigido al **Departamento de IT, SysAdmins o encargados de RRHH/Operaciones** responsables de preparar las computadoras antes de entregárselas a un nuevo desarrollador.

Tenemos una infraestructura de código de **Clase Mundial** y el proceso de entrega de equipo y accesos debe estar a la misma altura. **Prohibido entregar equipos sin esta configuración previa.**

---

## 🖥️ 1. Compras y Hardware (Estándar Corporativo)

Para que el Monorepo (Turborepo + Next.js App Router) y los contenedores de base de datos compilen sin cuellos de botella, el hardware a comprar debe cumplir esta norma estricta:

* **Estándar Mac (Recomendado):** MacBook Pro M2/M3 (o superior).
* **Estándar PC:** Dell XPS, ThinkPad o similar.
* **Memoria RAM:** Mínimo Absoluto **32 GB**. (El ecosistema local de Next.js consume memoria intensivamente).
* **Almacenamiento:** Mínimo **512 GB SSD NVMe** (Velocidad de lectura crítica para caché).

**⚠️ Regla para Windows:** Si se entrega un equipo Windows, IT DEBE activar y configurar **WSL2 (Windows Subsystem for Linux) con Ubuntu** por defecto antes de entregarlo. Todo el código debe correr en el entorno Linux.

---

## 🛠️ 2. Instalación de Software Base (Pre-Provisión)

IT debe instalar el siguiente software base antes de que el desarrollador toque la máquina:

1. **Gestor de Versiones de Node (NVM):** Prohibido instalar Node.js directo. Instalar NVM y dejar activa la versión **Node v20 (LTS)**.
2. **Git:** Configurado globalmente.
3. **Docker Desktop:** Configurado para arrancar con el sistema operativo (esencial para Supabase local).
4. **Visual Studio Code (VS Code):** Pre-instalado con las siguientes extensiones obligatorias ya activas:
   * *Prettier - Code formatter*
   * *ESLint*
   * *Tailwind CSS IntelliSense*
   * *Error Lens*

---

## 🔐 3. Identidad, Accesos y Contraseñas (IAM)

La seguridad es innegociable. Así es como se orquestan los accesos de un nuevo desarrollador:

### A. Correo Corporativo y Gestor de Contraseñas
1. **Correo:** Crear cuenta `@sevenreasoons.com` (o dominio oficial). Todo acceso a terceros debe usar este correo, nunca correos personales.
2. **Bóveda de Contraseñas:** Se debe entregar una cuenta en el Gestor de Contraseñas corporativo (ej. 1Password, Bitwarden, LastPass). 
   * **REGLA DE ORO:** Está estrictamente prohibido enviar contraseñas, tokens o llaves `.env` a través de Slack, WhatsApp o correo. Todo se transfiere por la bóveda.

### B. Control de Versiones (GitHub/GitLab)
1. Enviar invitación al repositorio oficial al correo corporativo.
2. **2FA Obligatorio:** El desarrollador no puede hacer `git push` si no tiene Autenticación de Dos Factores activa en su cuenta.
3. Permisos: Rol de *Developer* (Lectura/Escritura). **Nadie tiene permisos para hacer Push a la rama `main`**; todo código pasa por un Pull Request protegido.

### C. Accesos a Base de Datos (Supabase)
Los accesos se otorgan según el rol (separación de privilegios):
* **Frontend Developers:** Solo reciben acceso al entorno de **Desarrollo (Staging)**. Se les entrega un archivo `.env.local` pre-configurado a través de la bóveda de contraseñas. Nunca tocan el panel de Supabase.
* **Backend/Data Developers:** Reciben invitación al proyecto de Supabase (Rol de Desarrollador) para poder correr migraciones, manipular el esquema en el entorno de desarrollo y utilizar el CLI de Supabase de manera autenticada.

---

## 📦 4. Entrega de Variables de Entorno (`.env`)

En el repositorio existe el archivo maestro `apps/web/.env.example` con la estructura completa de variables públicas y secretas documentadas.
Cuando el equipo se entrega:
1. El desarrollador duplica `.env.example` como `apps/web/.env.local`.
2. IT o el Tech Lead proporciona los valores reales a través de la Bóveda de Contraseñas de la empresa.
3. El módulo `apps/web/lib/env.ts` validará automáticamente en tiempo de arranque que todas las variables obligatorias existan y tengan el formato correcto.

> 🛑 **Importante:** Si un token o llave secreta se corrompe o se filtra, IT debe rotarlo inmediatamente en la consola (Supabase, Stripe, etc.) y actualizar el registro en la bóveda.

---

## ✅ 5. Checklist de Entrega Final

Antes de que IT entregue la computadora, debe firmar este checklist:

- [ ] Hardware cumple con 32GB RAM y disco NVMe.
- [ ] Windows tiene WSL2 instalado y funcionando (Si aplica).
- [ ] Node (v20) vía NVM, Git y Docker instalados.
- [ ] VS Code instalado con las 4 extensiones de gobernanza.
- [ ] Correo corporativo y Bóveda de Contraseñas entregados.
- [ ] Invitación enviada al repositorio con 2FA exigido.

Con esta máquina preparada, el desarrollador ahora debe ir a leer el [SOP de Inducción para Ingenieros (Onboarding)](./onboarding.md) para clonar el repositorio y levantar el servidor.
