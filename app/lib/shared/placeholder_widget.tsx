import React from 'react';
import { motion } from 'framer-motion';

/**
 * PlaceholderWidget
 * A simple component to represent future widgets during layout development.
 */
export const PlaceholderWidget: React.FC<{ label: string; color?: string }> = ({ label, color = '#333' }) => {
  return (
    <motion.div 
      whileTap={{ scale: 0.97 }}
      style={{
        width: '80%',
        height: '80%',
        borderRadius: '24px',
        backgroundColor: color,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        color: '#fff',
        fontSize: '1.5rem',
        fontWeight: 'bold',
        fontFamily: 'system-ui, sans-serif'
      }}
    >
      {label}
    </motion.div>
  );
};
