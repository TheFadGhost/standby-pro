import React from 'react';
import { motion } from 'framer-motion';
import { Play, Pause, SkipBack, SkipForward, Cloud, Calendar as CalendarIcon } from 'lucide-react';
import { useTheme } from '../../../core/theme/theme_provider';

/**
 * MediaWidget
 * A high-polish replica of a music player.
 * Built to look identical on iOS/Android.
 */
export const MediaWidget: React.FC = () => {
  const { activeTheme } = useTheme();

  return (
    <div style={{
      width: '85%',
      height: '85%',
      backgroundColor: '#111',
      borderRadius: '24px',
      padding: '20px',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'space-between',
      boxShadow: '0 10px 30px rgba(0,0,0,0.5)',
      border: '1px solid #222'
    }}>
      <div style={{ display: 'flex', gap: '15px', alignItems: 'center' }}>
        <div style={{ width: '60px', height: '60px', backgroundColor: activeTheme.accentColor, borderRadius: '12px', opacity: 0.8 }} />
        <div style={{ display: 'flex', flexDirection: 'column' }}>
          <span style={{ color: '#fff', fontWeight: 'bold', fontSize: '1.1rem' }}>Vibe Track</span>
          <span style={{ color: '#888', fontSize: '0.9rem' }}>Standby Pro Artist</span>
        </div>
      </div>

      <div style={{ width: '100%', height: '4px', backgroundColor: '#333', borderRadius: '2px', position: 'relative' }}>
        <div style={{ width: '45%', height: '100%', backgroundColor: activeTheme.accentColor, borderRadius: '2px' }} />
      </div>

      <div style={{ display: 'flex', justifyContent: 'center', gap: '30px', alignItems: 'center' }}>
        <SkipBack size={24} color="#888" />
        <div style={{ 
          width: '50px', height: '50px', 
          backgroundColor: '#fff', borderRadius: '50%', 
          display: 'flex', alignItems: 'center', justifyContent: 'center' 
        }}>
          <Play size={24} color="#000" fill="#000" />
        </div>
        <SkipForward size={24} color="#888" />
      </div>
    </div>
  );
};

/**
 * WeatherWidget
 * Minimalist weather display.
 */
export const WeatherWidget: React.FC = () => {
  const { activeTheme } = useTheme();

  return (
    <div style={{ textAlign: 'center', color: '#fff' }}>
      <motion.div 
        animate={{ y: [0, -5, 0] }}
        transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
      >
        <Cloud size={64} color={activeTheme.accentColor} />
      </motion.div>
      <div style={{ fontSize: '3rem', fontWeight: 'bold', marginTop: '10px' }}>22°</div>
      <div style={{ color: '#888', textTransform: 'uppercase', letterSpacing: '0.1em', fontSize: '0.8rem' }}>London • Mostly Cloudy</div>
    </div>
  );
};

/**
 * CalendarWidget
 * High-polish mini calendar.
 */
export const CalendarWidget: React.FC = () => {
  const { activeTheme } = useTheme();
  const today = new Date().getDate();

  return (
    <div style={{ width: '80%', height: '80%', color: '#fff', display: 'flex', flexDirection: 'column' }}>
      <div style={{ color: activeTheme.accentColor, fontWeight: 'bold', fontSize: '1.2rem', marginBottom: '10px' }}>MAY</div>
      <div style={{ 
        display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: '8px',
        fontSize: '0.7rem', color: '#555', textAlign: 'center'
      }}>
        {['M', 'T', 'W', 'T', 'F', 'S', 'S'].map(d => <div key={d}>{d}</div>)}
        {Array.from({ length: 31 }).map((_, i) => (
          <div key={i} style={{
            padding: '4px',
            borderRadius: '6px',
            backgroundColor: i + 1 === today ? activeTheme.accentColor : 'transparent',
            color: i + 1 === today ? '#000' : '#fff',
            fontWeight: i + 1 === today ? 'bold' : 'normal'
          }}>
            {i + 1}
          </div>
        ))}
      </div>
    </div>
  );
};
