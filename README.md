# Standby Pro 🌙

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: iOS / Android](https://img.shields.io/badge/Platform-iOS%20%2F%20Android-blue.svg)](#)
[![Tech: Capacitor + React](https://img.shields.io/badge/Tech-Capacitor%20%2B%20React-61dafb.svg)](#)

> A high-polish, open-source alternative to iOS Standby Mode. Built for cross-platform visual excellence and bedside utility.

Standby Pro transforms your phone into a smart, minimalist display while charging. Designed with **Emil Kowalski's** design engineering principles, it focuses on buttery-smooth animations, energy efficiency, and deep customization.

---

## ✨ Key Features

### 🚀 Performance & Logic
- **Eco-Logic Rendering Engine**: Intelligent refresh-rate scaling (1Hz in standby) to eliminate phone heating and excessive battery drain.
- **Smart Charging Detection**: Automatically triggers when the device is plugged in (powered by Capacitor).
- **Dual-Orientation Support**: Primary landscape optimization with full portrait fallback.

### 🎨 Visuals & UI
- **Single Focus & Duo Modes**: Choose between one large fullscreen widget or side-by-side productivity panels.
- **The Font Lab**: Real-time control over typography weight, kerning, and sizing.
- **High-Variety Themes**:
    - **Retro Flip**: Physical-feel 3D mechanical clock.
    - **Neon Pulse**: High-intensity glow for modern setups.
    - **Solar Gradient**: Warm, ambient lighting for bedside use.
    - **Matrix Digital**: Minimalist green terminal aesthetic.

### 🛌 Bedside Utility
- **Smart Night Mode**: Ambient-aware red-tint filter (sepia/hue-shift) to preserve night vision.
- **High-Polish Widgets**: Custom replicas of Media Control (Spotify-style), Weather, and Calendar.

---

## 🛠 Tech Stack

- **Framework**: [Capacitor](https://capacitorjs.com/) (Cross-platform bridge)
- **UI Library**: [React](https://reactjs.org/) + [TypeScript](https://www.typescriptlang.org/)
- **Animations**: [Framer Motion](https://www.framer.com/motion/) (Spring physics & 3D transforms)
- **Icons**: [Lucide React](https://lucide.dev/)

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v18+)
- Android Studio (for Android builds)
- Xcode (for iOS builds - macOS only)

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/TheFadGhost/standby-pro.git
   cd standby-pro/app
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Build & Sync with Native Platforms:
   ```bash
   npm run build
   npx cap sync
   ```
4. Run on your device:
   ```bash
   npx cap run android
   # OR
   npx cap run ios
   ```

---

## 🏗 Architecture

The project follows **Clean Architecture** principles to ensure the UI remains independent of the platform logic:

- `lib/core`: Core utilities (Eco-loop, Night Mode logic, Animations).
- `lib/features/standby`: Main feature domain, presentation (widgets), and data management.
- `lib/shared`: Reusable high-polish UI components.

---

## 💰 Roadmap & Monetization

This project is currently **100% Open Source**. Future updates will include:
- **Designer Packs**: Exclusive premium themes for £0.99/mo.
- **Advanced Font Lab**: Experimental typography features.
- **Vibes Radio**: Integrated Lo-fi/YouTube streams.

---

## 🤝 Contributing

Contributions are welcome! If you have a cool theme or widget idea:
1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingTheme`).
3. Commit your Changes (`git commit -m 'Add AmazingTheme'`).
4. Push to the Branch (`git push origin feature/AmazingTheme`).
5. Open a Pull Request.

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

*Built with ❤️ for the [YT Channel Open Source Community](https://github.com/TheFadGhost).*
