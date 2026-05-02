# Summer Project Planner: Standby Mode App (Open Source)

> **AI ASSISTANT INSTRUCTIONS:** 
> This plan is approved for the Standby Mode App.
> 1. Initialized MEMORY.md and Git repo.
> 2. Follow Emil Kowalski's design engineering philosophy for all UI/UX components.
> 3. Priority: Flawless cross-platform performance using Flutter.

## 1. Project Overview
- **Project Name:** Standby Pro (Open Source)
- **Core Concept:** A high-polish, open-source alternative to the iOS Standby Mode for both Android and iOS.
- **Primary Goal:** Provide a premium-feel smart display experience while charging, fixing all common "4-star" complaints from existing apps.
- **Target Audience:** Tech enthusiasts, desk setup minimalists, and Android users wanting the iOS 17+ aesthetic.

## 2. Clarifying Questions & Scope
- **Platform Parity:** Support both Portrait & Landscape, focusing on landscape as the primary "Dock" mode.
- **Third-Party Widgets:** Build high-quality "Custom Replicas" of popular widgets (Spotify, Weather, Calendar) for maximum stability and visual polish.
- **Notification Privacy:** Show "Full Detail" in notifications by default to maximize utility while docked.

## 3. AI Feature Brainstorming

### Proposed Feature 1: "Single Focus" Mode (Fixing Layout Rigidity)
- **Mechanism:** A toggle to switch from Duo/Quad view to a single, high-impact widget or clock.
- **Integration:** Dynamic layout engine that scales any widget to fill the viewport gracefully.
- **Benefit:** Solves the #1 user complaint about being forced into side-by-side views.

### Proposed Feature 2: "The Font Lab" (Deep Customization)
- **Mechanism:** Integration with Google Fonts API + custom kerning/weight sliders.
- **Integration:** A dedicated customization sub-menu for every clock face.
- **Benefit:** Satisfies power users who want specific aesthetics (e.g., calculator font, minimalist thin weights).

### Proposed Feature 3: "Eco-Logic" Performance Engine
- **Mechanism:** Intelligent refresh rate scaling (down to 1Hz or 0.1Hz for static elements) and low-power foreground service logic.
- **Integration:** Custom rendering loop that detects if elements are moving (like clock hands) vs. static text.
- **Benefit:** Fixes the common "phone heating" and "battery drain" complaints.

## 4. Milestones & Timeline
- [ ] Milestone 1: Core Engine & Charging Detection (Cross-platform logic).
- [ ] Milestone 2: UI Framework & Duo/Single Layout Engine.
- [ ] Milestone 3: Initial Library of 10 Themes (Flip, Neon, Minimal, etc.).
- [ ] Milestone 4: Widget Integration (Weather, Calendar, Music).
- [ ] Milestone 5: Polish & Animation (Emil Kowalski style).

## 5. Technical Requirements & Resources
- **Tech Stack:** Flutter (Dart) for pixel-perfect cross-platform UI.
- **Key Libraries:** `flutter_reanimated`, `flutter_skia`, `foreground_service`, `weather_api`.
- **Assets:** Custom-designed icons and high-contrast color palettes.

## 6. GitHub & Documentation
- **README.md Structure:** 
  - Visual Demo (GIFs/Video).
  - One-click Setup for Devs.
  - Architecture overview (Clean Architecture/BLoC).
  - Contribution Guide for Themes.
- **Git Repo:** Initialized in `yt-channel-open-source/standby-mode-app`.

## 7. Project Log
- 2026-05-02: Project conceived. Scraped Play Store for competitive analysis. Identified "Single Focus" and "Font Lab" as key differentiators.
