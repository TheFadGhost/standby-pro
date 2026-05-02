import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useTheme } from '../../../core/theme/theme_provider';

interface FlipUnitProps {
  value: string;
  label?: string;
}

const FlipUnit: React.FC<FlipUnitProps> = ({ value }) => {
  const { activeTheme } = useTheme();

  return (
    <div style={{
      position: 'relative',
      width: '120px',
      height: '180px',
      backgroundColor: '#1a1a1a',
      borderRadius: '12px',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      fontSize: '6rem',
      fontWeight: 'bold',
      color: activeTheme.textColor,
      margin: '0 5px',
      perspective: '400px'
    }}>
      <AnimatePresence mode="popLayout">
        <motion.div
          key={value}
          initial={{ rotateX: -90, opacity: 0 }}
          animate={{ rotateX: 0, opacity: 1 }}
          exit={{ rotateX: 90, opacity: 0 }}
          transition={{ duration: 0.4, ease: [0.32, 0.72, 0, 1] }}
          style={{ transformOrigin: 'center' }}
        >
          {value}
        </motion.div>
      </AnimatePresence>
      {/* Decorative center line */}
      <div style={{
        position: 'absolute',
        top: '50%',
        left: 0,
        width: '100%',
        height: '1px',
        backgroundColor: '#000',
        opacity: 0.5
      }} />
    </div>
  );
};

export const FlipClock: React.FC<{ time: Date }> = ({ time }) => {
  const hours = time.getHours().toString().padStart(2, '0');
  const minutes = time.getMinutes().toString().padStart(2, '0');

  return (
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <FlipUnit value={hours} />
      <div style={{ fontSize: '4rem', color: '#666', margin: '0 10px' }}>:</div>
      <FlipUnit value={minutes} />
    </div>
  );
};
