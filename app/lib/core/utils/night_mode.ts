import { useState, useEffect } from 'react';

/**
 * useNightMode
 * 
 * Logic to handle auto-dimming and red-tinting for bedside use.
 * 
 * Features:
 * - Time-based activation (Sunset/Sunrise logic simplified for MVP).
 * - Intensity scaling based on user preference.
 * - Prevents eye strain by shifting UI colors to the red spectrum.
 */
export const useNightMode = (isAuto: boolean = true) => {
  const [isNightMode, setIsNightMode] = useState(false);
  const [intensity, setIntensity] = useState(1.0); // 0.0 to 1.0

  useEffect(() => {
    if (!isAuto) return;

    const checkTime = () => {
      const hour = new Date().getHours();
      // Auto-activate between 8 PM and 7 AM
      const night = hour >= 20 || hour < 7;
      setIsNightMode(night);
    };

    // Check every minute
    const interval = setInterval(checkTime, 60000);
    checkTime();

    return () => clearInterval(interval);
  }, [isAuto]);

  // CSS Filter string for the red tint
  // This shifts hues and reduces brightness while maintaining some contrast
  const nightModeFilter = isNightMode 
    ? `sepia(1) saturate(5) hue-rotate(-50deg) brightness(${0.4 + (1 - intensity) * 0.6})`
    : 'none';

  return { isNightMode, intensity, setIntensity, nightModeFilter };
};
