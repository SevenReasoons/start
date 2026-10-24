---
name: reasoons-ui-atomic
description: >-
  Especializada en crear componentes frontend profesionales en Next.js bajo la metodología
  Atomic Design (Átomos, Moléculas, Organismos, Templates y Pages). Diseña componentes puros
  de presentación (Pure UI) con interfaces TypeScript estrictas, estilos modulados y desacoplados
  de la base de datos, garantizando un handoff perfecto a ingenieros Senior sin retrabajo en CSS.
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 🧱 Skill: Seven Reasoons Atomic Components (`reasoons-ui-atomic`)

> **Propósito:** Estandarizar la maquetación profesional de aplicaciones en Next.js App Router mediante **Atomic Design**, asegurando que los desarrolladores de nivel **Maker** creen interfaces hiper-escalables, modulares y puras, listas para que ingenieros Senior (Consultant / Architect) conecten datos y backend sin alterar maquetaciones ni estilos.

---

## ⚡ Los 5 Niveles de la Jerarquía Atómica

```text
src/components/ (o components/)
├── atoms/        # Nivel 1: Elementos indivisibles (Button, Badge, Input, Label, Spinner, Icon)
├── molecules/    # Nivel 2: Combinaciones funcionales de 2+ átomos (SearchBar, FormField, StatCard)
├── organisms/    # Nivel 3: Bloques autónomos complejos (Navbar, Sidebar, ProductGrid, DataTable, CartDrawer)
├── templates/    # Nivel 4: Layouts estructurales con slots/children (StoreLayout, DashboardLayout)
└── app/          # Nivel 5: Páginas en Next.js App Router (Composición declarativa pura)
```

---

## 🤝 Regla de Oro del Handoff a Senior (Architect / Consultant)

1. **Componentes Puros de Presentación (Dumb Components):**
   - Los componentes en `atoms/`, `molecules/` y `organisms/` **NUNCA** hacen llamadas directas a APIs o Supabase.
   - Reciben todos sus datos, estados de carga y callbacks mediante `props` estrictamente tipadas con TypeScript.
2. **Contrato de Props Obligatorio:**
   - Todo componente debe exportar su interfaz de propiedades:
     ```typescript
     export interface ProductCardProps {
       id: string;
       title: string;
       price: number;
       imageUrl?: string;
       badge?: string;
       onAddToCart?: (id: string) => void;
       isLoading?: boolean;
     }
     ```
3. **Cero Retrabajo para el Senior:**
   - El Senior **NO toca maquetación, ni márgenes, ni clases CSS**.
   - Solo inyecta hooks de datos (React Query, Server Actions, Zustand o Supabase Client) directamente en las props ya tipadas.

---

## 📦 Plantillas Canónicas de Implementación

### 1. Átomo: `components/atoms/Button.tsx`
```typescript
import React from 'react';

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  isLoading?: boolean;
  icon?: React.ReactNode;
}

export const Button: React.FC<ButtonProps> = ({
  children,
  variant = 'primary',
  size = 'md',
  isLoading = false,
  icon,
  className = '',
  disabled,
  ...props
}) => {
  const baseStyles = "inline-flex items-center justify-center font-medium rounded-xl transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 disabled:opacity-50 disabled:pointer-events-none active:scale-[0.98]";
  
  const sizeStyles = {
    sm: "px-3 py-1.5 text-xs min-h-[36px] gap-1.5",
    md: "px-4 py-2.5 text-sm min-h-[44px] gap-2", // 44px Mobile-First Touch Target
    lg: "px-6 py-3.5 text-base min-h-[52px] gap-2.5",
  };

  const variantStyles = {
    primary: "bg-slate-900 text-white hover:bg-slate-800 focus:ring-slate-900 shadow-sm",
    secondary: "bg-slate-100 text-slate-800 hover:bg-slate-200 focus:ring-slate-400",
    outline: "border border-slate-200 bg-white text-slate-700 hover:bg-slate-50 focus:ring-slate-400",
    ghost: "bg-transparent text-slate-600 hover:bg-slate-100 focus:ring-slate-300",
  };

  return (
    <button
      className={`${baseStyles} ${sizeStyles[size]} ${variantStyles[variant]} ${className}`}
      disabled={disabled || isLoading}
      {...props}
    >
      {isLoading ? (
        <span className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin" />
      ) : icon ? (
        <span className="flex-shrink-0">{icon}</span>
      ) : null}
      <span>{children}</span>
    </button>
  );
};
```

---

