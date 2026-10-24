---
trigger: always_on
description: Catálogo maestro de componentes UI listos para copiar y pegar en Tema Claro exclusivo para prototipos rápidos (<24h).
---

# 🧩 14. Catálogo de Componentes UI para Prototipos (Tema Claro)

> **Propósito:** Proporcionar al equipo y a los agentes de Antigravity una biblioteca de componentes de copia y pega inmediata en **Tema Claro (Luxury Minimalist Light)**, optimizados para prototipar en minutos respetando estrictamente la identidad de Seven Reasoons.
> **Ámbito de Aplicación:** **Exclusivo para Prototipos Rápidos (<24h, Rol Awareness / Arquetipo 1)**.

---

## ⚡ Los Mandamientos del Estándar

1. **Prioridad Absoluta de Tema:** Todo prototipo nace en **Tema Claro**: fondos `#ffffff` y `#f8fafc`, textos `#0f172a` y `#475569`.
2. **La Regla de Oro del Degradado:**
   - Colores: Rojo (`#ef4444`), Naranja (`#f97316`), Verde (`#22c55e`), Azul (`#3b82f6`).
   - El degradado **NUNCA** se usa de relleno. **Exclusivo para bordes de 2px** y acentos técnicos.
   - Los rellenos de tarjetas y botones siempre son **blancos sólidos** (`#ffffff`).
3. **Tipografía:** `Inter` (Google Fonts). Títulos con `tracking-tighter` (-0.05em), badges con `tracking-widest` (0.1em).
4. **Firma y Contacto:** Isotipo oficial Seven Reasoons en footer (`opacity-50 grayscale hover:opacity-100 hover:grayscale-0`) y WhatsApp oficial (`5649328703`) con la promesa *"Respondemos en menos de una hora"*.

---

## 📦 Biblioteca de Componentes Listos para Usar

### 1. Botón CTA Oficial Seven Reasoons (Tema Claro)
*Borde degradado de 2px con relleno interior blanco sólido y micro-interacción al hacer hover.*

```html
<!-- HTML + Tailwind CSS -->
<div class="inline-block p-[2px] rounded-2xl bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)] transition-all duration-200 hover:-translate-y-1 hover:shadow-[0_20px_35px_-10px_rgba(59,130,246,0.25)]">
  <button class="w-full px-6 py-3 rounded-[14px] bg-white hover:bg-slate-50 text-slate-900 font-semibold text-sm flex items-center justify-center gap-2 transition-colors cursor-pointer">
    <svg class="w-4 h-4 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
    <span>Confirmar y Avanzar</span>
  </button>
</div>
```

```css
/* CSS Nativo Equivalente */
.btn-sr-cta {
  display: inline-block;
  padding: 2px;
  border-radius: 16px;
  background: linear-gradient(to right, #ef4444, #f97316, #22c55e, #3b82f6);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  cursor: pointer;
  text-decoration: none;
}
.btn-sr-cta:hover {
  transform: translateY(-3px);
  box-shadow: 0 20px 35px -10px rgba(59, 130, 246, 0.25);
}
.btn-sr-cta-inner {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  width: 100%;
  padding: 0.75rem 1.5rem;
  border-radius: 14px;
  background: #ffffff;
  color: #0f172a;
  font-family: 'Inter', sans-serif;
  font-weight: 600;
  font-size: 0.95rem;
  border: none;
  cursor: pointer;
}
.btn-sr-cta-inner:hover {
  background: #f8fafc;
}
```

---

### 2. Tarjeta Highlight de Alta Jerarquía
*Para destacar el plan estrella, el producto principal o la métrica más importante.*

```html
<div class="relative p-[2px] rounded-3xl bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)] shadow-[0_20px_40px_-15px_rgba(0,0,0,0.07)]">
  <div class="bg-white rounded-[22px] p-8 text-slate-900">
    <div class="flex items-center justify-between mb-4">
      <span class="text-[11px] font-bold uppercase tracking-widest text-slate-500 bg-slate-100 px-3 py-1 rounded-full border border-slate-200">
        Recomendado
      </span>
      <div class="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse"></div>
    </div>
    <h3 class="text-2xl font-bold tracking-tighter text-slate-900">Plan Enterprise Pro</h3>
    <p class="text-sm text-slate-600 font-normal mt-1 mb-6 leading-relaxed">
      Automatización integral de operaciones con garantía Seven Reasoons.
    </p>
    <div class="text-3xl font-extrabold tracking-tight text-slate-900 mb-6">
      $2,400 <span class="text-sm font-normal text-slate-500">/ mes</span>
    </div>
    <!-- Botón CTA integrado -->
    <div class="p-[2px] rounded-2xl bg-[linear-gradient(to_right,#ef4444,#f97316,#22c55e,#3b82f6)] hover:-translate-y-0.5 transition-transform">
      <button class="w-full py-2.5 bg-white hover:bg-slate-50 text-slate-900 font-semibold text-sm rounded-[14px]">
        Comenzar Ahora
      </button>
    </div>
  </div>
</div>
```

---

### 3. Cinta de Métricas Ejecutivas (KPI Ribbon)
*Tarjetas secundarias limpias con bordes neutros `border-slate-100` y tipografía de alto contraste.*

