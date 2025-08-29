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
  
  String _selectedMood = 'Happy';
  String _selectedEnergyLevel = 'Moderate';
  String _selectedStressLevel = 'Low';
  DateTime _selectedTime = DateTime.now();
  bool _isLoading = false;

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

  @override
  void dispose() {
    _notesController.dispose();
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
      //   'userId': AuthService.currentUser?.id,
      //   'timestamp': DateTime.now().toIso8601String(),
      // });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Mood logged successfully!'),
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
}
