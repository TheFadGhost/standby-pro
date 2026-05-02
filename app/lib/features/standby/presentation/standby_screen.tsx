import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useEcoLoop } from '../../core/utils/eco_loop';
import { useNightMode } from '../../core/utils/night_mode';
import { ThemeProvider, useTheme } from '../../core/theme/theme_provider';
import { StandbyDashboard, LayoutType } from './dashboard';
import { DigitalClock, AnalogClock } from './widgets/clocks';
import { FlipClock } from './widgets/flip_clock';
import { MediaWidget, WeatherWidget, CalendarWidget } from './widgets/integration_widgets';
import { QuickActions } from './components/quick_actions';
import { PRESET_THEMES } from '../../core/theme/theme_config';

/**
 * Main Standby Screen
 * Orchestrates all services, widgets, and transitions.
 */
const StandbyScreenContent: React.FC = () => {
  const time = useEcoLoop();
  const { nightModeFilter } = useNightMode();
  const { activeTheme, setTheme } = useTheme();
  
  const [layout, setLayout] = useState<LayoutType>('duo');
  const [themeIndex, setThemeIndex] = useState(0);

  const toggleLayout = () => setLayout(prev => prev === 'duo' ? 'single' : 'duo');
  
  const nextTheme = () => {
    const nextIdx = (themeIndex + 1) % PRESET_THEMES.length;
    setThemeIndex(nextIdx);
    setTheme(PRESET_THEMES[nextIdx].id);
  };

  return (
    <div style={{ 
      width: '100vw', 
      height: '100vh', 
      filter: nightModeFilter, 
      transition: 'filter 1s ease-in-out',
      backgroundColor: '#000'
    }}>
      <StandbyDashboard 
        layout={layout}
        leftWidget={<DigitalClock time={time} />}
        rightWidget={<WeatherWidget />}
        singleWidget={<FlipClock time={time} />}
      />

      <QuickActions 
        onLayoutToggle={toggleLayout}
        onThemeToggle={nextTheme}
      />
    </div>
  );
};

export const StandbyScreen: React.FC = () => (
  <ThemeProvider>
    <StandbyScreenContent />
  </ThemeProvider>
);
