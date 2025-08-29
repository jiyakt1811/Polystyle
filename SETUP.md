# Flutter Authentication App Setup Guide

## 🚀 Quick Start

This Flutter app includes:
- **Onboarding Screen**: 3-slide carousel with modern UI
- **Authentication**: Email/password + Google Sign-In
- **Firebase Integration**: User data stored in Firestore
- **Modern Design**: Clean UI with #3E2557 theme color and Poppins font

## 📱 Features

### Onboarding Flow
- Beautiful 3-slide carousel with smooth page indicator
- Modern icons and descriptions
- Skip button and "Get Started" button
- Clean, minimalist design with plenty of white space

### Authentication Screen
- Email and password fields with validation
- Google Sign-In button
- Toggle between login and signup modes
- Loading states and error handling
- Modern form design with rounded corners

### Home Screen
- User profile display with avatar
- Account information card
- Sign out functionality
- Success indicators

## 🔧 Setup Instructions

### 1. Firebase Project Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication:
   - Go to Authentication > Sign-in method
   - Enable Email/Password
   - Enable Google Sign-in
4. Create Firestore Database:
   - Go to Firestore Database
   - Create database in test mode
5. Get your Firebase config:
   - Go to Project Settings
   - Add your app (Android/iOS/Web)
   - Download configuration files

### 2. Update Firebase Configuration

Replace the placeholder values in `lib/firebase_options.dart`:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-actual-web-api-key',
  appId: 'your-actual-web-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  authDomain: 'your-actual-project-id.firebaseapp.com',
  storageBucket: 'your-actual-project-id.appspot.com',
);
```

### 3. Platform-Specific Setup

#### Android
1. Place `google-services.json` in `android/app/`
2. Add SHA-1 fingerprint to Firebase project settings
3. Update `android/app/build.gradle` if needed

#### iOS
1. Place `GoogleService-Info.plist` in `ios/Runner/`
2. Add bundle identifier to Firebase project settings

#### Web
1. Add Firebase config to `web/index.html`
2. Enable Google Sign-In for web

### 4. Run the App

```bash
# Install dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Or run on specific platform
flutter run -d chrome  # Web
flutter run -d android # Android
flutter run -d ios     # iOS
```

## 🎨 Design System

### Colors
- **Primary**: #3E2557 (Deep Purple)
- **Background**: White
- **Text**: #333333 (Dark Gray)
- **Light Text**: #666666 (Medium Gray)
- **Card Background**: #F8F9FA (Light Gray)
- **Border**: #E0E0E0 (Light Gray)

### Typography
- **Font**: Poppins (via Google Fonts)
- **Weights**: 400, 500, 600, 700
- **Sizes**: 16px (body), 18px (subheading), 28px (heading)

### Components
- Rounded corners (12px radius)
- Soft shadows and borders
- Proper spacing and padding
- Modern button styles

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── theme/
│   └── app_theme.dart       # Custom theme
├── services/
│   └── auth_service.dart    # Authentication logic
└── screens/
    ├── onboarding_screen.dart  # Onboarding flow
    ├── auth_screen.dart        # Login/signup
    └── home_screen.dart        # User dashboard
```

## 🔐 Security Features

- Email validation with regex
- Password strength requirements (min 6 chars)
- Secure Firebase authentication
- User data stored in Firestore with timestamps
- Proper error handling and user feedback
- Google Sign-In integration

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🐛 Troubleshooting

### Common Issues

1. **Firebase not initialized**
   - Check `firebase_options.dart` configuration
   - Ensure Firebase project is properly set up

2. **Google Sign-In not working**
   - Verify SHA-1 fingerprint (Android)
   - Check bundle identifier (iOS)
   - Ensure Google Sign-In is enabled in Firebase

3. **Build errors**
   - Run `flutter clean`
   - Run `flutter pub get`
   - Check platform-specific setup

4. **Authentication errors**
   - Verify Firebase Authentication is enabled
   - Check email/password provider settings
   - Ensure Firestore rules allow write access

## 📝 Next Steps

After setup, you can:
1. Customize the onboarding slides
2. Add more authentication providers
3. Implement password reset
4. Add email verification
5. Create user profile management
6. Add dark mode support
7. Implement offline functionality

## 🤝 Support

For issues or questions:
1. Check Firebase documentation
2. Review Flutter authentication guides
3. Verify all configuration files are correct
4. Ensure all dependencies are up to date 