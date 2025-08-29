import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'food_log_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final List<FoodItem> _todayFood = [
    FoodItem(name: 'Oatmeal with berries', calories: 250, category: 'Breakfast', healthScore: 85),
    FoodItem(name: 'Grilled chicken salad', calories: 320, category: 'Lunch', healthScore: 90),
    FoodItem(name: 'Greek yogurt', calories: 120, category: 'Snack', healthScore: 88),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Food & Nutrition'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nutrition overview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Nutrition',
                        style: AppTheme.headingStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildNutritionCard(
                              title: 'Calories',
                              value: '690',
                              target: '1200',
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildNutritionCard(
                              title: 'Protein',
                              value: '45g',
                              target: '60g',
                              color: Color(0xFF2196F3),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildNutritionCard(
                              title: 'Carbs',
                              value: '85g',
                              target: '150g',
                              color: Color(0xFFFF9800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Food tracking
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Food',
                    style: AppTheme.headingStyle.copyWith(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FoodLogScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Food'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Food items
              ..._todayFood.map((food) => _buildFoodCard(food)),
              
              const SizedBox(height: 24),
              
              // Diet suggestions
              Text(
                'Diet Suggestions',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildSuggestionCard(
                title: 'Low-GI Breakfast',
                description: 'Try steel-cut oats with nuts and berries for stable blood sugar.',
                icon: Icons.breakfast_dining,
                color: Color(0xFF4CAF50),
              ),
              
              const SizedBox(height: 12),
              
              _buildSuggestionCard(
                title: 'Anti-Inflammatory Lunch',
                description: 'Include fatty fish, leafy greens, and turmeric in your meals.',
                icon: Icons.restaurant,
                color: Color(0xFF2196F3),
              ),
              
              const SizedBox(height: 12),
              
              _buildSuggestionCard(
                title: 'Evening Snack',
                description: 'Opt for Greek yogurt with cinnamon or a handful of almonds.',
                icon: Icons.local_cafe,
                color: Color(0xFFFF9800),
              ),
              
              const SizedBox(height: 24),
              
              // AI Nutrition Analysis
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.psychology,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'AI Nutrition Analysis',
                            style: AppTheme.bodyStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your current diet shows good balance with adequate protein and fiber. Consider adding more omega-3 rich foods for better hormonal balance.',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.lightTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _showDetailedAnalysis();
                        },
                        child: const Text('Get Detailed Analysis'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                        ),
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

  Widget _buildNutritionCard({
    required String title,
    required String value,
    required String target,
    required Color color,
  }) {
    final progress = double.tryParse(value.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    final targetValue = double.tryParse(target.replaceAll(RegExp(r'[^\d.]'), '')) ?? 1;
    final percentage = (progress / targetValue).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            'of $target',
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 10,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(FoodItem food) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getCategoryColor(food.category).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getCategoryIcon(food.category),
                color: _getCategoryColor(food.category),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    food.category,
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.lightTextColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${food.calories} calories',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getHealthScoreColor(food.healthScore).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${food.healthScore}%',
                    style: AppTheme.bodyStyle.copyWith(
                      color: _getHealthScoreColor(food.healthScore),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Healthy',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.lightTextColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return Color(0xFF4CAF50);
      case 'lunch':
        return Color(0xFF2196F3);
      case 'dinner':
        return Color(0xFF9C27B0);
      case 'snack':
        return Color(0xFFFF9800);
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return Icons.breakfast_dining;
      case 'lunch':
        return Icons.restaurant;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.local_cafe;
      default:
        return Icons.restaurant;
    }
  }

  Color _getHealthScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }



  void _showDetailedAnalysis() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Nutrition Analysis'),
        content: const Text('AI-powered nutrition analysis feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class FoodItem {
  final String name;
  final int calories;
  final String category;
  final int healthScore;

  FoodItem({
    required this.name,
    required this.calories,
    required this.category,
    required this.healthScore,
  });
} 