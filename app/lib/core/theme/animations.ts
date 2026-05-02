/**
 * Spring Configurations
 * Based on Emil Kowalski's Design Engineering philosophy.
 * These simulate real physics for an 'expensive' feel.
 */

export const SPRINGS = {
  // Apple-like crisp response
  default: {
    type: "spring",
    stiffness: 300,
    damping: 30,
    mass: 1
  },
  // Playful bounce for secondary actions
  playful: {
    type: "spring",
    stiffness: 400,
    damping: 15,
    mass: 1
  },
  // Slow, heavy feel for large transitions
  smooth: {
    type: "spring",
    stiffness: 100,
    damping: 40,
    mass: 1
  }
};

/**
 * Common Animation Variants
 */
export const FADE_SCALE = {
  initial: { opacity: 0, scale: 0.95 },
  animate: { opacity: 1, scale: 1 },
  exit: { opacity: 0, scale: 0.95 },
  transition: SPRINGS.default
};

export const TAP_FEEDBACK = {
  scale: 0.97,
  transition: { duration: 0.1, ease: [0.23, 1, 0.32, 1] }
};
