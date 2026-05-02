# Implementation Plan: Standby Pro

This plan outlines the development of a high-polish, cross-platform Standby Mode app using Flutter.

## Phase 1: Foundation & Core Engine
- [x] **Step 1: Project Scaffolding & Environment.** Initialize Flutter project, setup folder structure (Clean Architecture), and configure cross-platform dependencies.
- [x] **Step 2: Charging & Orientation Logic.** Implement platform-specific listeners to detect power connection and landscape orientation triggers.
- [x] **Step 3: Core Rendering Loop.** Create the "Eco-Logic" engine to manage refresh rates and prevent device heating.

## Phase 2: UI Framework & Layouts
- [x] **Step 4: Duo/Single Layout Engine.** Build the dynamic grid system that supports side-by-side widgets and "Single Focus" fullscreen mode.
- [x] **Step 5: Theme & Font Lab Engine.** Implement the customization system (Google Fonts, weight/kerning sliders, and color palettes).
- [x] **Step 6: Basic Widget Library.** Develop the first set of core widgets: Analog Clock, Digital Clock, and Flip Clock.

## Phase 3: Advanced Features & Polish
- [x] **Step 7: Media & Integration Widgets.** Build custom replicas for Spotify/Music control and Calendar/Weather integration.
- [x] **Step 8: Animation & Transition Layer.** Apply Emil Kowalski's design principles (spring physics, origin-aware popovers, and responsive feedback).
- [x] **Step 9: Smart Night Mode.** Implement ambient-aware red tinting and auto-dimming logic.

## Phase 4: Open Source Release & Prep
- [ ] **Step 10: Documentation & README.** Create a professional GitHub repository presence with GIFs and clear setup instructions.
- [ ] **Step 11: Final Performance Audit.** Verify battery impact and memory usage on both iOS and Android.

## Phase 5: Post-Launch Monetization (Future)
- **Strategy:** Ethical Monetization.
- **Pricing:** £0.99/mo or £9.99/year.
- **Premium Features (to be gated later):** 
    - Exclusive "Designer" clock faces.
    - Advanced "Font Lab" experimental typography.
    - "Vibes Radio" custom YouTube/URL streams.
- **Implementation:** The app will be built fully functional initially. A `PremiumManager` service will be added later to check subscription status and gate specific UI components.
