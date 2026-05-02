import React, { createContext, useContext, useState } from 'react';
import { ThemeConfig, PRESET_THEMES, FontLabState } from './theme_config';

interface ThemeContextType {
  activeTheme: ThemeConfig;
  setTheme: (id: string) => void;
  fontLab: FontLabState;
  updateFontLab: (updates: Partial<FontLabState>) => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [activeTheme, setActiveTheme] = useState<ThemeConfig>(PRESET_THEMES[0]);
  const [fontLab, setFontLab] = useState<FontLabState>({
    sizeMultiplier: 1.0,
    weight: 400,
    kerning: 0,
    opacity: 1.0
  });

  const setTheme = (id: string) => {
    const theme = PRESET_THEMES.find(t => t.id === id);
    if (theme) setActiveTheme(theme);
  };

  const updateFontLab = (updates: Partial<FontLabState>) => {
    setFontLab(prev => ({ ...prev, ...updates }));
  };

  return (
    <ThemeContext.Provider value={{ activeTheme, setTheme, fontLab, updateFontLab }}>
      {children}
    </ThemeContext.Provider>
  );
};

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within a ThemeProvider');
  return context;
};
