---
trigger: always_on
---

# Regla de Ubicación de Proyectos y Prohibición de OneDrive

1. **Ubicaciones Autorizadas de Trabajo**:
   - **Proyecto Digital Reasoons:** `c:\Users\jaime\Desktop\digitalreasoons.com` (Portal, Landing, Brochure y Ecosistema de Servicios Digital Reasoons).
   - **Monorepo Central (Seven Reasoons Core):** `c:\Users\jaime\Desktop\Agoratori.com\sevenreasoons-core` (Monorepo multi-tenant, apps, packages, docs y scripts).

2. **Prohibición Absoluta de OneDrive**:
   - **ESTRICTAMENTE PROHIBIDO** tocar, respaldar, mover, leer o hacer sincronizaciones con cualquier ruta que contenga `OneDrive`.
   - OneDrive fue desinstalado por el usuario; dichas rutas están obsoletas y causan corrupción de datos o conflictos de sincronización.
   - Todas las rutas y dependencias deben residir únicamente en el almacenamiento local dentro de las carpetas de proyecto autorizadas en el Escritorio (`Desktop`).

3. **Ámbito de Ejecución**:
   - Toda tarea, comando de terminal, servidor de desarrollo y edición de archivos debe ejecutarse exclusivamente dentro de la carpeta correspondiente al proyecto activo (`digitalreasoons.com` o `sevenreasoons-core`), respetando su jerarquía y reglas de arquitectura.
