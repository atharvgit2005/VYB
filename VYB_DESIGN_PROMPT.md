# VYB — Claude Design Prompt

Paste the block below as your **first message** to Claude Design, and attach your reference
images (acid motion poster, gradient maps, heatmap backgrounds, thermal portrait, melting
type, purple duotone portrait, chrome type, holographic foil, VYB logo) in the same message.

---

You are designing the visual identity and full UI for **VYB** — a college social + dating app
for university students (iOS / Android / responsive web). Build me a design system and screen
set in a single coherent aesthetic. I've attached reference images; treat them as the mood
target, not as things to copy literally.

## 1. The product (so layouts make sense)

VYB has two modes the user toggles between from a switch in the top bar:

- **Social mode** — campus feed of posts, 24h campus stories rail, events catalog, people
  directory/search, own profile hub.
- **Swap mode (dating)** — swipeable profile deck, daily free likes + paid like packs,
  locked "someone liked you" profiles you unlock with coins, mutual matches → chat, and
  **Blind Date**: an anonymous timed text chat where both people vote at the end whether to
  reveal their identity.

Other flows: onboarding carousel, phone/email OTP auth + college email verification
(.edu / .ac.in, earns a verified campus badge), profile setup wizard, dating profile wizard,
create post, post detail with comments, coin/like store with payment, notifications, settings.

Users are 18–24, design-literate, on phones. Mobile-first: primary canvas **393 × 852**.

## 2. Aesthetic direction: thermal / heatmap

The whole system is built on a **thermographic heat ramp** — the false-colour look of a
thermal camera. Cold is deep violet-black, hot is acid yellow-white. Everything in the UI
sits somewhere on that ramp, and *heat means importance*.

Supporting textures from the references: liquid gradient-map blobs, fine analog grain,
subtle chromatic-aberration fringing on display type, chrome/foil highlights, duotone
photo treatments, and small hard-edged sticker labels for contrast against all the softness.

**Core rule — heat is a signal, not a wallpaper.** Hot colour marks the one thing that
matters on a screen (primary action, live state, unread, a match). If everything glows,
nothing reads. Aim for roughly 20% of any screen carrying real heat; the rest is cold
near-black with clean type.

## 3. Colour system

Define these as named tokens and use them everywhere — no ad-hoc hexes.

**The thermal ramp (cold → hot):**

| Token | Hex | Role |
|---|---|---|
| `heat-000` | `#05010A` | app background, void |
| `heat-050` | `#0E0518` | raised surface / card |
| `heat-100` | `#1B0B3A` | deep indigo, cold edge of gradients |
| `heat-200` | `#4C1D95` | pressed states, cold borders |
| `heat-300` | `#7C3AED` | violet — brand primary |
| `heat-400` | `#8B5CF6` | violet light — links, focus rings |
| `heat-500` | `#E0218A` | magenta — the ramp's midpoint |
| `heat-600` | `#FF3D6E` | hot pink-red |
| `heat-700` | `#FF5A1F` | ember orange |
| `heat-800` | `#FFA800` | flare |
| `heat-900` | `#FFD400` | hot yellow |
| `heat-max` | `#D4FF00` | **acid lime — hottest, rarest, the logo star colour** |

**Neutrals:** `ink-000 #FFFFFF`, `ink-100 #E8E2F5` (body text), `ink-300 #9B90B5`
(secondary), `ink-500 #5B5170` (disabled), `line #241640` (hairlines, 1px).

**Mode mapping — this is the key idea.** The two app modes are two ends of the same ramp:

- **Social mode** runs the cool half: `heat-100 → heat-300 → heat-400`, with `heat-max`
  acid lime as its single accent. Calm, spacious, violet.
- **Swap mode** runs the hot half: `heat-500 → heat-600 → heat-700 → heat-900`. Denser,
  warmer, more urgent.

Switching modes should read like a temperature change across the whole shell — background
gradient, accent, tab bar glow, and header all shift along the ramp. Design the mode switch
itself as a **thermometer/slider**, not a generic pill toggle: a track that is violet-cold at
one end and ember-hot at the other, with the knob physically sliding along it.

