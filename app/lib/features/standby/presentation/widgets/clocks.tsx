import React from 'react';
import { motion } from 'framer-motion';
import { useTheme } from '../../../core/theme/theme_provider';

interface ClockProps {
  time: Date;
}

/**
 * DigitalClock
 * High-polish digital clock that respects the Theme Engine and Font Lab.
 */
export const DigitalClock: React.FC<ClockProps> = ({ time }) => {
  const { activeTheme, fontLab } = useTheme();

  const formatTime = (date: Date) => {
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');
    return { hours, minutes };
  };

  const { hours, minutes } = formatTime(time);

  const textStyle: React.CSSProperties = {
    fontFamily: activeTheme.fontFamily,
    color: activeTheme.textColor,
    fontWeight: fontLab.weight,
    letterSpacing: `${fontLab.kerning}em`,
    opacity: fontLab.opacity,
    fontSize: `${8 * fontLab.sizeMultiplier}rem`,
    lineHeight: 1,
    textShadow: activeTheme.glowIntensity > 0 
      ? `0 0 ${activeTheme.glowIntensity * 20}px ${activeTheme.accentColor}`
      : 'none',
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
      <motion.div 
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        style={textStyle}
      >
        {hours}:{minutes}
      </motion.div>
    </div>
  );
};

/**
 * AnalogClock
 * SVG-based analog clock with smooth transitions.
 */
export const AnalogClock: React.FC<ClockProps> = ({ time }) => {
  const { activeTheme } = useTheme();
  
  const seconds = time.getSeconds();
  const minutes = time.getMinutes();
  const hours = time.getHours() % 12;

  const secondDegrees = (seconds / 60) * 360;
  const minuteDegrees = ((minutes + seconds / 60) / 60) * 360;
  const hourDegrees = ((hours + minutes / 60) / 12) * 360;

  return (
    <div style={{ width: '80%', height: '80%', position: 'relative' }}>
      <svg viewBox="0 0 100 100" style={{ width: '100%', height: '100%' }}>
        {/* Clock Face */}
        <circle cx="50" cy="100" r="48" fill="none" stroke={activeTheme.accentColor} strokeWidth="1" opacity="0.2" />
        
        {/* Hour Hand */}
        <motion.line 
          x1="50" y1="50" x2="50" y2="25"
          stroke={activeTheme.textColor}
          strokeWidth="2.5"
          strokeLinecap="round"
          animate={{ rotate: hourDegrees }}
          style={{ originX: '50px', originY: '50px' }}
        />

        {/* Minute Hand */}
        <motion.line 
          x1="50" y1="50" x2="50" y2="15"
          stroke={activeTheme.textColor}
          strokeWidth="1.5"
          strokeLinecap="round"
          animate={{ rotate: minuteDegrees }}
          style={{ originX: '50px', originY: '50px' }}
        />

        {/* Center Point */}
        <circle cx="50" cy="50" r="2" fill={activeTheme.accentColor} />
      </svg>
    </div>
  );
};
