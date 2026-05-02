# Project Memory: Standby Mode App

## State Matrix
- **Overall Progress:** 35%
- **Current Phase:** Phase 2: UI Framework
- **Primary Blocker:** None
- **Next Immediate Action:** Step 4: Duo/Single Layout Engine.

## Key Architecture & Decisions
- Tech Stack: Capacitor + React (Pivoted from Flutter due to environment/CI constraints).
- Eco-Logic: Custom `useEcoLoop` hook implemented for refresh-rate scaling (1Hz in standby).
- Design: Framer Motion and Lucide React added for high-fidelity animations.

## Recent Actions (Max 3)
1. Implemented `eco_loop.ts` to solve the heating/battery drain issues found in competitors.
2. Verified Capacitor plugins for orientation and device state.
3. Updated project documentation to reflect the Capacitor transition and step progress.

*Note: Automated Git features will be initialized during the first planning step.*