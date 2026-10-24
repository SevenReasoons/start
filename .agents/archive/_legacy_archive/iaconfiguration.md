# Configuración de Inteligencia Artificial (Google Gemini)

CRÍTICO: Queda **ESTRICTAMENTE PROHIBIDO** tener modelos de IA "quemados" (hardcodeados) en el código fuente (ej. NUNCA escribas `"gemini-1.5-flash"` o `"gemini-pro"` directamente en un string en el backend o frontend).

## 1. Variables de Entorno Obligatorias
Siempre debes inyectar los modelos desde el entorno para permitir una fácil actualización. Utiliza las siguientes variables de entorno:

- Modelo de Texto Rápido/General: `process.env.GEMINI_TEXT_MODEL`
- Modelo de Análisis Visual/Imágenes: `process.env.GEMINI_IMAGE_MODEL`

Si necesitas proveer un fallback (valor por defecto) temporal mientras arranca el sistema, el fallback debe usar los modelos más recientes declarados en esta regla, pero SIEMPRE priorizando `.env`.

## 2. Modelos Autorizados (Actualizados)
Cuando configures un `.env` nuevo o establezcas fallbacks, SIEMPRE utiliza los nombres de la generación más moderna (SDK oficial de Gemini):
- `GEMINI_TEXT_MODEL=gemini-flash-latest` (Nunca uses gemini-1.5-flash explícitamente porque caduca. Usa siempre el alias 'latest').
- `GEMINI_IMAGE_MODEL=gemini-3.1-flash-lite-image`

## 3. Interacción con el SDK
- Siempre usa la librería `@google/genai` (el nuevo SDK) o `@google/generative-ai` según corresponda al pipeline.
- Antes de inventar o deducir un nombre de modelo, usa el método `listModels()` del SDK si necesitas descubrir dinámicamente qué modelos están disponibles en el entorno de producción.
