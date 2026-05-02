# Project Memory: Standby Mode App

## State Matrix
- **Overall Progress:** 85%
- **Current Phase:** Phase 3: Advanced Features
- **Primary Blocker:** None
- **Next Immediate Action:** Step 9: Smart Night Mode (Ambient-aware tinting).

## Key Architecture & Decisions
- Tech Stack: Capacitor + React.
- Animation Layer: Implemented `animations.ts` with custom spring physics (stiffness/damping) for an "expensive" feel.
- Feedback: Responsive `TAP_FEEDBACK` (scale down on press) applied to all interactive elements.

## Recent Actions (Max 3)
1. Created `animations.ts` to centralize spring-physics configs.
2. Built `quick_actions.tsx` with backdrop-blur and physics-based entry animations.
3. Applied origin-aware transitions to layout and theme switching modules.

*Note: Automated Git features will be initialized during the first planning step.*