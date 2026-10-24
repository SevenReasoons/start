---
trigger: always_on
---

# 🛡️ 12. Extensión Enterprise: Seguridad de Alta Custodia y FinTech (SHI)

> **Propósito:** Módulo especializado para aplicaciones de custodia financiera, comercio electrónico de alto volumen, salud o criptografía avanzada. Define el indicador de seguridad gamificado (SHI), cifrado de extremo a extremo (E2EE) con WebCrypto, auditoría criptográfica con árboles de Merkle y gestión automatizada de riesgos.

---

## 1. Gamificación de la Seguridad: El Protocolo SHI (Security Health Index)

La seguridad no debe frustrar al usuario común ni exigir hardware costoso para alcanzar la máxima protección:

1. **Axioma de Accesibilidad:** El 100% de la barra de seguridad debe ser alcanzable de forma gratuita utilizando únicamente un smartphone estándar y herramientas nativas de software.
2. **Axioma Militar (Bonus):** Las llaves físicas de hardware (YubiKey / FIDO2) representan un **BONUS militar (+10 pts / 110 pts)** para cuentas corporativas de alta custodia, pero nunca un requisito para lograr el 100%.

### 📊 Tabla de Puntuación Canónica (Meta: 100 pts)

$$\text{Puntaje Estándar: } 20 + 15 + 15 + 25 + 15 + 10 = \mathbf{100\text{ pts}}$$

| # | Configuración de Seguridad | Puntos | Rol Técnico y Operativo |
|---|---|:---:|---|
| 1 | **NIP Maestro (6-7 dígitos)** | **+20 pts** | Clave de acceso diario. Cero costo de SMS por sesión rutinaria. |
| 2 | **Línea Celular (SMS OTP)** | **+15 pts** | Celular principal. Reservado exclusivamente para verificación y rescate. |
| 3 | **Segundo Celular de Respaldo** | **+15 pts** | Número alternativo o de confianza si se extravía el teléfono principal. |
| 4 | **Correo Electrónico Verificado** | **+25 pts** | Ancla de identidad y notificaciones de seguridad críticas. |
| 5 | **Biometría Nativa (WebAuthn / Passkeys)** | **+15 pts** | FaceID o huella dactilar local en el dispositivo. |
| 6 | **Contacto de Confianza (Rescate Social)** | **+10 pts** | Mecanismo de recuperación ante pérdida total de dispositivos. |
| ★ | **Llave Física de Hardware (YubiKey / FIDO2)** | **BONUS +10 pts** | Bóveda Militar (Para cuentas que alcanzan 110/100 pts). |

---

## 2. Criptografía de Alto Rendimiento en el Cliente (WebCrypto E2EE)

Para sistemas de mensajería confidencial o bóvedas de datos personales:
1. **API Nativa:** Utilizar exclusivamente la API estándar **WebCrypto** del navegador (`crypto.subtle`), acelerada por hardware nativo del dispositivo (Cero impacto térmico en CPU móvil).
2. **Algoritmos Criptográficos:**
   - Intercambio de llaves efímero: **ECDH** (Curva P-256 / X25519).
   - Cifrado simétrico de datos: **AES-GCM con llaves de 256 bits** y vectores de inicialización (IV) únicos e irrepetibles por mensaje.
   - Derivación de claves desde contraseña o NIP: **PBKDF2** con SHA-256 (mínimo 100,000 iteraciones).

---

## 3. Sellado Criptográfico Inmutable con Árboles de Merkle

En plataformas que registran transacciones contables, órdenes de compra o registros de auditoría:
1. Los lotes de transacciones se agrupan en bloques periódicos y se calcula un **Root Hash de Merkle**.
2. Cualquier intento de alteración retrospectiva en una fila de la base de datos rompe la raíz criptográfica del árbol, garantizando no repudio y trazabilidad forense inmediata para auditorías regulatorias.

---

## 4. Mitigación Automatizada de Riesgos y Reservas (ARR)

Para operaciones de pasarela de pago o billeteras digitales:
* **Reservas Dinámicas:** Retención preventiva automática de un porcentaje de transacciones de alto riesgo durante 30 a 90 días.
* **Mecanismo de Contracargos y Disputas:** Tablas dedicadas para trazabilidad de controversias, reversión contable controlada y congelamiento automático de balances ante detección de fraude.
