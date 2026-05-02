import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';

/**
 * LayoutType
 * duo: Side-by-side widgets
 * single: One large widget filling the screen
 */
export type LayoutType = 'duo' | 'single';

interface DashboardProps {
  layout: LayoutType;
  leftWidget: React.ReactNode;
  rightWidget: React.ReactNode;
  singleWidget?: React.ReactNode;
}

/**
 * StandbyDashboard
 * The core layout engine that handles Duo and Single modes.
 */
export const StandbyDashboard: React.FC<DashboardProps> = ({ 
  layout, 
  leftWidget, 
  rightWidget,
  singleWidget 
}) => {
  return (
    <div className="standby-dashboard" style={{
      width: '100vw',
      height: '100vh',
      backgroundColor: '#000',
      display: 'flex',
      overflow: 'hidden',
      position: 'relative'
    }}>
      <AnimatePresence mode="wait">
        {layout === 'duo' ? (
          <motion.div 
            key="duo-layout"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 1.05 }}
            transition={{ duration: 0.3, ease: [0.23, 1, 0.32, 1] }}
            style={{
              display: 'flex',
              width: '100%',
              height: '100%'
            }}
          >
            {/* Left Panel */}
            <div style={{ flex: 1, borderRight: '1px solid #1a1a1a', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              {leftWidget}
            </div>
            {/* Right Panel */}
            <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              {rightWidget}
            </div>
          </motion.div>
        ) : (
          <motion.div 
            key="single-layout"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 1.05 }}
            transition={{ duration: 0.3, ease: [0.23, 1, 0.32, 1] }}
            style={{
              width: '100%',
              height: '100%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            {singleWidget || leftWidget}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};
