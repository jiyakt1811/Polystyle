# 🩺 Polystyle - Lifestyle Reimagined for Women with PCOD/PCOS

A comprehensive Flutter application designed specifically for women managing PCOD/PCOS through lifestyle tracking, nutrition monitoring, and wellness support.

## ✨ Features

### 🎯 Core Functionality

#### 🔐 Authentication & Onboarding
- **User Registration & Login**: Email/password and Google Sign-In
- **Onboarding Experience**: 3-step introduction to Polystyle
- **Diagnosis Assessment**: Personalized experience based on PCOD/PCOS diagnosis status
- **Symptoms Questionnaire**: For undiagnosed users to assess symptoms

#### 📊 Four-Pillar Tracking System

##### 🍎 Food & Nutrition
- Daily nutrition tracking (calories, protein, carbs)
- Meal logging with health scores
- PCOD-friendly food recommendations
- Nutritional insights and progress

##### 💪 Body & Fitness  
- Exercise tracking and activity monitoring
- Step counting and calorie burn
- Workout logging with duration and type
- Fitness progress visualization

##### 🧠 Mind & Wellness
- Mood tracking with emotional insights
- Journaling with guided prompts
- Stress management tools
- Mental wellness progress

##### 🏠 Dashboard & Analytics
- Comprehensive progress overview
- Daily activity summaries
- Recent articles and educational content
- Quick action buttons for logging

#### 💎 Premium Features
- **1:1 Doctor Consultation**: Direct access to gynecologists and nutritionists
- **AI-Powered Analysis**: Personalized insights based on health data
- **Premium Content**: Exclusive articles and guides
- **Community Support**: Connect with women on similar journeys

## 🎨 Design System

### Color Palette
- **Primary Color**: Deep Purple (#3E2557)
- **Background**: Clean White
- **Text**: Dark Gray (#333333)
- **Accent**: Light Gray (#666666)
- **Cards**: Light Gray (#F8F9FA)

### Typography
- **Font Family**: Poppins (Google Fonts)
- **Headings**: 28px, Bold (700)
- **Subheadings**: 18px, Medium (500)
- **Body Text**: 16px, Regular (400)
- **Buttons**: 16px, Semi-bold (600)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/jiyakt1811/Polystyle.git
   cd Polystyle
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   ```

## 🛠️ Development

### Project Structure
```
polystyle/
├── lib/
│   ├── main.dart                    # Main application entry point
│   ├── screens/                     # UI screens
│   │   ├── onboarding_screen.dart   # Welcome and introduction
│   │   ├── auth_screen.dart         # Authentication
│   │   ├── diagnosis_question_screen.dart # PCOD diagnosis check
│   │   ├── dashboard_screen.dart    # Main dashboard
│   │   ├── food_screen.dart         # Nutrition tracking
│   │   ├── body_screen.dart         # Fitness tracking
│   │   ├── mind_screen.dart         # Wellness tracking
│   │   ├── symptoms_questionnaire_screen.dart # Symptom assessment
│   │   └── premium_screen.dart      # Premium features
│   ├── services/
│   │   └── auth_service.dart        # Authentication logic
│   └── theme/
│       └── app_theme.dart           # Design system
├── assets/
│   └── images/                      # App images and icons
├── android/                         # Android-specific files
├── ios/                            # iOS-specific files
├── web/                            # Web platform files
└── pubspec.yaml                    # Dependencies and config
```

### Key Components

- **MyApp**: Main app widget with theme configuration
- **AuthWrapper**: Authentication state management
- **DashboardScreen**: Bottom navigation and screen management
- **AuthService**: User authentication and session management
- **AppTheme**: Consistent design system across the app

## 📱 Platform Support

- ✅ **Web** (Chrome, Firefox, Safari, Edge)
- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **macOS** (10.14+)
- ✅ **Windows** (10+)
- ✅ **Linux** (Ubuntu 18.04+)

## 🔧 Dependencies

### Core Dependencies
- **flutter**: SDK framework
- **cupertino_icons**: iOS-style icons
- **smooth_page_indicator**: Onboarding page indicators
- **google_fonts**: Custom typography

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality and style rules

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Women's health community for inspiration and feedback
- Medical professionals for guidance on PCOD/PCOS management
- Google Fonts for beautiful typography

## 📞 Support

For support, email support@polystyle.app or create an issue in this repository.

---

**Made with ❤️ for women's health and wellness**

*This app is for informational purposes only. Always consult with your healthcare provider for medical advice.*
