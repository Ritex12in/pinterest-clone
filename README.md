# 📌 Pinterest Clone (Flutter)

This is a Pinterest-like mobile app built using **Flutter** as part of an internship assignment. The goal of this project was not just to copy the UI, but to build something that feels like a **real app** with proper structure, navigation, loading states, and authentication.

The app supports **browsing without login**, and only asks the user to sign in when they try to access restricted features like profile, messages, or saving pins.
---
Demo video: https://drive.google.com/drive/folders/1yOwOgJRrJcggA0WJLzNzXswc-OKouSJm?usp=drive_link
---

## ✨ What’s Inside

### 🏠 Feed
- Pinterest-style masonry grid
- Infinite scrolling
- Shimmer loading placeholders
- Smooth hero animation to detail page
- Uses average image color as placeholder while images load

### 🔍 Search
- Search home page with featured carousel
- Category/section cards for discovery
- Search input page with suggestions
- Search results page with masonry layout

### 📌 Pin Detail
- Fullscreen pin preview
- Related images bottom sheet
- Smooth hero transition from feed

### 👤 Profile
- Tabs: Pins, Boards, Collages
- Proper empty states
- Account / Settings page
- User avatar and profile header

### 💬 Messages
- Inbox UI (static, for demo purpose)

### 🔐 Login (Clerk)
- Login / Signup using Clerk
- Session is remembered
- Logout supported
- You can use the app without login, but:
  - Profile, Messages, Save, etc. require login

### 🚀 App Startup
- Native splash screen
- Splash stays until session is restored
- No login screen flash
- No wrong screen shown at startup

### 🌗 Theme
- Supports system Light & Dark mode

---

## 🧱 Tech Stack

- Flutter
- Riverpod (state management)
- GoRouter (navigation)
- Dio (networking)
- Pexels API (images)
- Clerk (authentication)
- Flutter Native Splash
- CachedNetworkImage
- Shimmer

---

## 🏗️ How the App Is Structured

- Clean, feature-based folder structure
- Repository pattern for data
- Riverpod for app state
- GoRouter ShellRoute for bottom navigation
- UI, logic, and data kept separate as much as possible

---

## 📱 Screens Implemented

- Feed
- Search Home
- Search Results
- Pin Detail
- Profile (Pins / Boards / Collages)
- Messages
- Account / Settings
- Login / Signup

---

## 🔐 How Login Works

- App opens directly to Feed (no login needed)
- When user tries to open:
  - Profile
  - Messages
  - Or save a pin  
  → Login screen opens
- After successful login:
  → Login screen closes and user continues where they left off

---

## 🖼️ API Used

- **Pexels API**
  - Used for feed and search images

---

## 🛠️ How to Run the Project

1. Clone the repository
2. Run:

```bash
flutter pub get
```
3. Create this file:
```bash
lib/core/constants/api_keys.dart
```
4. Add your keys:  
const PEXELS_API_KEY = "YOUR_PEXELS_KEY";  
const CLERK_PUBLISHABLE_KEY = "YOUR_CLERK_KEY";

Run the app:
```bash
flutter run
```
