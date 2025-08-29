import "package:flutter/material.dart";
import "theme/app_theme.dart";
import "screens/onboarding_screen.dart";
import "screens/home_screen.dart";
import "services/auth_service.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Auth Onboarding App",
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    
    if (authService.isAuthenticated) {
      // User is signed in
      return const HomeScreen();
    }
    
    // User is not signed in
    return const OnboardingScreen();
  }
}
