import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'food_screen.dart';
import 'body_screen.dart';
import 'mind_screen.dart';
import 'food_log_screen.dart';
import 'exercise_log_screen.dart';
import 'mood_log_screen.dart';
import '../widgets/affirmations_popup.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  late final GlobalKey<AffirmationsPopupState> _affirmationsKey;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _affirmationsKey = GlobalKey<AffirmationsPopupState>();
    _screens = [
      DashboardHome(affirmationsKey: _affirmationsKey),
      const FoodScreen(),
      const BodyScreen(),
      const MindScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          AffirmationsPopup(key: _affirmationsKey),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.lightTextColor,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Body',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Mind',
          ),
        ],
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  final GlobalKey<AffirmationsPopupState> affirmationsKey;
  
  const DashboardHome({super.key, required this.affirmationsKey});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
              child: Icon(
                Icons.person,
                size: 16,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Welcome ${user?.name ?? 'User'} to Polystyle',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick stats
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Progress',
                        style: AppTheme.headingStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.restaurant,
                              title: 'Food',
                              value: '3/3',
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.fitness_center,
                              title: 'Exercise',
                              value: '2/3',
                              color: Color(0xFF2196F3),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.psychology,
                              title: 'Mind',
                              value: '1/3',
                              color: Color(0xFF9C27B0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Recent articles
              Text(
                'Recent Articles',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildArticleCard(
                title: 'Understanding PCOD: A Complete Guide',
                description: 'Learn about the causes, symptoms, and management strategies for PCOD.',
                image: 'https://picsum.photos/80/80?random=1',
                readTime: '5 min read',
              ),
              
              const SizedBox(height: 12),
              
              _buildArticleCard(
                title: 'Nutrition Tips for PCOD Management',
                description: 'Discover the best foods to include and avoid in your PCOD diet.',
                image: 'https://picsum.photos/80/80?random=2',
                readTime: '3 min read',
              ),
              
              const SizedBox(height: 12),
              
              _buildArticleCard(
                title: 'Exercise Routines for PCOD',
                description: 'Effective workout plans designed specifically for women with PCOD.',
                image: 'https://picsum.photos/80/80?random=3',
                readTime: '4 min read',
              ),
              
              const SizedBox(height: 24),
              
              // Recent Q&A
              Text(
                'Recent Q&A',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildQACard(
                question: 'Can PCOD be cured completely?',
                answer: 'While PCOD cannot be cured completely, it can be managed effectively through lifestyle changes, diet, and medication.',
                tags: ['Treatment', 'Lifestyle'],
              ),
              
              const SizedBox(height: 12),
              
              _buildQACard(
                question: 'What exercises are best for PCOD?',
                answer: 'Cardio exercises, strength training, and yoga are particularly beneficial for managing PCOD symptoms.',
                tags: ['Exercise', 'Fitness'],
              ),
              
              const SizedBox(height: 24),
              
              // Affirmations button
              Card(
                child: InkWell(
                  onTap: () {
                    affirmationsKey.currentState?.showAffirmation();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daily Affirmation',
                                style: AppTheme.bodyStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Get your daily dose of positivity',
                                style: AppTheme.bodyStyle.copyWith(
                                  color: AppTheme.lightTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppTheme.lightTextColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Quick actions
              Text(
                'Quick Actions',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.add,
                      title: 'Log Food',
                      color: Color(0xFF4CAF50),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FoodLogScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.fitness_center,
                      title: 'Log Exercise',
                      color: Color(0xFF2196F3),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ExerciseLogScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.psychology,
                      title: 'Log Mood',
                      color: Color(0xFF9C27B0),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MoodLogScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String description,
    required String image,
    required String readTime,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
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
                  const SizedBox(height: 8),
                  Text(
                    readTime,
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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

  Widget _buildQACard({
    required String question,
    required String answer,
    required List<String> tags,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.lightTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  tag,
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTheme.bodyStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 