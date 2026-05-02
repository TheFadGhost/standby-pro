import { useEffect, useState, useRef } from 'react';

/**
 * useEcoLoop
 * 
 * A custom hook that provides a synchronized, performance-optimized 
 * clock for the Standby mode.
 * 
 * Features:
 * - Throttled updates: Only updates state when visible changes occur.
 * - Refresh rate scaling: Slows down when the phone is idle/static.
 * - Energy efficiency: Uses requestAnimationFrame but respects an 'eco' cap.
 */
export const useEcoLoop = (isEcoMode: boolean = true) => {
  const [time, setTime] = useState(new Date());
  const requestRef = useRef<number>(0);
  const lastUpdateRef = useRef<number>(0);

  const animate = (timestamp: number) => {
    // Scaling logic:
    // If Eco Mode is on, we only update the 'seconds' state once per second.
    // This prevents unnecessary re-renders of the entire UI 60 times a second.
    const delta = timestamp - lastUpdateRef.current;
    const interval = isEcoMode ? 1000 : 16; // 1Hz in eco, ~60Hz in high-perf

    if (delta >= interval) {
      setTime(new Date());
      lastUpdateRef.current = timestamp;
    }

    requestRef.current = requestAnimationFrame(animate);
  };

  useEffect(() => {
    requestRef.current = requestAnimationFrame(animate);
    return () => cancelAnimationFrame(requestRef.current);
  }, [isEcoMode]);

  return time;
};
