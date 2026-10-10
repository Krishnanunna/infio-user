---
name: Hyperlocal Glass Modern
colors:
  surface: '#f9f9ff'
  surface-dim: '#d3daea'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eefe'
  surface-container-high: '#e2e8f8'
  surface-container-highest: '#dce2f3'
  on-surface: '#151c27'
  on-surface-variant: '#4d4354'
  inverse-surface: '#2a313d'
  inverse-on-surface: '#ebf1ff'
  outline: '#7f7386'
  outline-variant: '#d0c1d7'
  surface-tint: '#8b1bd9'
  primary: '#8a19d8'
  on-primary: '#ffffff'
  primary-container: '#a540f3'
  on-primary-container: '#ffffff'
  inverse-primary: '#e0b6ff'
  secondary: '#5f5e5e'
  on-secondary: '#ffffff'
  secondary-container: '#e5e2e1'
  on-secondary-container: '#656464'
  tertiary: '#835400'
  on-tertiary: '#ffffff'
  tertiary-container: '#a46a00'
  on-tertiary-container: '#ffffff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#f2daff'
  primary-fixed-dim: '#e0b6ff'
  on-primary-fixed: '#2e004e'
  on-primary-fixed-variant: '#6c00ae'
  secondary-fixed: '#e5e2e1'
  secondary-fixed-dim: '#c8c6c5'
  on-secondary-fixed: '#1c1b1b'
  on-secondary-fixed-variant: '#474646'
  tertiary-fixed: '#ffddb5'
  tertiary-fixed-dim: '#ffb958'
  on-tertiary-fixed: '#2a1800'
  on-tertiary-fixed-variant: '#643f00'
  background: '#f9f9ff'
  on-background: '#151c27'
  surface-variant: '#dce2f3'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
  title-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  container-margin: 20px
  stack-gap-sm: 8px
  stack-gap-md: 16px
  stack-gap-lg: 24px
  grid-gutter: 12px
---

## Brand & Style

This design system is engineered for a hyperlocal service marketplace that bridges the gap between service providers (Partners) and consumers (Users). The brand personality is **modern, professional, and trustworthy**, utilizing a high-contrast visual language to ensure clarity in fast-paced mobile environments.

The aesthetic leans heavily into **Glassmorphism**, using translucent layers and backdrop blurs to create a sense of depth and spatial hierarchy without overwhelming the user with heavy shadows. This "glassy" approach is paired with **Corporate Modern** sensibilities—clean alignments, generous negative space, and a refined color palette—to maintain an institutional level of reliability. 

Distinct visual cues separate the two sides of the marketplace:
- **User/Consumer App:** Leverages vibrant green accents to evoke growth, discovery, and action.
- **Business/Partner App:** Utilizes deep blue/purple gradients to signify stability, professionalism, and management.

## Colors

The palette is anchored by **Vivid Purple (#A540F3)**, used strategically for primary actions and brand presence. 

- **Primary & Secondary:** The interaction between Vivid Purple and the deep Dark/Black (#121212) creates a high-contrast environment that aids readability.
- **Functional Accents:** Warm Amber (#A46A00) is reserved for cautionary states, ratings, and highlights.
- **Contextual Roles:** 
    - Use the **Green Accent** specifically for the User-facing interface (icons, progress bars, and "Search" context).
    - Use the **Blue Accent** specifically for the Partner-facing interface (analytics, "Business" context, and management tools).
- **Surface Strategy:** In Light Mode, use semi-transparent white fills with a 1px white border (20% opacity) to achieve the glass effect. In Dark Mode, use a deep navy-charcoal background with slightly opaque dark overlays.

## Typography

The typography system utilizes **Inter** for its exceptional legibility on mobile screens and neutral, professional tone. 

- **Scale:** A tight scale ensures that data-heavy Partner dashboards remain readable while User discovery screens feel airy and inviting.
- **High Contrast:** All headlines should utilize the Secondary Color (#121212 in light mode) to pop against the glassy backgrounds.
- **Hierarchy:** Use `label-md` for small metadata, category tags, and section headers in the Partner app to maintain a disciplined, "pro-tool" aesthetic.
- **Mobile Adjustments:** Large display text is capped at 32px to prevent excessive wrapping on smaller devices.

## Layout & Spacing

This design system uses a **fluid mobile grid** with a focus on safe margins and dynamic vertical rhythm based on a 4px baseline unit.

- **Margins:** A standard 20px horizontal margin is applied to all screens to ensure content does not touch the edge of the device frame.
- **Grid:** For list views and marketplace grids, use a 2-column layout on mobile with a 12px gutter. 
- **Vertical Rhythm:** Components are stacked using increments of 8px (sm), 16px (md), and 24px (lg). 
- **Partner Dashboard:** For the Business app, spacing density is increased (using the 8px gap more frequently) to allow more data visualization to appear above the fold.

## Elevation & Depth

Visual hierarchy is established through **Backdrop Blurs** and **Tonal Layers** rather than heavy shadows.

- **The Glass Effect:** Elevated elements (Cards, Navigation Bars, Modals) must use a `backdrop-filter: blur(12px)`. The background color of these elements should be white at 70-80% opacity.
- **Borders as Depth:** Every glassy element requires a 1px solid border. Use `glass_stroke` (white at 20%) on light backgrounds and a slightly darker stroke on dark backgrounds to define edges.
- **Shadows:** When necessary for extreme focus (e.g., a floating action button), use a very soft, diffused shadow: `box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08)`.

## Shapes

The shape language is **Rounded**, strike a balance between friendly (User) and professional (Partner).

- **Standard Radius:** 0.5rem (8px) for buttons, input fields, and small cards.
- **Large Radius (rounded-lg):** 1rem (16px) for main content containers and bottom sheets.
- **Extra Large Radius (rounded-xl):** 1.5rem (24px) for prominent featured cards in the User discovery feed.
- **Icons:** Use icons with a slightly rounded terminal (e.g., Lucide or Feather) to match the UI's radius.

## Components

### Buttons
- **Primary:** Vivid Purple (#A540F3) background with white text. 8px border radius. Apply a subtle gradient (top to bottom) for added depth.
- **Secondary (Glass):** Semi-transparent white background with a 1px purple border. Used for "Cancel" or "Secondary" actions.
- **Action Icons:** In the User app, use the Green Accent for success states; in the Partner app, use the Blue Accent for "Active" status buttons.

### Cards
- Marketplace cards should use the glass effect with 16px internal padding. 
- Partner dashboard cards should have a 1px subtle neutral-200 border to differentiate between multiple data points.

### Input Fields
- Clear, high-contrast borders (Neutral #6B7280).
- Focus state: The border color transitions to Vivid Purple with a subtle outer glow.
- Labels are always placed above the field in `label-md` style.

### Chips & Tags
- Used for service categories (e.g., "Plumbing", "Cleaning"). 
- User App: Light green background with dark green text.
- Partner App: Light blue background with dark blue text.

### Navigation
- A bottom navigation bar with a heavy backdrop-blur (15px-20px) to allow the content to scroll elegantly behind it.
- Active state icons use the Primary Vivid Purple.