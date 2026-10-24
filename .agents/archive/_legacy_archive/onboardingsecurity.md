---
trigger: always_on
---

# 🛡️ SOP Seguridad & Protocolo RSI (Reasoons Security Indicator)

> **Documento de Onboarding de Seguridad y Criptografía Soberana**  
> *Ecosistema Seven Reasoons & Agoratori — Arquitectura de Clase Mundial*

Bienvenido al pilar de seguridad de Seven Reasoons. En nuestra plataforma, la seguridad no es un formulario aburrido de "olvidé mi contraseña": es un **Protocolo de Seguridad a Nivel de Dato**, basado en **permisos progresivos, desacoplamiento de identidad y gamificación visual mediante el RSI (Reasoons Security Indicator)**.

Este documento establece las reglas arquitectónicas, fórmulas matemáticas y directrices de UI/UX que rigen la protección de cuentas y bóvedas en el monorepo.

---

## 1. La Filosofía: Seguridad Sin Fricción ni Exclusión

Históricamente, la seguridad bancaria o cripto frustra al 99% de las personas: exige llaves físicas costosas o procesos confusos que hacen que el usuario común sienta que "su cuenta nunca estará segura".

En Seven Reasoons aplicamos dos axiomas fundamentales:
1. **El 100% debe ser alcanzable por cualquier persona de forma gratuita** utilizando únicamente su teléfono móvil y herramientas nativas.
2. **La llave física de hardware (YubiKey / FIDO2) es un PLUS de Seguridad Militar (+100 pts)** reservado para el 1% de usuarios de alta custodia o corporativos, pero **nunca** un requisito para lograr el 100% de la barra.

---

## 2. Gamificación del RSI (Reasoons Security Indicator)

El indicador de seguridad de la cuenta se pondera matemáticamente en una escala de **0 a 100 puntos base (+10 pts Bonus Militar)**:

### 📊 Tabla Maestra de Distribución de Puntos (Meta: 100 pts)

$$\text{Puntaje Estándar: } 20 + 15 + 15 + 25 + 15 + 10 = \mathbf{100\text{ pts}}$$

| # | Configuración de Seguridad | Puntos | Estado / Activación | Rol Técnico y Operativo |
|---|---|:---:|:---:|---|
| 1 | **NIP Maestro (7 dígitos)** | **+20 pts** | Base Obligatoria | Clave de acceso diario. Cero costo de SMS por sesión. |
| 2 | **Línea Celular (SMS OTP)** | **+15 pts** | Celular Principal | Exclusivo para rescate y validación inicial de chip. |
| 3 | **Segundo Celular de Respaldo** | **+15 pts** | Redundancia | Inmunidad ante robo de dispositivo o pérdida de chip. |
| 4 | **Face ID / Huella (Biometría)** | **+25 pts** | Local / WebAuthn | Cifrado en hardware nativo (Secure Enclave). Inmune a miradas de hombro. |
| 5 | **App Autenticador TOTP** | **+15 pts** | Google Auth / Authy | Códigos de 30 segundos 100% fuera de la red de telefonía (anti-SIM swap). |
| 6 | **Círculo de 4 Guardianes** | **+10 pts** | Rescate Social | Quórum 3 de 4 en 60 segundos sin contraseñas ni correos hackeables. |
| **★** | **Llave Física (YubiKey / FIDO2)** | **+10 pts BONUS** | **Nivel Militar** | Token criptográfico físico. Permite superar los 100 pts (**110 pts**). |

---

## 3. Los 5 Niveles Oficiales y Código de Colores

Para evitar saturar al usuario, la plataforma clasifica el estado de la cuenta en 5 niveles visualmente distinguibles:

```
[ Nivel 1: Básico (0-50 pts) ] --------> 🔴 Rojo     | Vulnerabilidad Alta (~55%)
[ Nivel 2: Medio (51-80 pts) ] --------> 🟠 Naranja  | Vulnerabilidad Moderada (~25%)
[ Nivel 3: Óptimo (81-90 pts) ] -------> 🟢 Verde    | Vulnerabilidad Baja (~5%)
[ Nivel 4: Avanzado (91-100 pts) ] ----> 🔵 Azul     | Vulnerabilidad Mínima (<0.05%) ★ Meta Estándar
[ Nivel 5: Militar (+100 pts) ] -------> 🟣 Morado   | Vulnerabilidad Nula (<0.0001%) ★ Bonus Soberano
```

### Detalle de Niveles:
1. **Nivel 1: Básico (0 - 50 pts) — 🔴 Rojo**
   - *Puntaje típico:* 20 pts (solo NIP) o 35 pts (NIP + Celular).
   - *Protección:* Bots genéricos en internet.
   - *Riesgo:* Mirón de hombro, robo físico del teléfono, SIM Swapping.
