import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Settings, Maximize, LayoutGrid, Palette } from 'lucide-react';
import { useTheme } from '../../../core/theme/theme_provider';
import { SPRINGS, TAP_FEEDBACK, FADE_SCALE } from '../../../core/theme/animations';

interface QuickActionsProps {
  onLayoutToggle: () => void;
  onThemeToggle: () => void;
}

/**
 * QuickActions
 * Floating action bar with origin-aware popovers and responsive feedback.
 */
export const QuickActions: React.FC<QuickActionsProps> = ({ 
  onLayoutToggle, 
  onThemeToggle 
}) => {
  const { activeTheme } = useTheme();

  return (
    <motion.div 
      initial={{ opacity: 0, y: 50 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: 1, ...SPRINGS.smooth }}
      style={{
        position: 'absolute',
        bottom: '30px',
        left: '50%',
        transform: 'translateX(-50%)',
        display: 'flex',
        gap: '20px',
        padding: '10px 25px',
        backgroundColor: 'rgba(20, 20, 20, 0.8)',
        backdropFilter: 'blur(20px)',
        borderRadius: '100px',
        border: '1px solid rgba(255, 255, 255, 0.1)',
        zIndex: 100
      }}
    >
      <motion.button 
        whileTap={TAP_FEEDBACK}
        onClick={onLayoutToggle}
        style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#fff' }}
      >
        <LayoutGrid size={24} />
      </motion.button>

      <motion.button 
        whileTap={TAP_FEEDBACK}
        onClick={onThemeToggle}
        style={{ background: 'none', border: 'none', cursor: 'pointer', color: activeTheme.accentColor }}
      >
        <Palette size={24} />
      </motion.button>

      <motion.button 
        whileTap={TAP_FEEDBACK}
        style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#fff' }}
      >
        <Settings size={24} />
      </motion.button>
    </motion.div>
  );
};
