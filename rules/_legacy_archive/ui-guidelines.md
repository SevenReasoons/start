# Agoratori UI/UX Guidelines

## Core Aesthetic & Vibe
The UI should feel premium, state-of-the-art, and incredibly intuitive. It must combine modern web design trends to create a "wow" factor at first glance. 

**Key Principles:**
1. **Glassmorphism:** Use semi-transparent backgrounds with `backdrop-blur` (e.g., `bg-white/70 backdrop-blur-md` or `bg-slate-900/40 backdrop-blur-sm`).
2. **Neumorphism / Soft Shadows:** Use soft, diffused, and large shadows to create depth (`shadow-sm`, `shadow-lg`, `shadow-2xl`). Avoid harsh borders where shadows can do the job of separating elements.
3. **Tactile Micro-interactions:** UI elements must feel "alive".
   - Use `transition-all duration-300 ease-in-out` on interactive elements.
   - Add hover states (e.g., `hover:scale-105` or `hover:-translate-y-1`).
   - Add active states for clicks (e.g., `active:scale-95`).
4. **Floating Elements:** Favor Floating Action Buttons (FABs) and floating cards/menus over cluttered static sidebars or fixed bars, especially on mobile.
5. **Clean Typography:** Use high contrast and varying font weights. 
   - Super bold headers (`font-black`, `tracking-tight`).
   - Subtle, uppercase, tracked-out helper texts (`text-[10px] font-bold uppercase tracking-widest text-slate-400`).
6. **Curated Colors:** Avoid generic primary red/blue. Use slate scales (`slate-50` to `slate-900`), and vibrant but sophisticated accent colors (like `emerald-500` or `indigo-600`) for badges and primary actions.

## Rules for New Components
- **Never use default unstyled browser elements**.
- **Always include responsive padding and sizing**.
- **Use rounded corners**: `rounded-2xl` or `rounded-full` for a modern, friendly feel.
- **Provide clear empty states or loading states** with subtle pulse animations or loaders.
- **Forms and Wizards**: Break complex forms into simple, digestible steps. Use progress bars and clear "Next/Back" buttons. Hide complexity until needed.
