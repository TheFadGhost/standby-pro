/**
 * Theme Definitions
 * High-variety presets inspired by iOS Standby and reference screenshots.
 */

export interface ThemeConfig {
  id: string;
  name: string;
  fontFamily: string;
  backgroundColor: string;
  accentColor: string;
  textColor: string;
  glowIntensity: number; // 0 to 1
  letterSpacing: string;
  fontWeight: number | string;
}

export const PRESET_THEMES: ThemeConfig[] = [
  {
    id: 'retro-flip',
    name: 'Retro Flip',
    fontFamily: 'Inter, sans-serif',
    backgroundColor: '#000000',
    accentColor: '#ffffff',
    textColor: '#ffffff',
    glowIntensity: 0,
    letterSpacing: '-0.05em',
    fontWeight: 900,
  },
  {
    id: 'neon-pulse',
    name: 'Neon Pulse',
    fontFamily: 'system-ui, sans-serif',
    backgroundColor: '#000000',
    accentColor: '#ff0055',
    textColor: '#ff0055',
    glowIntensity: 0.8,
    letterSpacing: '0.1em',
    fontWeight: 300,
  },
  {
    id: 'minimal-mono',
    name: 'Minimal Mono',
    fontFamily: 'Courier New, monospace',
    backgroundColor: '#000000',
    accentColor: '#333333',
    textColor: '#ffffff',
    glowIntensity: 0,
    letterSpacing: '0',
    fontWeight: 400,
  },
  {
    id: 'solar-gradient',
    name: 'Solar Gradient',
    fontFamily: 'system-ui, sans-serif',
    backgroundColor: '#000000',
    accentColor: '#ffaa00',
    textColor: '#ffaa00',
    glowIntensity: 0.4,
    letterSpacing: '-0.02em',
    fontWeight: 700,
  },
  {
    id: 'matrix-digital',
    name: 'Matrix Digital',
    fontFamily: 'monospace',
    backgroundColor: '#000000',
    accentColor: '#00ff41',
    textColor: '#00ff41',
    glowIntensity: 0.6,
    letterSpacing: '0.2em',
    fontWeight: 500,
  }
];

export interface FontLabState {
  sizeMultiplier: number;
  weight: number;
  kerning: number;
  opacity: number;
}
