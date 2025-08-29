import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ExerciseLogScreen extends StatefulWidget {
  const ExerciseLogScreen({super.key});

  @override
  State<ExerciseLogScreen> createState() => _ExerciseLogScreenState();
}

class _ExerciseLogScreenState extends State<ExerciseLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _exerciseNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedType = 'Cardio';
  String _selectedIntensity = 'Moderate';
  DateTime _selectedTime = DateTime.now();
  bool _isLoading = false;

  final List<String> _exerciseTypes = [
    'Cardio',
    'Strength Training',
    'Yoga',
    'Pilates',
    'Walking',
    'Running',
    'Cycling',
    'Swimming',
    'Dancing',
    'Other',
  ];

  final List<String> _intensityLevels = [
    'Light',
    'Moderate',
    'Vigorous',
    'High Intensity',
  ];

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _durationController.dispose();
    _caloriesController.dispose();
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

  Future<void> _saveExerciseLog() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Save to Firebase
      // await FirebaseService.saveExerciseLog({
      //   'name': _exerciseNameController.text,
      //   'duration': int.parse(_durationController.text),
      //   'calories': int.parse(_caloriesController.text),
      //   'type': _selectedType,
      //   'intensity': _selectedIntensity,
      //   'time': _selectedTime.toIso8601String(),
      //   'notes': _notesController.text,
      //   'userId': AuthService.currentUser?.id,
      //   'timestamp': DateTime.now().toIso8601String(),
      // });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Exercise logged successfully!'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Log Exercise'),
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
                          Icons.fitness_center,
                          size: 48,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Log Your Exercise',
                          style: AppTheme.headingStyle.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Track your fitness activities for better PCOD management',
                          style: AppTheme.subheadingStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Exercise Name
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: const InputDecoration(
                    labelText: 'Exercise Name *',
                    prefixIcon: Icon(Icons.fitness_center),
                    hintText: 'e.g., Morning walk, Yoga session',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter exercise name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Exercise Type and Intensity
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Exercise Type',
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: _exerciseTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedIntensity,
                        decoration: const InputDecoration(
                          labelText: 'Intensity',
                          prefixIcon: Icon(Icons.speed),
                        ),
                        items: _intensityLevels.map((intensity) {
                          return DropdownMenuItem(
                            value: intensity,
                            child: Text(intensity),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedIntensity = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
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
                
                // Duration and Calories
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Duration *',
                          prefixIcon: Icon(Icons.timer),
                          suffixText: 'minutes',
                          hintText: 'e.g., 30',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter duration';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _caloriesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Calories Burned',
                          prefixIcon: Icon(Icons.local_fire_department),
                          suffixText: 'kcal',
                          hintText: 'e.g., 150',
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (int.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Notes
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optional)',
                    prefixIcon: Icon(Icons.note),
                    hintText: 'How did you feel during the workout? Any challenges?',
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Save Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveExerciseLog,
                  child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Save Exercise Log'),
                ),
                
                const SizedBox(height: 16),
                
                // PCOD Exercise Tips
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
                              'PCOD Exercise Tip',
                              style: AppTheme.bodyStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Regular exercise helps improve insulin sensitivity and hormone balance. Aim for 150 minutes of moderate activity per week.',
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
                
                // Quick Exercise Suggestions
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Exercise Ideas',
                          style: AppTheme.bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildQuickExerciseSuggestion(
                          'Morning Walk',
                          '30 minutes of brisk walking',
                          Icons.directions_walk,
                          Color(0xFF4CAF50),
                        ),
                        const SizedBox(height: 8),
                        _buildQuickExerciseSuggestion(
                          'Yoga Session',
                          '45 minutes of gentle yoga',
                          Icons.self_improvement,
                          Color(0xFF9C27B0),
                        ),
                        const SizedBox(height: 8),
                        _buildQuickExerciseSuggestion(
                          'Strength Training',
                          '20 minutes with light weights',
                          Icons.fitness_center,
                          Color(0xFF2196F3),
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

  Widget _buildQuickExerciseSuggestion(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
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
      ),
    );
  }
}
