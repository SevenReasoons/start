---
trigger: always_on
---

# 🤖 Configuración de Agentes, MCP y Skills

Directrices para configurar el cliente MCP (Model Context Protocol) y las habilidades de agente para el ecosistema Seven Reasoons y Supabase en Antigravity.

---

## 1. Configuración de Servidor MCP (Supabase)

Agrega la siguiente configuración en tu archivo `~/.gemini/antigravity/mcp_config.json` (o a través de la interfaz de Antigravity):

```json
{
  "mcpServers": {
    "supabase": {
      "serverUrl": "https://mcp.supabase.com/mcp?project_ref=hiwhzjobdwbyqmofivcp&features=docs%2Caccount%2Cdatabase%2Cdebugging%2Cdevelopment%2Cfunctions%2Cbranching"
    }
  }
}
```

### Instrucciones de Activación y Autenticación:
1. Guarda la configuración en `mcp_config.json` y reinicia Antigravity.
2. Completa el flujo OAuth para autenticarte con Supabase cuando el sistema lo solicite.
3. **Gestión desde la interfaz:**
   - Menú `···` en el panel de Agente > **MCP Servers** > **Manage MCP Servers**.
   - Si requieres re-autenticar, abre Ajustes de Agente con `Cmd+,` (Mac) o `Ctrl+,` (Windows/Linux), ve a la pestaña **Customizations** y presiona **Authenticate** junto al servidor de Supabase.

---

## 2. Instalación de Agent Skills (Opcional pero Recomendado)

Las Agent Skills proporcionan al agente instrucciones especializadas, scripts y herramientas para operar con Supabase de forma precisa y eficiente:

```bash
npx skills add supabase/agent-skills
```