### 2. Molécula: `components/molecules/ProductCard.tsx`
```typescript
import React from 'react';
import { Button } from '../atoms/Button';

export interface ProductCardProps {
  id: string;
  title: string;
  price: number;
  currency?: string;
  imageUrl?: string;
  category?: string;
  onAddToCart?: (id: string) => void;
  isAddingToCart?: boolean;
}

export const ProductCard: React.FC<ProductCardProps> = ({
  id,
  title,
  price,
  currency = 'USD',
  imageUrl,
  category,
  onAddToCart,
  isAddingToCart = false,
}) => {
  const formattedPrice = new Intl.NumberFormat('es-MX', {
    style: 'currency',
    currency,
  }).format(price);

  return (
    <div className="group flex flex-col bg-white border border-slate-100 rounded-2xl p-4 shadow-sm hover:shadow-md transition-all duration-200">
      <div className="aspect-square w-full rounded-xl bg-slate-50 overflow-hidden mb-3 relative flex items-center justify-center">
        {imageUrl ? (
          <img src={imageUrl} alt={title} className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300" />
        ) : (
          <span className="text-slate-300 text-xs font-mono uppercase">Sin imagen</span>
        )}
        {category && (
          <span className="absolute top-2 left-2 px-2 py-0.5 bg-white/90 backdrop-blur-sm rounded-full text-[10px] font-bold tracking-wider uppercase text-slate-600 border border-slate-100">
            {category}
          </span>
        )}
      </div>

      <h3 className="text-sm font-semibold text-slate-900 mb-1 line-clamp-1">{title}</h3>
      <p className="text-base font-bold text-slate-900 mb-3">{formattedPrice}</p>

      <div className="mt-auto">
        <Button
          variant="outline"
          size="sm"
          className="w-full text-xs font-semibold"
          onClick={() => onAddToCart?.(id)}
          isLoading={isAddingToCart}
        >
          Agregar al Carrito
        </Button>
      </div>
    </div>
  );
};
```

---

### 3. Organismo: `components/organisms/ProductGrid.tsx`
```typescript
import React from 'react';
import { ProductCard, ProductCardProps } from '../molecules/ProductCard';

export interface ProductGridProps {
  products: ProductCardProps[];
  onAddToCart?: (id: string) => void;
  activeAddingId?: string | null;
  emptyMessage?: string;
}

export const ProductGrid: React.FC<ProductGridProps> = ({
  products,
  onAddToCart,
  activeAddingId,
  emptyMessage = "No hay productos disponibles.",
}) => {
  if (products.length === 0) {
    return (
      <div className="py-12 text-center text-slate-400 text-sm">
        {emptyMessage}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
      {products.map((product) => (
        <ProductCard
          key={product.id}
          {...product}
          isAddingToCart={activeAddingId === product.id}
          onAddToCart={onAddToCart}
        />
      ))}
    </div>
  );
};
```

---

### 4. Template: `components/templates/StoreTemplate.tsx`
```typescript
import React from 'react';

export interface StoreTemplateProps {
  header: React.ReactNode;
  filters?: React.ReactNode;
  content: React.ReactNode;
  cartDrawer?: React.ReactNode;
}

export const StoreTemplate: React.FC<StoreTemplateProps> = ({
  header,
  filters,
  content,
  cartDrawer,
}) => {
  return (
    <div className="min-h-screen bg-slate-50 flex flex-col">
      <header className="sticky top-0 z-30 bg-white/95 backdrop-blur-sm border-b border-slate-100">
        {header}
      </header>

      <main className="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 py-6 flex flex-col md:flex-row gap-6">
        {filters && (
          <aside className="w-full md:w-64 flex-shrink-0">
            {filters}
          </aside>
        )}
        <section className="flex-1 min-w-0">
          {content}
        </section>
      </main>

      {cartDrawer}
    </div>
  );
};
```

---

### 5. Página Next.js: `app/[locale]/(store)/page.tsx`
```typescript
// Esta es la capa que conecta el Senior sin tocar el CSS
import { StoreTemplate } from '@/components/templates/StoreTemplate';
import { ProductGrid } from '@/components/organisms/ProductGrid';

export default async function StorePage() {
  // El Senior inyecta la consulta real a Supabase aquí:
  // const { data: products } = await supabase.from('products').select('*');
  const products = []; 

  return (
    <StoreTemplate
      header={<h1 className="text-lg font-bold">Catálogo Oficial</h1>}
      content={<ProductGrid products={products} />}
    />
  );
}
```
