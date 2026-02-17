# Myson - Premium Tech Store

A premium Flutter mobile application inspired by the sleek and modern aesthetic of high-end consumer technology.

## Overview

Myson is a concept store application featuring cutting-edge home and personal care products. The app prioritizes visual excellence, smooth performance, and a user-centric shopping experience.

## Key Features

- **Product Discovery**: Browse a curated catalog of premium products.
- **Dynamic Categories**: Effortlessly navigate through Vacuums, Hair Care, and Air Quality solutions.
- **Glassmorphic Navigation**: Modern and interactive navigation bar.
- **Seamless Cart System**: Add to bag and manage selections with ease.
- **Adaptive UI**: Optimized layouts to prevent overflow and ensure visual consistency.

## Technical Improvements (Phase 5)

### 🛠 Build System & Infrastructure
- **SDK Optimization**: Upgraded to `compileSdk 36` to support the latest Android APIs.
- **Gradle Refresh**: Updated Android Gradle Plugin to `8.9.1` and Gradle wrapper to `8.11.1`.
- **Kotlin Update**: Bumped Kotlin version to `2.1.0` for enhanced compatibility.

### 🎨 UI & UX Refinement
- **Overflow Resolution**: Fixed layout issues in `ProductCard` (bottom overflow) by optimizing padding and typography.
- **Asset Migration**: Migrated product images to local assets to bypass 403 CDN errors, ensuring consistent loading.
- **Image Presentation**: Switched to `BoxFit.cover` in product cards for better visual integration.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Use `flutter run` to launch the application.

---
*Built with ❤️ using Flutter*
