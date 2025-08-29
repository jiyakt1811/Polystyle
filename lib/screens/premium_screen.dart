import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Premium Access'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Welcome message
              Text(
                'Welcome ${user?.name ?? 'User'}',
                style: AppTheme.headingStyle,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'Unlock Premium Features',
                style: AppTheme.subheadingStyle,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Premium features card
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 1:1 Consultation
                      _buildFeatureCard(
                        icon: Icons.medical_services,
                        title: '1:1 Doctor Consultation',
                        description: 'Connect directly with gynecologists and nutritionists for personalized advice.',
                        color: Color(0xFFE91E63),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // AI-Powered Analysis
                      _buildFeatureCard(
                        icon: Icons.psychology,
                        title: 'AI-Powered Analysis',
                        description: 'Get personalized insights and recommendations based on your health data.',
                        color: Color(0xFF9C27B0),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Premium Content
                      _buildFeatureCard(
                        icon: Icons.article,
                        title: 'Premium Articles & Guides',
                        description: 'Access exclusive content on PCOD management, nutrition, and lifestyle.',
                        color: Color(0xFF3F51B5),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Community Support
                      _buildFeatureCard(
                        icon: Icons.group,
                        title: 'Community Support',
                        description: 'Join a supportive community of women on similar health journeys.',
                        color: Color(0xFF4CAF50),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Advanced Tracking
                      _buildFeatureCard(
                        icon: Icons.analytics,
                        title: 'Advanced Health Tracking',
                        description: 'Track symptoms, mood, sleep, and more with detailed analytics.',
                        color: Color(0xFFFF9800),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Pricing section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹',
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 32,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                            '999',
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 48,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                            '/month',
                            style: AppTheme.bodyStyle.copyWith(
                              color: AppTheme.lightTextColor,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        'Start your 7-day free trial',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.lightTextColor,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement payment integration
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Payment integration coming soon!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Start Free Trial',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Text(
                        'Cancel anytime • No commitment',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.lightTextColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                size: 25,
                color: color,
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    description,
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.lightTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 