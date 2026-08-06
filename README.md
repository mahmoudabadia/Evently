# Evently - Smart Event Management 📅

[![Flutter Version](https://img.shields.io/badge/Flutter-v3.12.1-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)]()

**Evently** is a sophisticated, production-ready Flutter application designed to streamline event discovery and management. Built with a focus on user experience, it combines high-performance architecture with a modern, intuitive interface to help users organize their social lives effortlessly.

---



## 📸 Preview

| Onboarding & Theme | Home Screen | Add Event |
| :---: | :---: | :---: |
| ![Onboarding](https://via.placeholder.com/200x400?text=Onboarding) | ![Home](https://via.placeholder.com/200x400?text=Home+Screen) | ![Add Event](https://via.placeholder.com/200x400?text=Add+Event) |

---

## 🚀 Core Features

### 🔹 Intelligent Event Discovery
*   **Categorized Views**: Browse events by type (Sports, Birthday, Meeting, Book Club, Exhibition).
*   **Dynamic UI**: Real-time updates for event lists and category switching.

### 🔹 Seamless Management
*   **Creation Suite**: Comprehensive form for adding events with titles, descriptions, dates, and times.
*   **Firebase Integration**: Real-time synchronization and persistence using **Cloud Firestore**.

### 🔹 Advanced Personalization
*   **Adaptive Theming**: Fully integrated Light and Dark modes with provider-based state management.
*   **Global Localization**: Full RTL support for **Arabic** and LTR for **English**.
*   **Resolution Awareness**: Optimized asset loading for x1, x2, and x3 display densities.

### 🔹 Robust Security
*   **Authentication Flow**: Secure registration, login, and password recovery.
*   **Input Validation**: Strict validation for all user entries to ensure data integrity.

---

## 🏗️ Architecture & Tools

The project follows a modular, provider-based architecture to ensure scalability and maintainability.

*   **Framework**: [Flutter](https://flutter.dev/)
*   **State Management**: [Provider](https://pub.dev/packages/provider)
*   **Backend**: [Firebase](https://firebase.google.com/) (Firestore, Authentication)
*   **Localization**: `flutter_localizations` with `.arb` templates.
*   **Navigation**: Clean routing system for seamless transitions.
*   **UI Components**: Reusable custom widgets for consistency.

---

## 📁 Project Roadmap

- [x] High-fidelity UI/UX Implementation
- [x] Firebase Integration (Firestore/Auth)
- [x] Multilingual Support (AR/EN)
- [x] Dynamic Theme Engine (Light/Dark)
- [ ] Push Notifications for Upcoming Events
- [ ] Social Features (Friends, Invites)
- [ ] Map View Integration

---

## 🛠️ Setup & Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/evently_app.git
    cd evently_app
    ```

2.  **Environment Setup**:
    *   Ensure Flutter is installed: `flutter doctor`
    *   Set up a Firebase project and add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).

3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

4.  **Run Application**:
    ```bash
    flutter run
    ```

---

## 🤝 Contribution

Contributions make the open-source community an amazing place to learn and create.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Developed with ❤️ by the Evently Team.