2. **Nivel 2: Medio (51 - 80 pts) — 🟠 Naranja**
   - *Puntaje típico:* 50 a 75 pts (añadiendo Segundo Celular o Face ID).
   - *Protección:* Redundancia telefónica y acceso rápido cifrado en equipo local.
   - *Riesgo:* Intercepciones de red celular en recuperación.
3. **Nivel 3: Óptimo (81 - 90 pts) — 🟢 Verde**
   - *Puntaje típico:* 85 a 90 pts (con App Autenticador TOTP activa).
   - *Protección:* 100% inmune a hackeos telefónicos y ataques remotos masivos.
   - *Riesgo:* Pérdida del dispositivo sin círculo de rescate configurado.
4. **Nivel 4: Avanzado (91 - 100 pts) — 🔵 Azul (Estándar de Oro Seven Reasoons)**
   - *Puntaje:* 100 pts completos.
   - *Requisito:* NIP + 2 Celulares + Face ID + TOTP + 4 Guardianes.
   - *Protección:* Recuperación soberana en 60s mediante quórum social sin contraseñas. Cero puntos ciegos de phishing o extorsión.
5. **Nivel 5: Seguridad Militar (+100 pts / 110 pts) — 🟣 Morado**
   - *Puntaje:* 110 pts (100 pts estándar + 10 pts Bonus Llave Física).
   - *Requisito:* Llave de hardware física FIDO2/WebAuthn y Frase Semilla RID de 12 palabras.
   - *Protección:* Resistencia absoluta contra ataques dirigidos de nivel estatal o espionaje corporativo.

---

## 4. Arquitectura de Implementación Frontend

Los componentes que materializan esta arquitectura se encuentran en `apps/web/`:

### A. `RightSecurityDrawer.tsx` (`apps/web/components/global/RightSecurityDrawer.tsx`)
* **Ubicación:** Panel lateral deslizable a la derecha activado desde el icono de escudo en el Header.
* **Diseño:** Minimalismo blanco de lujo (*pure white luxury*), espaciado generoso y tipografía Outfit/Inter sobria.
* **Elementos Clave:**
  - **Tarjeta RSI:** Muestra `{rsiScore} / 100 pts` con badge dinámico según el nivel (Rojo, Naranja, Verde, Azul, Morado) y barra multicolor interactiva.
  - **Selector de Inicio de Sesión:** Permite al usuario elegir con qué credencial entra a la app (NIP, Face ID, TOTP o Llave Física).
  - **Pastillas de Puntos (`Pills`):** Cada método de autenticación y respaldo exhibe claramente los puntos que otorga (`+20 pts`, `+25 pts`, etc.).
  - **Respaldo y Rescate:** Gestión de segundo número celular, estado de los 4 guardianes y correo opcional.

### B. `SecurityLevelsModal.tsx` (`apps/web/components/global/SecurityLevelsModal.tsx`)
* **Ubicación:** Modal interactivo disparado por el icono de información `(ⓘ)` del RSI o los botones de vulnerabilidad.
* **Características:**
  - Pestaña 1: **5 Niveles RSI**, con bulletpoints de "De qué SÍ te protege" y "De qué NO te protege", más un CTA hacia la configuración faltante.
  - Pestaña 2: **Tabla de Reglas de Puntos**, donde se desglosan los 100 puntos y el bonus militar.

### C. `SsoManager.tsx` & `PhoneStep.tsx` (`apps/web/components/auth/`)
* **Regla de Negocio (Cero Costo de SMS Diario):** El flujo predeterminado de inicio de sesión solicita directamente el **NIP de 7 dígitos** (`LOGIN_PIN`).
* **SMS OTP como Vía de Rescate Exclusiva:** El envío de SMS sólo se dispara si el usuario pulsa *"Olvidé mi NIP / Recuperar acceso"*.

---

## 5. Reglas Inquebrantables para Ingenieros

1. **Nunca quemes valores de seguridad en duro:** Usa las constantes tipadas `RSI_LEVELS_DATA`, `POINT_RULES` y la función `getRsiTier(score)`.
2. **Preserva la accesibilidad del 100%:** Bajo ninguna circunstancia cambies la fórmula para exigir hardware físico antes de los 100 puntos. Los 100 puntos **deben** ser alcanzables vía software/smartphone.
3. **Optimización de Costos en Proveedores (Twilio/Supabase SMS):** No agregues envíos de SMS automáticos en el login diario. Todo login rutinario debe autenticarse mediante NIP, Face ID o TOTP.
4. **Desacoplamiento de Identidad:** Las llaves privadas y frases semilla RID residen en almacenamiento cifrado del cliente (E2EE); el backend nunca almacena texto plano ni secretos maestros.
5. **Validación TypeScript Estricta:** Cualquier modificación a métodos de seguridad o tiers debe validar con `npm run check-types` con 0 errores antes de hacer PR.

---