```html
<div class="grid grid-cols-1 sm:grid-cols-3 gap-4 w-full">
  <!-- Métrica 1 -->
  <div class="bg-white border border-slate-100 rounded-2xl p-5 shadow-sm">
    <div class="flex items-center justify-between text-xs text-slate-500 font-medium mb-2">
      <span>INGRESOS HOY</span>
      <span class="text-emerald-600 bg-emerald-50 px-2 py-0.5 rounded-full font-semibold">+18.4%</span>
    </div>
    <div class="text-2xl font-extrabold tracking-tight text-slate-900">$48,250 MXN</div>
    <p class="text-xs text-slate-400 mt-1">Transacciones conciliadas</p>
  </div>

  <!-- Métrica 2 -->
  <div class="bg-white border border-slate-100 rounded-2xl p-5 shadow-sm">
    <div class="flex items-center justify-between text-xs text-slate-500 font-medium mb-2">
      <span>EFICIENCIA OPERATIVA</span>
      <span class="text-blue-600 bg-blue-50 px-2 py-0.5 rounded-full font-semibold">99.8%</span>
    </div>
    <div class="text-2xl font-extrabold tracking-tight text-slate-900">0.42 seg</div>
    <p class="text-xs text-slate-400 mt-1">Tiempo medio de respuesta</p>
  </div>

  <!-- Métrica 3 -->
  <div class="bg-white border border-slate-100 rounded-2xl p-5 shadow-sm">
    <div class="flex items-center justify-between text-xs text-slate-500 font-medium mb-2">
      <span>CLIENTES ACTIVOS</span>
      <span class="text-indigo-600 bg-indigo-50 px-2 py-0.5 rounded-full font-semibold">En Vivo</span>
    </div>
    <div class="text-2xl font-extrabold tracking-tight text-slate-900">1,420</div>
    <p class="text-xs text-slate-400 mt-1">Sesiones concurrentes</p>
  </div>
</div>
```

---

### 4. Tabla de Datos Paginada en Tema Claro
*Estilo ultra-limpio con bordes suaves, estados visuales legibles y hover interactivo.*

```html
<div class="w-full bg-white border border-slate-200/80 rounded-2xl overflow-hidden shadow-sm">
  <div class="px-6 py-4 border-b border-slate-100 flex items-center justify-between">
    <h4 class="text-sm font-bold tracking-tight text-slate-900">Registros Recientes</h4>
    <span class="text-xs text-slate-500">Mostrando 2 de 24 registros</span>
  </div>
  <table class="w-full text-left text-sm text-slate-600">
    <thead class="bg-slate-50 text-xs uppercase font-semibold text-slate-500 border-b border-slate-100">
      <tr>
        <th class="px-6 py-3">Elemento</th>
        <th class="px-6 py-3">Estado</th>
        <th class="px-6 py-3">Métrica</th>
        <th class="px-6 py-3 text-right">Acción</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-slate-100">
      <tr class="hover:bg-slate-50/80 transition-colors">
        <td class="px-6 py-4 font-medium text-slate-900">Módulo de Autenticación RLS</td>
        <td class="px-6 py-4">
          <span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-700 border border-emerald-200/60">
            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Activo
          </span>
        </td>
        <td class="px-6 py-4 font-mono text-xs text-slate-700">99.98% SLA</td>
        <td class="px-6 py-4 text-right">
          <button class="text-xs font-semibold text-blue-600 hover:text-blue-800">Inspeccionar &rarr;</button>
        </td>
      </tr>
    </tbody>
  </table>
</div>
```

---

### 5. Indicador Telemétrico en Vivo (Pulsing Dot)
*Aporta sensación de producto vivo en tiempo real.*

```html
<div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-50 border border-emerald-200/60 text-emerald-700 text-xs font-semibold">
  <span class="relative flex h-2 w-2">
    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
    <span class="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
  </span>
  <span>CONEXIÓN ACTIVA EN VIVO</span>
</div>
```

---

### 6. Pie de Página Canónico Seven Reasoons
*Isotipo centrado en escala de grises con animación al pasar el cursor y enlace oficial de WhatsApp.*

```html
<footer class="w-full py-10 flex flex-col items-center justify-center gap-4 text-center">
  <!-- Botón WhatsApp Oficial -->
  <a 
    href="https://wa.me/525649328703" 
    target="_blank" 
    rel="noopener noreferrer"
    class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-slate-50 hover:bg-emerald-50 border border-slate-200/70 hover:border-emerald-300 text-slate-700 hover:text-emerald-700 text-xs font-medium transition-all"
  >
    <svg class="w-4 h-4 text-emerald-500" fill="currentColor" viewBox="0 0 24 24"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946.003-6.556 5.338-11.891 11.893-11.891 3.181.001 6.167 1.24 8.413 3.488 2.245 2.248 3.481 5.236 3.48 8.414-.003 6.557-5.338 11.892-11.893 11.892-1.99-.001-3.951-.5-5.688-1.448l-6.305 1.654zm6.597-3.807c1.676.995 3.276 1.591 5.392 1.592 5.448 0 9.886-4.434 9.889-9.885.002-5.462-4.415-9.89-9.881-9.892-5.452 0-9.887 4.434-9.889 9.884-.001 2.225.651 3.891 1.746 5.634l-.999 3.648 3.742-.981z"/></svg>
    <span>WhatsApp Oficial: 5649328703 &bull; Respondemos en menos de una hora</span>
  </a>

  <!-- Isotipo Oficial -->
  <img 
    src="https://static.wixstatic.com/media/751177_c763bd6bfbab4a7aa22b30690ecd712e~mv2.png" 
    alt="Seven Reasoons Logo" 
    class="h-7 w-auto opacity-50 grayscale hover:opacity-100 hover:grayscale-0 transition-all duration-300 cursor-pointer"
  />

  <p class="text-xs font-light text-slate-400 tracking-wide">
    Made with love by Seven Reasoons &bull; Prototipo de Alta Fidelidad
  </p>
</footer>
```
