import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MoodLogScreen extends StatefulWidget {
  const MoodLogScreen({super.key});

  @override
  State<MoodLogScreen> createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends State<MoodLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _journalController = TextEditingController();
  
  String _selectedMood = 'Happy';
  String _selectedEnergyLevel = 'Moderate';
  String _selectedStressLevel = 'Low';
  String _selectedJournalTime = 'Morning';
  DateTime _selectedTime = DateTime.now();
  bool _isLoading = false;
  
  // Journal answers
  final Map<String, String> _journalAnswers = {};

  final List<String> _moods = [
    'Happy',
    'Calm',
    'Energetic',
    'Anxious',
    'Stressed',
    'Tired',
    'Irritable',
    'Confident',
    'Overwhelmed',
    'Grateful',
    'Frustrated',
    'Peaceful',
  ];

  final List<String> _energyLevels = [
    'Very Low',
    'Low',
    'Moderate',
    'High',
    'Very High',
  ];

  final List<String> _stressLevels = [
    'Very Low',
    'Low',
    'Moderate',
    'High',
    'Very High',
  ];

  final List<String> _journalTimes = [
    'Morning',
    'Night',
  ];

  // Morning journal questions
  final List<JournalQuestion> _morningQuestions = [
    JournalQuestion(
      id: 'morning_1',
      question: 'How did you sleep last night?',
      options: [
        'Very well (8+ hours)',
        'Good (6-7 hours)',
        'Fair (5-6 hours)',
        'Poor (less than 5 hours)',
        'Other',
      ],
    ),
    JournalQuestion(
      id: 'morning_2',
      question: 'What\'s your energy level this morning?',
      options: [
        'Very energetic',
        'Moderately energetic',
        'A bit tired',
        'Very tired',
        'Other',
      ],
    ),
    JournalQuestion(
      id: 'morning_3',
      question: 'What\'s your main focus for today?',
      options: [
        'Work/Study',
        'Self-care',
        'Exercise',
        'Social activities',
        'Other',
      ],
    ),
  ];

  // Night journal questions
  final List<JournalQuestion> _nightQuestions = [
    JournalQuestion(
      id: 'night_1',
      question: 'How productive was your day?',
      options: [
        'Very productive',
        'Moderately productive',
        'Somewhat productive',
        'Not very productive',
        'Other',
      ],
    ),
    JournalQuestion(
      id: 'night_2',
      question: 'What was the highlight of your day?',
      options: [
        'Work/Study achievement',
        'Personal time',
        'Social interaction',
        'Exercise/Activity',
        'Other',
      ],
    ),
    JournalQuestion(
      id: 'night_3',
      question: 'What are you grateful for today?',
      options: [
        'Health and wellness',
        'Relationships',
        'Personal growth',
        'Simple pleasures',
        'Other',
      ],
    ),
  ];

  @override
  void dispose() {
    _notesController.dispose();
    _journalController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _saveMoodLog() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Save to Firebase
      // await FirebaseService.saveMoodLog({
      //   'mood': _selectedMood,
      //   'energyLevel': _selectedEnergyLevel,
      //   'stressLevel': _selectedStressLevel,
      //   'time': _selectedTime.toIso8601String(),
      //   'notes': _notesController.text,
      //   'journalTime': _selectedJournalTime,
      //   'journalAnswers': _journalAnswers,
      //   'userId': AuthService.currentUser?.id,
      //   'timestamp': DateTime.now().toIso8601String(),
      // });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Mood and journal logged successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
      case 'energetic':
      case 'confident':
      case 'grateful':
        return Colors.green;
      case 'calm':
      case 'peaceful':
        return Colors.blue;
      case 'tired':
        return Colors.orange;
      case 'anxious':
      case 'stressed':
      case 'overwhelmed':
      case 'frustrated':
        return Colors.red;
      case 'irritable':
        return Colors.purple;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getMoodIcon(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'calm':
        return Icons.sentiment_satisfied;
      case 'energetic':
        return Icons.bolt;
      case 'anxious':
        return Icons.sentiment_dissatisfied;
      case 'stressed':
        return Icons.sentiment_very_dissatisfied;
      case 'tired':
        return Icons.bedtime;
      case 'irritable':
        return Icons.mood_bad;
      case 'confident':
        return Icons.psychology;
      case 'overwhelmed':
        return Icons.warning;
      case 'grateful':
        return Icons.favorite;
      case 'frustrated':
        return Icons.thumb_down;
      case 'peaceful':
        return Icons.spa;
      default:
        return Icons.sentiment_neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Log Mood'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 48,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Log Your Mood',
                          style: AppTheme.headingStyle.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Track your emotional well-being for better mental health',
                          style: AppTheme.subheadingStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Mood Selection
                Text(
                  'How are you feeling right now?',
                  style: AppTheme.headingStyle.copyWith(fontSize: 18),
                ),
                
                const SizedBox(height: 16),
                
                // Mood Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _moods.length,
                  itemBuilder: (context, index) {
                    final mood = _moods[index];
                    final isSelected = _selectedMood == mood;
                    
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedMood = mood;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                            ? _getMoodColor(mood).withValues(alpha: 0.2)
                            : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected 
                              ? _getMoodColor(mood)
                              : AppTheme.borderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getMoodIcon(mood),
                              color: _getMoodColor(mood),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              mood,
                              style: AppTheme.bodyStyle.copyWith(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? _getMoodColor(mood) : AppTheme.textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Time
                InkWell(
                  onTap: _selectTime,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: AppTheme.bodyStyle,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Energy and Stress Levels
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedEnergyLevel,
                        decoration: const InputDecoration(
                          labelText: 'Energy Level',
                          prefixIcon: Icon(Icons.battery_charging_full),
                        ),
                        items: _energyLevels.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedEnergyLevel = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedStressLevel,
                        decoration: const InputDecoration(
                          labelText: 'Stress Level',
                          prefixIcon: Icon(Icons.speed),
                        ),
                        items: _stressLevels.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStressLevel = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Notes
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optional)',
                    prefixIcon: Icon(Icons.note),
                    hintText: 'What\'s on your mind? Any specific thoughts or feelings?',
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Journaling Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.edit_note,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daily Journaling',
                              style: AppTheme.headingStyle.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Journal time selection
                        DropdownButtonFormField<String>(
                          value: _selectedJournalTime,
                          decoration: const InputDecoration(
                            labelText: 'Journal Time',
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          items: _journalTimes.map((time) {
                            return DropdownMenuItem(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedJournalTime = value!;
                              _journalAnswers.clear();
                            });
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Journal questions
                        ...(_selectedJournalTime == 'Morning' ? _morningQuestions : _nightQuestions)
                            .map((question) => _buildJournalQuestion(question)),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Save Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveMoodLog,
                  child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Save Mood Log'),
                ),
                
                const SizedBox(height: 16),
                
                // Mental Health Tips
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: AppTheme.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Mental Health Tip',
                              style: AppTheme.bodyStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Regular mood tracking helps identify patterns and triggers. Practice self-compassion and remember that all emotions are valid.',
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.lightTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Mood Tracking Benefits
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benefits of Mood Tracking',
                          style: AppTheme.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildBenefitItem(
                          'Identify Patterns',
                          'Understand what affects your mood',
                          Icons.trending_up,
                        ),
                        const SizedBox(height: 8),
                        _buildBenefitItem(
                          'Track Progress',
                          'See improvements over time',
                          Icons.analytics,
                        ),
                        const SizedBox(height: 8),
                        _buildBenefitItem(
                          'Better Self-Awareness',
                          'Recognize triggers and coping strategies',
                          Icons.psychology,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    String title,
    String description,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: AppTheme.bodyStyle.copyWith(
                  color: AppTheme.lightTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJournalQuestion(JournalQuestion question) {
    final currentAnswer = _journalAnswers[question.id] ?? '';
    final showCustomInput = currentAnswer == 'Other' || 
        (currentAnswer.isNotEmpty && !question.options.contains(currentAnswer));

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Options
          ...question.options.map((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: currentAnswer.isEmpty ? null : currentAnswer,
            onChanged: (value) {
              setState(() {
                if (value == 'Other') {
                  _journalAnswers[question.id] = 'Other';
                } else {
                  _journalAnswers[question.id] = value!;
                }
              });
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
          )),
          
          // Custom input for "Other" option
          if (showCustomInput) ...[
            const SizedBox(height: 8),
            TextFormField(
              initialValue: currentAnswer == 'Other' ? '' : currentAnswer,
              decoration: const InputDecoration(
                labelText: 'Your answer',
                hintText: 'Type your own answer...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _journalAnswers[question.id] = value;
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

class JournalQuestion {
  final String id;
  final String question;
  final List<String> options;

  JournalQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}
