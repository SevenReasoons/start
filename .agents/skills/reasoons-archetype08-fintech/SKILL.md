---
name: reasoons-archetype08-fintech
description: >-
  Especializada en el Arquetipo 08 (Familia 2): FinTech, Billeteras Digitales y Bóvedas P2P.
  Arquitectura bancaria con Ledger de doble partida contable inmutable, control de saldo no
  negativo, transacciones atómicas con Idempotency-Key y seguridad de alta custodia (SHI).
license: Apache-2.0
metadata:
  author: Seven Reasoons
  version: 1.0.0
---

# 💳 Skill: Arquetipo 08 — FinTech, Billetera Digital y Ledger Transaccional

> **Familia 2:** Comercio, Transacciones & Monetización  
> **Propósito:** Billeteras virtuales, sistemas de puntos, transferencias P2P y contabilidad de doble partida con grado bancario.

---

## ⚡ Especificación Técnica
- **Stack:** Next.js + PostgreSQL Atomic Transactions + WebCrypto + Supabase RLS.
- **Base de Datos Contable:**
  ```sql
  CREATE TABLE IF NOT EXISTS public.wallets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) UNIQUE,
    currency VARCHAR(3) DEFAULT 'USD',
    balance NUMERIC(15,2) DEFAULT 0.00 CHECK (balance >= 0),
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  CREATE TABLE IF NOT EXISTS public.ledger_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_wallet_id UUID REFERENCES public.wallets(id),
    destination_wallet_id UUID REFERENCES public.wallets(id),
    amount NUMERIC(15,2) NOT NULL CHECK (amount > 0),
    idempotency_key TEXT UNIQUE NOT NULL,
    reference_note TEXT,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
  );
  ALTER TABLE public.wallets ENABLE ROW LEVEL SECURITY;
  ALTER TABLE public.ledger_entries ENABLE ROW LEVEL SECURITY;
  ```
- **Axioma Contable Innegociable:** El saldo de una billetera NUNCA se actualiza directamente con un `UPDATE balance = balance + X` suelto; se calcula y ejecuta mediante una función atómica en PostgreSQL (`SELECT transfer_funds(...)`) dentro de una transacción con nivel de aislamiento serializable o bloqueo de fila `FOR UPDATE`.