**Gradients.** Two named recipes only:
- `grad-thermal` — the full ramp, cold bottom-left → hot top-right, used for hero surfaces
  and the splash. Soft, blurred, organic (like the heatmap-background references), never a
  hard linear band.
- `grad-bloom` — a single radial hot spot fading into transparency, used behind CTAs, avatar
  rings, and live indicators.

**Accessibility, non-negotiable:** body text is always flat `ink-100` on `heat-000`/`heat-050`
— never on a gradient, never gradient-filled itself. Minimum 4.5:1 for body, 3:1 for large
display type and UI edges. On `heat-900`/`heat-max` fills, text flips to `heat-000` black.
Light mode is not required — this is a dark-native system.

## 4. Typography

Three roles, clearly separated:

- **Display** — a heavy wide/condensed grotesque, uppercase, tight tracking (-2 to -4%),
  used for screen titles, big numbers, and marketing moments. Think the poster type in the
  references. Use a licensable wide grotesque (Monument Extended / Druk feel); if you need a
  free stand-in, use **Archivo Expanded Black** or **Anton**. Display type may carry a
  gradient fill or a 1–2px chromatic fringe — but only at 28px+ and only one instance per
  screen.
- **UI** — **Inter** (or Geist). 400 / 500 / 600 only. All body, labels, inputs, buttons.
  Never gradient, never uppercase for body.
- **Micro-label** — Inter 600, 10–11px, ALL CAPS, letter-spacing +8 to +12%, used for
  eyebrow labels, section kickers, and metadata (`HOW TO CREATE` in the reference posters is
  the exact feel).
- **Numeric** — a mono (JetBrains Mono / SF Mono) with tabular figures for coin balances,
  timers, and countdowns. Blind-date countdowns must not reflow as digits change.

**Scale (mobile):** display 40/32/28 · title 22/18 · body 15/14 · caption 12 · micro 11.
Line height 1.15 for display, 1.45 for body.

## 5. Texture & material rules

- **Grain** — a fine monochrome noise overlay at 5–7% opacity over gradient areas only.
  Every gradient in this system is grained; a clean gradient looks wrong here.
- **Thermal blobs** — soft blurred organic shapes (80–140px blur) drifting behind hero
  sections, sampled from the ramp. Low contrast, never behind body text.
- **Chromatic fringe** — 1–2px red/cyan offset on display type and on match/reveal moments.
  Sparingly. Never on UI text or icons.
- **Chrome / foil** — reserved exclusively for **premium and value surfaces**: coin balances,
  like packs, the store, purchase confirmations, and the logo. Purple chrome with lime
  highlights, matching the wordmark. Because it's rare, it reads as "this costs money."
- **Sticker chips** — small hard-cornered (2–4px radius) high-contrast labels: solid
  `heat-max` lime on black, or solid black on lime. Used for counts, badges (`+20` style
  from the references), `LIVE`, `NEW`, verified campus badges. These hard edges are what keep
  the soft gradients from turning mushy.
- **Photography** — user photos always show true colour in feeds and swipe cards (people need
  to see faces honestly). The thermal duotone treatment is for *system* imagery only:
  onboarding, empty states, blind-date anonymous avatars, marketing. In blind date
  specifically, the other person is represented as a thermal blob silhouette that gets
  sharper as the session progresses — this is the single best use of the theme in the product.
- **Geometry** — cards 20px radius, buttons 14px (pill for primary CTAs), inputs 12px,
  sticker chips 3px. 4pt spacing grid, 20px screen gutters.

## 6. Logo

The attached wordmark is purple chrome lowercase `vyb` with acid-lime sparkle stars on black
satin. Keep it as-is for splash, onboarding, and the store. Extract the **four-point lime
star** as a standalone recurring motif: loading spinner, "new" marker, reaction burst,
match confetti, empty-state punctuation. Define clear space (= cap height of the `v`) and a
mono-lime fallback for small sizes and system icons.

## 7. Components to design

Show each in its default / hover-or-pressed / disabled / loading states, plus its Social and
Swap variants where they differ:

