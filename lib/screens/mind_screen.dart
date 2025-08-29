import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'mood_log_screen.dart';
import '../widgets/affirmations_popup.dart';

class MindScreen extends StatefulWidget {
  const MindScreen({super.key});

  @override
  State<MindScreen> createState() => _MindScreenState();
}

class _MindScreenState extends State<MindScreen> {
  String _currentMood = 'Happy';
  final List<String> _moods = ['Happy', 'Calm', 'Stressed', 'Anxious', 'Energetic', 'Tired'];
  final GlobalKey<AffirmationsPopupState> _affirmationsKey = GlobalKey<AffirmationsPopupState>();
  final List<JournalEntry> _journalEntries = [
    JournalEntry(
      date: DateTime.now().subtract(const Duration(days: 1)),
      prompt: 'How did you feel about your body today?',
      content: 'I felt more confident today. The yoga session really helped me feel connected to my body.',
      mood: 'Calm',
    ),
    JournalEntry(
      date: DateTime.now().subtract(const Duration(days: 2)),
      prompt: 'What\'s one thing you\'re grateful for?',
      content: 'I\'m grateful for my supportive family who understands my PCOD journey.',
      mood: 'Happy',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Mind & Wellness'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mood tracking
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How are you feeling today?',
                        style: AppTheme.headingStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _currentMood,
                        decoration: const InputDecoration(
                          labelText: 'Select your mood',
                          border: OutlineInputBorder(),
                        ),
                        items: _moods.map((mood) {
                          return DropdownMenuItem(
                            value: mood,
                            child: Row(
                              children: [
                                Icon(
                                  _getMoodIcon(mood),
                                  color: _getMoodColor(mood),
                                ),
                                const SizedBox(width: 8),
                                Text(mood),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _currentMood = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _saveMood();
                          },
                          child: const Text('Save Mood'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Daily affirmation
              Card(
                child: InkWell(
                  onTap: () {
                    _affirmationsKey.currentState?.showAffirmation();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daily Affirmation',
                              style: AppTheme.bodyStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.lightTextColor,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tap to get your daily dose of positivity and self-love',
                          style: AppTheme.bodyStyle.copyWith(
                            fontSize: 14,
                            color: AppTheme.lightTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Journal section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Journal',
                    style: AppTheme.headingStyle.copyWith(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MoodLogScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('New Entry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Journal entries
              if (_journalEntries.isNotEmpty) ...[
                ..._journalEntries.map((entry) => _buildJournalCard(entry)),
              ] else ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.edit_note,
                          size: 48,
                          color: AppTheme.lightTextColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No journal entries yet',
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.lightTextColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start your journaling journey today',
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.lightTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Sleep tracking
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bedtime,
                            color: Color(0xFF9C27B0),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Sleep Tracking',
                            style: AppTheme.bodyStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSleepCard(
                              title: 'Last Night',
                              hours: '7.5',
                              quality: 'Good',
                              color: Color(0xFF9C27B0),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSleepCard(
                              title: 'Average',
                              hours: '7.2',
                              quality: 'Fair',
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _logSleep();
                        },
                        child: const Text('Log Sleep'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9C27B0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Wellness tips
              Text(
                'Mental Wellness Tips',
                style: AppTheme.headingStyle.copyWith(fontSize: 20),
              ),
              
              const SizedBox(height: 16),
              
              _buildWellnessTipCard(
                title: 'Practice Mindfulness',
                description: 'Take 5 minutes daily to focus on your breath and be present.',
                icon: Icons.self_improvement,
                color: Color(0xFF4CAF50),
              ),
              
              const SizedBox(height: 12),
              
              _buildWellnessTipCard(
                title: 'Connect with Others',
                description: 'Share your journey with supportive friends or join PCOD support groups.',
                icon: Icons.group,
                color: Color(0xFF2196F3),
              ),
              
              const SizedBox(height: 12),
              
              _buildWellnessTipCard(
                title: 'Celebrate Small Wins',
                description: 'Acknowledge and celebrate your progress, no matter how small.',
                icon: Icons.celebration,
                color: Color(0xFFFF9800),
              ),
              
              const SizedBox(height: 24),
              
              // AI Wellness Coach
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
                            'AI Wellness Coach',
                            style: AppTheme.bodyStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Get personalized mental wellness advice and coping strategies for PCOD-related stress.',
                        style: AppTheme.bodyStyle.copyWith(
                          color: AppTheme.lightTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _showWellnessCoach();
                        },
                        child: const Text('Talk to Coach'),
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
        AffirmationsPopup(key: _affirmationsKey),
      ],
    );
  }

  Widget _buildJournalCard(JournalEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getMoodIcon(entry.mood),
                  color: _getMoodColor(entry.mood),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  entry.mood,
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _getMoodColor(entry.mood),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(entry.date),
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.lightTextColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              entry.prompt,
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              entry.content,
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.lightTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepCard({
    required String title,
    required String hours,
    required String quality,
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
          Text(
            title,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$hours hrs',
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            quality,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 10,
              color: AppTheme.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessTipCard({
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

  IconData _getMoodIcon(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'calm':
        return Icons.sentiment_satisfied;
      case 'stressed':
        return Icons.sentiment_neutral;
      case 'anxious':
        return Icons.sentiment_dissatisfied;
      case 'energetic':
        return Icons.sentiment_very_satisfied;
      case 'tired':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Colors.green;
      case 'calm':
        return Colors.blue;
      case 'stressed':
        return Colors.orange;
      case 'anxious':
        return Colors.red;
      case 'energetic':
        return Colors.purple;
      case 'tired':
        return Colors.grey;
      default:
        return AppTheme.primaryColor;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _saveMood() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mood saved: $_currentMood'),
        backgroundColor: _getMoodColor(_currentMood),
      ),
    );
  }





  void _logSleep() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Sleep'),
        content: const Text('Sleep tracking feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showWellnessCoach() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Wellness Coach'),
        content: const Text('AI-powered wellness coaching feature coming soon!'),
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

class JournalEntry {
  final DateTime date;
  final String prompt;
  final String content;
  final String mood;

  JournalEntry({
    required this.date,
    required this.prompt,
    required this.content,
    required this.mood,
  });
} 