## 6. Criptografía E2EE de Alto Rendimiento y Cero Bloqueo de CPU (Estándar R-Chat)

La mensajería entre personas (`/chat`) implementa cifrado de extremo a extremo (E2EE) con estándar **AES-GCM de 256 bits** y derivación de clave **PBKDF2 (SHA-256, 100,000 iteraciones)** mediante la Web Crypto API nativa (`window.crypto.subtle`).

En dispositivos de bajo costo ($50 USD, procesadores Cortex-A53), ejecutar 100,000 iteraciones de PBKDF2 de forma concurrente puede congelar el hilo principal de JavaScript. Para evitarlo, todo código que interactúe con E2EE debe acatar estas tres directrices:

1. **Deduplicación de Promesas de Derivación (`pendingKeyPromises`):**
   Si un lote de 30 mensajes llega simultáneamente sin la clave en caché, **nunca** dispares 30 llamadas a `deriveKey` en paralelo. Usa un mapa de promesas pendientes:
   ```typescript
   const pendingKeyPromises = new Map<string, Promise<CryptoKey | null>>();
   ```
   La primera petición ejecuta la derivación matemática y las 29 restantes esperan la resolución de esa misma promesa en memoria.

2. **Derivación Única y Descifrado por Lotes:**
   Para cargar historiales o previews de conversaciones, obtén la `CryptoKey` una única vez mediante `getOrCreateConversationKey(forumId, myRid, targetRid)` y utiliza funciones de descifrado directo acelerado por hardware:
   - `decryptChatMessageWithKey(ciphertext, key)`
   - `decryptChatMessagesBatch(contents, forumId, myRid, targetRid)`
   Esto reduce el tiempo de descifrado de 35 mensajes de ~600ms a **< 2 milisegundos**.

3. **Fallback Transparente para Agentes Copilot:**
   Los canales de interacción con agentes oficiales (Tori, Tori Max, Tori Go) no aplican cifrado bilateral humano para permitir la síntesis semántica en streaming. El método `isMessageEncrypted(content)` (`enc:v1:...`) distingue transparentemente los contenidos sin generar excepciones.

---

## 7. Arquitectura de Grado Bancario y Core Ledger Inmutable (Bank-Grade Protocol)

El ecosistema Seven Reasoons & Agoratori implementa los mismos estándares de ingeniería de software que rigen en instituciones financieras de primer nivel (Core Banking Systems):

### 1. Ledger Inmutable de Partida Doble (`asp_ledger`)
* Los saldos nunca son un número arbitrario modificable mediante `UPDATE`.
* La tabla `asp_ledger` es **estrictamente Append-Only** (solo inserción).
* Toda transacción registra `entry_id`, `transaction_group_id`, `from_wallet`, `to_wallet`, `amount`, `currency` y `exchange_rate_applied`.
* Todo débito posee un crédito matemáticamente idéntico; los balances de las cuentas se derivan de la historia contable verificable.

### 2. Sellado Criptográfico con Árboles de Merkle (`asp_merkle_roots`)
* La tabla `asp_merkle_roots` agrupa lotes de transacciones contables (`rollup_batch_id`) y calcula un `root_hash` criptográfico.
* Cualquier intento de alteración retrospectiva en una transacción rompe el árbol de Merkle y es detectado inmediatamente, garantizando no repudio forense.

### 3. Mitigación Automatizada de Riesgos y Reservas (`ARR`)
* `arr_rolling_reserves`: Retención de reservas dinámicas automáticas sobre transacciones comerciales de alto volumen.
* `arr_clawbacks`: Mecanismo formal de contracargo y reversión contable controlada.
* `arr_disputes`: Trazabilidad y resolución formal de controversias comerciales.

### 4. Trazabilidad Forense y Cumplimiento Regulatorio (AML & Fiscal)
* `sys_audit_trails`: Registra de forma inmutable cada mutación con `actor_id`, `action_type`, `table_name`, `old_payload`, `new_payload`, `ip_address` y `created_at`.
* Vistas listas para auditorías regulatorias:
  - `vw_auditor_aml_export`: Diseñada para cumplimiento de prevención de lavado de dinero (Anti-Money Laundering).
  - `vw_auditor_tax_export`: Diseñada para auditoría contable e impositiva oficial.

### 5. Sandbox Agéntico de Cero Confianza (Zero Trust AI)
* Los agentes de IA son tratados como operadores ciegos sin acceso directo a la base de datos ni capacidad de emitir SQL crudo.
* Toda salida del modelo es forzada a través de esquemas JSON estructurados (`output_schema`), re-validados por Zod (`safeParse`), y procesada por servicios API-First que inyectan la identidad criptográfica del usuario (`owner_rid`) y verifican membresía multi-tenant (`tenant_users`).

---

*Seven Reasoons — Sovereign Identity & Bank-Grade Financial Architecture*