thermal primary button (bloom behind it, heat intensifies on press) · secondary + ghost
button · **mode switch (the thermometer slider)** · floating bottom tab bar (blurred dark
glass, active tab lit with a bloom) · desktop sidebar nav (≥1024px) · text input + OTP
code input (6 boxes) · story ring (the heat ramp as the unseen-story indicator, going cold
once viewed) · story rail · post card (author, verified campus badge, media, like / comment /
share) · comment bottom sheet · swipe card (photo gallery dots, name, age, major, interest
chips, dealbreaker chips) · swipe action buttons (pass / like / super) · locked profile card
(blurred + "unlock for N coins") · coin balance pill (foil) · like-counter with daily-refill
timer · like/coin pack cards in the store · payment confirm sheet · blind-date queue state ·
blind-date chat with countdown timer ring · reveal-vote UI (two-choice, high tension) ·
match celebration overlay · chat list row + chat bubbles · event card with bookmark ·
person row with follow button · avatar with verified badge · segmented filter chips ·
toast/snackbar · modal/bottom-sheet shell · empty states (no posts, no matches, no events) ·
skeleton loaders (a heat shimmer, not a grey sweep) · notification row.

## 8. Screens to mock up (393 × 852 unless noted)

1. Splash + onboarding carousel (3 slides)
2. Auth — phone/email entry, OTP verify, college email verification, verified success
3. Profile setup wizard (2 steps) and dating profile wizard (2 steps)
4. Home feed with story rail — scrolled and at-top
5. Story viewer (full bleed, progress bars)
6. Post detail with comment sheet open
7. Create post composer
8. Events list + event detail
9. People / search — empty query and with results
10. Profile hub (own) with received likes and active chats
11. Public user profile
12. Swap deck — neutral, mid-swipe-right, mid-swipe-left
13. Locked likes grid ("3 people liked you")
14. Coin / likes store + payment confirmation
15. Blind date — entry, queue/waiting, active chat with timer, reveal vote, mutual-reveal result
16. Match celebration → chat list → conversation
17. Notifications
18. Settings
19. Mode switch transition — Social and Swap side by side so the temperature shift is visible
20. Responsive web: feed at 1440 wide with sidebar nav
21. *(Optional)* Admin dashboard at 1440 — metrics, users table, reports queue. Same tokens,
    far less heat: this is a work tool, so cold surfaces, one accent, dense tables.

## 9. Motion notes (describe, don't animate)

Heat bloom expanding from the touch point on press · mode switch = ramp sweep across the
shell, 400ms · match = chromatic split then snap together · blind-date silhouette sharpening
over the session · timer ring cooling from `heat-max` to `heat-300` as time runs out ·
skeleton = heat shimmer travelling along the ramp.

## 10. Do not

Generic purple SaaS gradients · full-spectrum rainbows (the ramp is violet→lime, it never
goes green or cyan) · soft blue drop shadows · glassmorphism everywhere · bubbly oversized
radii · stock illustration · gradient body text · neon glow on every element · light mode ·
Instagram/Tinder pastiche. If a screen could belong to any other app, push it further.

## 11. Deliverable

Structure it as a design-system project:

1. **Foundations** — colour ramp with tokens and contrast values, mode mapping, gradient
   recipes, type scale, spacing, radii, grain/texture specs, iconography, logo usage.
2. **Components** — the gallery from §7, grouped (Actions, Inputs, Navigation, Social,
   Dating, Commerce, Feedback), every state visible.
3. **Screens** — §8, in flow order.
4. **Handoff notes** — token names mapped to a NativeWind/Tailwind theme config, since the
   app is React Native + NativeWind v4 and I'll be implementing these tokens directly.

Start with Foundations only. Show me the colour ramp, both mode mappings, the type scale, and
one hero screen (the home feed) so I can confirm the direction before you build the rest.

---

## Follow-up prompts once foundations are approved

- "Approved. Now build the full component gallery from §7, grouped, all states."
- "Now the Swap mode screens (12–16). Push the heat — this half of the app should feel
  hotter and denser than Social."
- "Now Blind Date (15) in detail. The thermal silhouette sharpening is the hero interaction —
  show me 4 progressive stages."
- "Now the responsive web feed at 1440 and the admin dashboard, cold variant."
- "Export the foundation tokens as a NativeWind v4 `tailwind.config.js` theme extension."
