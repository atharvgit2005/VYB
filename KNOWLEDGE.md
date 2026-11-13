# Vyb - Project Knowledge Document

> **App Name**: Vyb  
> **Platform**: Cross-platform (iOS, Android via Expo / React Native, Web via Expo Web & Admin Web Portal)  
> **Repository**: [atharvgit2005/VYB](https://github.com/atharvgit2005/VYB)

---

## 📑 Table of Contents
1. [Project Overview](#project-overview)
2. [Tech Stack & Dependencies](#tech-stack--dependencies)
3. [Architecture & Folder Structure](#architecture--folder-structure)
4. [Routing & Screen Navigation](#routing--screen-navigation)
5. [Core Features & Modules](#core-features--modules)
   - [Authentication & Verification](#1-authentication--verification)
   - [Social Network & Feed](#2-social-network--feed)
   - [Vyb Swap (Dating System)](#3-vyb-swap-dating-system)
   - [Blind Dating System](#4-blind-dating-system)
   - [Coins, Likes & Monetization](#5-coins-likes--monetization)
   - [Campus Stories](#6-campus-stories)
   - [Events & Search](#7-events--search)
   - [Push Notifications & Analytics](#8-push-notifications--analytics)
   - [Admin Web Dashboard](#9-admin-web-dashboard)
6. [API & Network Architecture](#api--network-architecture)
7. [Updates & Deployment Pipeline](#updates--deployment-pipeline)
   - [Over-The-Air (OTA) Updates](#over-the-air-ota-updates)
   - [Native APK Updates](#native-apk-updates)
   - [GitHub Actions Workflows](#github-actions-workflows)
8. [Configuration & Environment Variables](#configuration--environment-variables)
9. [Developer Setup & Quick Commands](#developer-setup--quick-commands)

---

## 1. Project Overview

**Vyb** is a college social and dating platform built for university students. It combines a campus social feed (stories, posts, events, user profiles) with **Vyb Swap**—a dual-mode dating and matching experience featuring real-time blind dating, profile reveals, coin micro-transactions, and campus email verification (.edu / .ac.in).

The repository includes:
- **Mobile Application**: Expo Router React Native app supporting iOS, Android, and Web.
- **Admin Web Portal**: React + Vite web dashboard (`admin-web/`) for platform moderation, analytics, user reporting, and transactions.
- **CI/CD Automation**: GitHub Actions for automated OTA JS updates and EAS Cloud APK builds.

---

## 2. Tech Stack & Dependencies

### Mobile App Core
- **Framework**: Expo ~54.0.33 with Expo Router ~6.0.23
- **Runtime**: React Native 0.81.5 & React 19.1.0
- **Language**: TypeScript 5.9.2
- **Styling**: NativeWind v4.0.0 (Tailwind CSS for React Native)
- **Icons**: `lucide-react-native`
- **Animations & Gestures**: `react-native-reanimated` ~4.1.1, `react-native-gesture-handler` ~2.28.0
- **Storage**: `@react-native-async-storage/async-storage` ~2.2.0

### Native & Hardware Integrations
- **Payments**: `react-native-razorpay` ^2.3.1 (Coin & Likes pack purchases)
- **Notifications**: `expo-notifications` ~0.32.16
- **Firebase**: `@react-native-firebase/app`, `@react-native-firebase/analytics`, `@react-native-firebase/crashlytics`
- **Updates**: `expo-updates` ~29.0.16
- **Media**: `expo-image`, `expo-image-picker`, `expo-blur`, `expo-linear-gradient`

### Admin Web Portal (`admin-web/`)
- **Build Tool**: Vite
- **UI Framework**: React 19 + Tailwind CSS + Lucide Icons
- **HTTP Client**: Axios / Fetch API

### Backend Service (External)
- **API URL (Production)**: `https://campusconnect-api-nx9k.onrender.com/api`
- **API URL (Development)**: Automatic detection of dev host IP on port `5000` (`http://<IP>:5000/api`)
- **Image Cloud**: Cloudinary (`/upload` endpoint)

---

## 3. Architecture & Folder Structure

```
VYB/
├── app/                        # Expo Router Pages & Routes
│   ├── (tabs)/                 # Main Tab Navigation
│   │   ├── _layout.tsx         # Bottom Tabs & Top Mode Switch (Social vs Dating)
│   │   ├── index.tsx           # Home Social Feed & Campus Stories
│   │   ├── events.tsx          # Campus Events Page
│   │   ├── people.tsx          # People & User Search Page
│   │   ├── profile.tsx         # User Profile & Activity Hub
│   │   └── dating.tsx          # Vyb Swap Dating Main Hub (Hidden tab route)
│   ├── post/                   # Post details route
│   │   └── [id].tsx            # Single Post View with full comments
│   ├── user/                   # User profile details route
│   │   └── [id].tsx            # Public user profile & posts
│   ├── _layout.tsx             # Root Stack layout, AuthGuard & UpdateChecker
│   ├── auth.tsx                # Login / Signup via OTP & College Verification
│   ├── create-post.tsx         # Modal to upload and compose post
│   ├── dating-profile-setup.tsx# Dating profile creation wizard
│   ├── edit-profile.tsx        # Profile edit modal
│   ├── my-dating-profile.tsx   # View / Modify current user's dating profile
│   ├── onboarding.tsx          # App introduction carousel slides
│   └── profile-setup.tsx       # Initial onboarding profile wizard
│
├── components/                 # Reusable React Native Components
│   ├── AuthGuard.tsx           # Navigation guard for auth & incomplete profiles
│   ├── BlindDatingModal.tsx    # Live anonymous blind date chat UI & timers
│   ├── CommentModal.tsx        # Bottom sheet slide-up for post comments
│   ├── DataPolicyModal.tsx     # Privacy & data usage policy agreement
│   ├── DatingTermsModal.tsx    # Dating guidelines & community rules modal
│   ├── DatingTimerModal.tsx    # Countdown timer for Dating Mode launch
│   ├── ImageViewer.tsx         # Fullscreen image viewer
│   ├── PostItem.tsx            # Single post card with feed action buttons
│   ├── PostOptionsModal.tsx    # Options sheet (Report, Delete, Share)
│   ├── PostViewerModal.tsx     # Feed media lightbox
│   ├── StoryViewer.tsx         # Instagram-style story player
│   └── UpdateChecker.tsx       # OTA & Native update checker with reload UI
│
├── services/                   # Service API Integrations
│   ├── api.ts                  # Centralized HTTP request engine & endpoints
│   ├── analytics.ts            # Web analytics logger
│   └── analytics.native.ts     # Firebase Native Analytics wrapper
│
├── hooks/                      # Custom React Hooks
│   ├── useAnalytics.ts         # Screen view tracking hook
│   └── useNotifications.ts     # Expo Push Notification token setup
│
├── utils/                      # Helper Functions & Utilities
│   ├── imagePickerWeb.ts       # Web-compatible image selector fallback
│   └── imageUtils.ts           # Compression and image format converters
│
├── admin-web/                  # Standalone Admin Web Panel (React + Vite)
│   ├── src/
│   │   ├── pages/              # Admin pages (Dashboard, Users, Posts, Reports, etc.)
│   │   ├── api/                # Admin REST API wrapper
│   │   └── App.tsx             # Admin routing & global state
│   └── package.json            # Admin dependencies
│
├── .github/workflows/          # CI/CD Automation
│   ├── ota-update.yml          # Automatic JS update deployment on push
│   └── build-android.yml       # Cloud APK generation via EAS
│
├── app.json                    # Expo Configuration & Native Versioning
├── eas.json                    # Expo Application Services (EAS) Build Profiles
├── NATIVE_UPDATES.md           # Native update release workflow guide
├── OTA_UPDATES.md              # Over-the-Air update deployment guide
├── PRIVACY_POLICY.md           # App privacy disclosures
├── tailwind.config.js          # NativeWind Tailwind CSS config
└── tsconfig.json               # TypeScript Compiler options
```

---

## 4. Routing & Screen Navigation

Navigation is handled via **Expo Router (File-based Routing)** with a hybrid Stack + Bottom Tabs architecture:

### Root Stack Layout (`app/_layout.tsx`)
Wrapped by `GestureHandlerRootView`, `UpdateChecker`, and `AuthGuard`:
- `onboarding` -> Welcome carousel
- `auth` -> Phone/Email OTP & College verification
- `profile-setup` -> Mandatory basic profile info
- `edit-profile` -> Update bio, name, avatar
- `dating-profile-setup` -> Dating preferences wizard
- `create-post` -> Presentation Modal for publishing posts
- `post/[id]` -> Presentation Modal with slide animation for single post view
- `(tabs)` -> Main App shell with slide transitions

### Tab Navigation (`app/(tabs)/_layout.tsx`)
Supports desktop web sidebar layout (`>=1024px`) and floating mobile tab bar (`<1024px`).
Top bar contains a toggle to switch between **Social Mode** (Lime accent `#D4FF00`) and **Swap Vyb Dating Mode** (Pink accent `#EC4899`).
- `index` -> Social Feed & Stories
- `events` -> Campus Events
- `people` -> Directory & User Search
- `profile` -> User Profile, Settings, Active Chats, Received Likes
- `dating` -> Hidden tab route rendered when in Dating Mode

---

## 5. Core Features & Modules

### 1. Authentication & Verification (`app/auth.tsx`)
- **Phone & Email OTP**: Send/verify verification codes.
- **College Verification**: Verifies academic domain emails (`.edu`, `.ac.in`). Unlocks verified campus badges.
- **Token Management**: JWT saved in `AsyncStorage` (`userToken`) with `localStorage` fallback on Web.

### 2. Social Network & Feed (`app/(tabs)/index.tsx`, `components/PostItem.tsx`)
- **Feed**: Scrollable list of campus posts with pull-to-refresh & pagination.
- **Post Actions**: Like posts, open comment bottom sheet, preview image carousels.
- **Content Moderation**: Option to report posts or delete owned posts (`PostOptionsModal.tsx`).

### 3. Vyb Swap (Dating System) (`app/(tabs)/dating.tsx`)
- **Swipe Cards**: Profile recommendations with photo galleries, bios, interests, and dealbreakers.
- **Daily Free Likes**: Users get daily free likes, with option to buy additional like packs.
- **Profile Unlocking / Reveals**: Users who receive likes can reveal hidden profiles using coins or likes.
- **Direct Matching**: Start active chats upon mutual matches or direct chats using chat slots.

### 4. Blind Dating System (`components/BlindDatingModal.tsx`)
- **Real-Time Queue**: Join anonymous blind queue (`/blind/join`).
- **Timed Anonymous Chat**: Live text chat with a countdown timer.
- **Session Extensions**: Users can extend session duration using coins.
- **Mutual Reveal Vote**: Both users choose to reveal profiles or pass (`/blind/session/:id/choice`). If mutual, profiles unlock and chat transfers to active matches.

### 5. Coins, Likes & Monetization (`services/api.ts`)
- **In-App Currency**: Coins used for profile reveals, blind date extensions, and extra like packs.
- **Razorpay Integration**: Micro-transactions handled via `react-native-razorpay` calling `/payment/create-order` and `/payment/verify-payment`.

### 6. Campus Stories (`components/StoryViewer.tsx`)
- **24-Hour Stories**: View active campus stories at the top of the home feed.
- **Auto-Advance & Progress**: Instagram-style progress bars with tap left/right control.
- **Story Archives**: Users can view and manage their archived stories.

### 7. Events & Search (`app/(tabs)/events.tsx`, `app/(tabs)/people.tsx`)
- **Events Catalog**: View upcoming university events, filter by category, bookmark events.
- **People Discovery**: Search registered users by username, name, or major; send follow requests.

### 8. Push Notifications & Analytics (`hooks/useNotifications.ts`, `services/analytics.ts`)
- **Expo Notifications**: Registers device push tokens (`/notifications/register`) for match alerts, likes, and messages.
- **Analytics Engine**: Tracks screen views and user actions using Firebase Analytics on native devices.

### 9. Admin Web Dashboard (`admin-web/`)
- **Moderation Tools**: Overview metrics, user blocking/unblocking, report review, post/story deletion, and push notification broadcasts.

---

## 6. API & Network Architecture

All network calls are centralized in `services/api.ts` with auto-environment selection:

```typescript
export const USE_LOCAL_API = __DEV__;

const LOCAL_API_URL = `http://${getLocalIp()}:5000/api`;
const PRODUCTION_API_URL = 'https://campusconnect-api-nx9k.onrender.com/api';
export const API_URL = USE_LOCAL_API ? LOCAL_API_URL : PRODUCTION_API_URL;
```

### Request Pipeline & Error Handling
- **Authorization**: Attaches `Authorization: Bearer <userToken>` header to all requests.
- **Cold Start Timeout**: 60-second timeout (`AbortController`) to handle Render free-tier cold starts.
- **Automatic Retries**: Exponential retry logic up to `2` retries for network timeouts.

### Endpoints Overview
| Category | Primary Endpoints |
| :--- | :--- |
| **Auth** | `/auth/send-otp`, `/auth/verify-otp`, `/auth/college-verify/send`, `/auth/college-verify/verify` |
| **User** | `/users/me`, `/users/profile`, `/users/check-username`, `/users/search`, `/users/report`, `/users/block` |
| **Dating** | `/dating/recommendations`, `/dating/profile`, `/dating/buy-coins`, `/dating/accept-terms` |
| **Likes** | `/likes/my-status`, `/likes/like/:id`, `/likes/likes`, `/likes/reveal/:id`, `/likes/active-chats` |
| **Blind Date**| `/blind/join`, `/blind/leave`, `/blind/status`, `/blind/session/:id/message`, `/blind/session/:id/choice` |
| **Posts** | `/posts` (GET/POST), `/posts/:id/like`, `/posts/:id/comment`, `/posts/user/:userId` |
| **Stories** | `/stories` (GET/POST), `/stories/:id/view`, `/stories/archive` |
| **Payments** | `/payment/create-order`, `/payment/verify-payment` |
| **Upload** | `/upload` (Cloudinary base64 image upload) |

---

## 7. Updates & Deployment Pipeline

Vyb supports two update channels: **OTA Updates (JS/Assets)** and **Native Updates (APK)**.

### Over-The-Air (OTA) Updates
Pushes updated JavaScript code and asset changes instantly to installed devices without requiring an APK re-install.
- **Trigger**: Handled by `expo-updates`.
- **In-App Checker**: `UpdateChecker.tsx` checks for updates on app focus and prompts the user to refresh.
- **Commands**:
  ```bash
  # Push to preview
  eas update --branch preview --platform android --message "Fix feed layout"

  # Push to production
  eas update --branch production --platform android --message "Production release"
  ```

### Native APK Updates
Required when adding native libraries, changing `app.json` config, or updating React Native/Expo versions.
- **Versioning Rule**: `version` (e.g. `1.0.9`) and `versionCode` (e.g. `11`) in `app.json` MUST be incremented.
- **Commands**:
  ```bash
  # Local APK build
  npm run build:android:apk

  # Cloud APK build via EAS
  npm run build:android:cloud
  ```

### GitHub Actions Workflows
- **`ota-update.yml`**: Automatically publishes OTA JS updates on pushes to `main`.
- **`build-android.yml`**: Automatically triggers an EAS cloud native build and creates a GitHub Release when `app.json`, `eas.json`, or `android/` changes.

---

## 8. Configuration & Environment Variables

### Core Configuration Files
- **`app.json`**: Expo config, app name (`Vyb`), bundle identifier, native plugins (`expo-router`, `expo-updates`, `expo-build-properties`), and update URL.
- **`eas.json`**: EAS build profiles (`development`, `preview`, `production`).
- **`tailwind.config.js`**: NativeWind styling setup with standard custom theme rules.
- **`metro.config.js`**: Metro bundler configured for NativeWind CSS processing.

### Backend Environment Secrets (Render / Server)
- `GITHUB_TOKEN`: Access token for fetching release updates from private repos.
- `RAZORPAY_KEY_ID` & `RAZORPAY_KEY_SECRET`: Micro-transaction gateway keys.
- `CLOUDINARY_URL`: Asset storage service connection string.
- `EXPO_TOKEN`: Required for GitHub Actions to authorize EAS builds.

---

## 9. Developer Setup & Quick Commands

### Installation
```bash
# Clone the repository
git clone https://github.com/atharvgit2005/VYB.git
cd VYB

# Install dependencies
npm install
```

### Available Scripts
```bash
# Start Expo development server
npm start

# Run Web application
npm run dev:web

# Run Android on emulator / connected device
npm run android

# Build production web bundle
npm run build:web

# Clean cache and re-install dependencies
npm run clean
```

### Running Admin Web Portal
```bash
cd admin-web
npm install
npm run dev
```

---
*Document updated for Vyb v1.0.0 codebase.*
