---
name: reasoons-archetype17-iot-telemetry
description: >-
  Especializada en el Arquetipo 17 (Familia 5): IoT Industrial, Telemetría y Smart Factory.
  Ingesta masiva de sensores industriales, canales broadcast en tiempo real con Supabase
  Realtime, visualización de planos y alertas de umbrales a 60 FPS estables sin fugas de memoria.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🏭 Skill: Arquetipo 17 — IoT Industrial, Telemetría y Monitoreo en Tiempo Real

> **Familia 5:** Automatización, IA & Telemetría  
> **Propósito:** Plantas de manufactura, flotas de transporte, domótica y sensores industriales con visualizaciones en vivo.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + Supabase Realtime Broadcast + Leaflet/Canvas 2D + WebSockets.
- **Base de Datos:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.iot_devices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_name TEXT NOT NULL,
    device_type TEXT NOT NULL,
    location_zone TEXT,
    is_online BOOLEAN DEFAULT true,
    last_seen TIMESTAMPTZ DEFAULT now()
  );
  CREATE TABLE IF NOT EXISTS public.telemetry_logs (
    id BIGSERIAL PRIMARY KEY,
    device_id UUID REFERENCES public.iot_devices(id) ON DELETE CASCADE,
    metric_name TEXT NOT NULL,
    metric_value NUMERIC NOT NULL,
    unit VARCHAR(10),
    recorded_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.iot_devices ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.telemetry_logs ENABLE ROW LEVEL SECURITY;
  ALTER PUBLICATION supabase_realtime ADD TABLE public.telemetry_logs;
  ```
- **Rendimiento:** Gráficos renderizados con HTML5 Canvas o WebGL para mantener 60 FPS estables sin saturar el DOM con miles de lecturas de sensores por segundo.
