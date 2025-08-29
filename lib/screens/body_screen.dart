import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({super.key});

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  final List<ExerciseItem> _todayExercises = [
    ExerciseItem(name: 'Morning Walk', duration: 30, calories: 120, type: 'Cardio'),
    ExerciseItem(name: 'Yoga Session', duration: 45, calories: 150, type: 'Flexibility'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Body & Fitness'),
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
              // Activity overview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Activity',
                        style: AppTheme.headingStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActivityCard(
                              title: 'Steps',
                              value: '8,432',
                              target: '10,000',
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActivityCard(
                              title: 'Calories',
                              value: '270',
                              target: '300',
                              color: Color(0xFF2196F3),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActivityCard(
                              title: 'Minutes',
                              value: '75',
                              target: '60',
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
              
              // Exercise tracking
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Exercises',
                    style: AppTheme.headingStyle.copyWith(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddExerciseDialog();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Exercise'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Exercise items
              ..._todayExercises.map((exercise) => _buildExerciseCard(exercise)),
              
              const SizedBox(height: 24),
              
              // Workout recommendations
              Text(
                'Recommended Workouts',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildWorkoutCard(
                title: 'PCOD-Friendly Cardio',
                description: '30-minute low-impact cardio session with walking and cycling.',
                duration: '30 min',
                difficulty: 'Beginner',
                color: Color(0xFF4CAF50),
              ),
              
              const SizedBox(height: 12),
              
              _buildWorkoutCard(
                title: 'Strength Training',
                description: 'Full-body strength workout focusing on hormonal balance.',
                duration: '45 min',
                difficulty: 'Intermediate',
                color: Color(0xFF2196F3),
              ),
              
              const SizedBox(height: 12),
              
              _buildWorkoutCard(
                title: 'Yoga for PCOD',
                description: 'Gentle yoga poses to improve insulin sensitivity and reduce stress.',
                duration: '60 min',
                difficulty: 'All Levels',
                color: Color(0xFF9C27B0),
              ),
              
              const SizedBox(height: 24),
              
              // AI Workout Generator
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
                            'AI Workout Generator',
                            style: AppTheme.bodyStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Get personalized workout plans based on your PCOD symptoms, fitness level, and goals.',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.lightTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _showWorkoutGenerator();
                        },
                        child: const Text('Generate Workout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Exercise tips
              Text(
                'Exercise Tips for PCOD',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildTipCard(
                title: 'Start Slow',
                description: 'Begin with 10-15 minutes of walking daily and gradually increase intensity.',
                icon: Icons.trending_up,
                color: Color(0xFF4CAF50),
              ),
              
              const SizedBox(height: 12),
              
              _buildTipCard(
                title: 'Focus on Consistency',
                description: 'Regular moderate exercise is better than intense sporadic workouts.',
                icon: Icons.repeat,
                color: Color(0xFF2196F3),
              ),
              
              const SizedBox(height: 12),
              
              _buildTipCard(
                title: 'Include Strength Training',
                description: 'Building muscle helps improve insulin sensitivity and metabolism.',
                icon: Icons.fitness_center,
                color: Color(0xFFFF9800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
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

  Widget _buildExerciseCard(ExerciseItem exercise) {
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
                color: _getExerciseTypeColor(exercise.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getExerciseTypeIcon(exercise.type),
                color: _getExerciseTypeColor(exercise.type),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    exercise.type,
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.lightTextColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${exercise.duration} min • ${exercise.calories} cal',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard({
    required String title,
    required String description,
    required String duration,
    required String difficulty,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.fitness_center,
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
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    duration,
                    style: AppTheme.bodyStyle.copyWith(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    difficulty,
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _startWorkout(title);
                  },
                  child: const Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({
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

  Color _getExerciseTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Color(0xFF4CAF50);
      case 'strength':
        return Color(0xFF2196F3);
      case 'flexibility':
        return Color(0xFF9C27B0);
      case 'yoga':
        return Color(0xFFFF9800);
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getExerciseTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Icons.directions_run;
      case 'strength':
        return Icons.fitness_center;
      case 'flexibility':
        return Icons.accessibility_new;
      case 'yoga':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  void _showAddExerciseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: const Text('Exercise logging feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showWorkoutGenerator() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Workout Generator'),
        content: const Text('AI-powered workout generation feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _startWorkout(String workoutName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start $workoutName'),
        content: const Text('Workout tracking feature coming soon!'),
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

class ExerciseItem {
  final String name;
  final int duration;
  final int calories;
  final String type;

  ExerciseItem({
    required this.name,
    required this.duration,
    required this.calories,
    required this.type,
  });
} 