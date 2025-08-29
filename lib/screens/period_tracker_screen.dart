import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PeriodTrackerScreen extends StatefulWidget {
  const PeriodTrackerScreen({super.key});

  @override
  State<PeriodTrackerScreen> createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  
  final List<PeriodLog> _periodLogs = [
    PeriodLog(
      startDate: DateTime.now().subtract(const Duration(days: 25)),
      endDate: DateTime.now().subtract(const Duration(days: 19)),
      flow: 'Medium',
      symptoms: ['Cramps', 'Fatigue'],
      notes: 'Regular flow, manageable symptoms',
    ),
    PeriodLog(
      startDate: DateTime.now().subtract(const Duration(days: 55)),
      endDate: DateTime.now().subtract(const Duration(days: 49)),
      flow: 'Heavy',
      symptoms: ['Cramps', 'Bloating', 'Mood swings'],
      notes: 'Heavier than usual, took pain medication',
    ),
    PeriodLog(
      startDate: DateTime.now().subtract(const Duration(days: 85)),
      endDate: DateTime.now().subtract(const Duration(days: 79)),
      flow: 'Light',
      symptoms: ['Mild cramps'],
      notes: 'Lighter period, felt good overall',
    ),
  ];

  final List<DailyLog> _recentLogs = [
    DailyLog(
      date: DateTime.now().subtract(const Duration(days: 1)),
      mood: 'Calm',
      exercise: 'Yoga - 30 min',
      food: 'Healthy breakfast, balanced lunch',
      notes: 'Felt energetic today',
    ),
    DailyLog(
      date: DateTime.now().subtract(const Duration(days: 2)),
      mood: 'Stressed',
      exercise: 'Walking - 20 min',
      food: 'Skipped breakfast, had light dinner',
      notes: 'Busy day, didn\'t eat well',
    ),
    DailyLog(
      date: DateTime.now().subtract(const Duration(days: 3)),
      mood: 'Happy',
      exercise: 'Cardio - 45 min',
      food: 'Protein-rich meals throughout the day',
      notes: 'Great workout session',
    ),
    DailyLog(
      date: DateTime.now().subtract(const Duration(days: 4)),
      mood: 'Tired',
      exercise: 'Rest day',
      food: 'Comfort food, less healthy choices',
      notes: 'Needed rest, period symptoms',
    ),
    DailyLog(
      date: DateTime.now().subtract(const Duration(days: 5)),
      mood: 'Energetic',
      exercise: 'Strength training - 40 min',
      food: 'Balanced meals with lots of vegetables',
      notes: 'Felt strong during workout',
    ),
  ];

  // Period logging variables
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  String _selectedFlow = 'Medium';
  final List<String> _selectedSymptoms = [];
  bool _isLoading = false;

  final List<String> _flowOptions = [
    'Light',
    'Medium',
    'Heavy',
  ];

  final List<String> _symptomOptions = [
    'Cramps',
    'Fatigue',
    'Bloating',
    'Mood swings',
    'Headache',
    'Back pain',
    'Breast tenderness',
    'Acne',
    'Food cravings',
    'Insomnia',
    'Anxiety',
    'Depression',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Period Tracker'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Overview Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: AppTheme.primaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Period Overview',
                          style: AppTheme.headingStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: 'Last Period',
                            value: _formatDate(_periodLogs.first.startDate),
                            icon: Icons.event,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            title: 'Cycle Length',
                            value: '${_calculateAverageCycleLength()} days',
                            icon: Icons.timeline,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            title: 'Average Flow',
                            value: _getAverageFlow(),
                            icon: Icons.water_drop,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            title: 'Next Expected',
                            value: _getNextExpectedDate(),
                            icon: Icons.schedule,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Recent Period Logs
            Text(
              'Recent Period Logs',
              style: AppTheme.headingStyle.copyWith(fontSize: 20),
            ),
            
            const SizedBox(height: 16),
            
            ..._periodLogs.map((log) => _buildPeriodLogCard(log)),
            
            const SizedBox(height: 24),
            
            // Recent Daily Logs
            Text(
              'Recent Daily Logs',
              style: AppTheme.headingStyle.copyWith(fontSize: 20),
            ),
            
            const SizedBox(height: 16),
            
            ..._recentLogs.map((log) => _buildDailyLogCard(log)),
            
            const SizedBox(height: 24),
            
            // Add New Period Log Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showAddPeriodLogDialog();
                },
                icon: const Icon(Icons.add),
                label: const Text('Log New Period'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 12,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodLogCard(PeriodLog log) {
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
                  Icons.event,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_formatDate(log.startDate)} - ${_formatDate(log.endDate)}',
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getFlowColor(log.flow).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    log.flow,
                    style: AppTheme.bodyStyle.copyWith(
                      color: _getFlowColor(log.flow),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            if (log.symptoms.isNotEmpty) ...[
              Text(
                'Symptoms:',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: log.symptoms.map((symptom) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    symptom,
                    style: AppTheme.bodyStyle.copyWith(
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8),
            ],
            
            if (log.notes.isNotEmpty) ...[
              Text(
                'Notes:',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                log.notes,
                style: AppTheme.bodyStyle.copyWith(
                  color: AppTheme.lightTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDailyLogCard(DailyLog log) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  _formatDate(log.date),
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getMoodColor(log.mood).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    log.mood,
                    style: AppTheme.bodyStyle.copyWith(
                      color: _getMoodColor(log.mood),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: _buildLogItem('Exercise', log.exercise, Icons.fitness_center),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLogItem('Food', log.food, Icons.restaurant),
                ),
              ],
            ),
            
            if (log.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Notes: ${log.notes}',
                style: AppTheme.bodyStyle.copyWith(
                  color: AppTheme.lightTextColor,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: AppTheme.lightTextColor,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: AppTheme.bodyStyle.copyWith(
                fontSize: 12,
                color: AppTheme.lightTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.bodyStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showAddPeriodLogDialog() {
    _selectedStartDate = null;
    _selectedEndDate = null;
    _selectedFlow = 'Medium';
    _selectedSymptoms.clear();
    _notesController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.add_circle,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text('Log New Period'),
                ],
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Start Date
                      Text(
                        'Start Date *',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedStartDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedStartDate != null
                                    ? _formatDate(_selectedStartDate!)
                                    : 'Select start date',
                                style: AppTheme.bodyStyle.copyWith(
                                  color: _selectedStartDate != null
                                      ? AppTheme.textColor
                                      : AppTheme.lightTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // End Date
                      Text(
                        'End Date *',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _selectedStartDate ?? DateTime.now(),
                            firstDate: _selectedStartDate ?? DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _selectedEndDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedEndDate != null
                                    ? _formatDate(_selectedEndDate!)
                                    : 'Select end date',
                                style: AppTheme.bodyStyle.copyWith(
                                  color: _selectedEndDate != null
                                      ? AppTheme.textColor
                                      : AppTheme.lightTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Flow
                      Text(
                        'Flow *',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedFlow,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _flowOptions.map((flow) {
                          return DropdownMenuItem(
                            value: flow,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: _getFlowColor(flow),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(flow),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFlow = value!;
                          });
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Symptoms
                      Text(
                        'Symptoms',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _symptomOptions.map((symptom) {
                          final isSelected = _selectedSymptoms.contains(symptom);
                          return FilterChip(
                            label: Text(symptom),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedSymptoms.add(symptom);
                                } else {
                                  _selectedSymptoms.remove(symptom);
                                }
                              });
                            },
                            selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                            checkmarkColor: AppTheme.primaryColor,
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Notes
                      Text(
                        'Notes (Optional)',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Any additional notes about your period...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    _savePeriodLog(setState);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _savePeriodLog(StateSetter setDialogState) async {
    if (_selectedStartDate == null || _selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both start and end dates'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedEndDate!.isBefore(_selectedStartDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date cannot be before start date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setDialogState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Save to Firebase
      // await FirebaseService.savePeriodLog({
      //   'startDate': _selectedStartDate!.toIso8601String(),
      //   'endDate': _selectedEndDate!.toIso8601String(),
      //   'flow': _selectedFlow,
      //   'symptoms': _selectedSymptoms,
      //   'notes': _notesController.text,
      //   'userId': AuthService.currentUser?.id,
      //   'timestamp': DateTime.now().toIso8601String(),
      // });

      // Add to local list
      final newLog = PeriodLog(
        startDate: _selectedStartDate!,
        endDate: _selectedEndDate!,
        flow: _selectedFlow,
        symptoms: List.from(_selectedSymptoms),
        notes: _notesController.text,
      );

      setState(() {
        _periodLogs.insert(0, newLog);
      });

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Period logged successfully!'),
            backgroundColor: Colors.green,
          ),
        );
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
      setDialogState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  int _calculateAverageCycleLength() {
    if (_periodLogs.length < 2) return 28;
    
    int totalDays = 0;
    for (int i = 0; i < _periodLogs.length - 1; i++) {
      totalDays += _periodLogs[i].startDate.difference(_periodLogs[i + 1].startDate).inDays.abs();
    }
    
    return (totalDays / (_periodLogs.length - 1)).round();
  }

  String _getAverageFlow() {
    final flows = _periodLogs.map((log) => log.flow).toList();
    final flowCounts = <String, int>{};
    
    for (final flow in flows) {
      flowCounts[flow] = (flowCounts[flow] ?? 0) + 1;
    }
    
    String mostCommon = 'Medium';
    int maxCount = 0;
    
    flowCounts.forEach((flow, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommon = flow;
      }
    });
    
    return mostCommon;
  }

  String _getNextExpectedDate() {
    if (_periodLogs.isEmpty) return 'Not enough data';
    
    final lastPeriod = _periodLogs.first.startDate;
    final averageCycle = _calculateAverageCycleLength();
    final nextDate = lastPeriod.add(Duration(days: averageCycle));
    
    return _formatDate(nextDate);
  }

  Color _getFlowColor(String flow) {
    switch (flow.toLowerCase()) {
      case 'light':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'heavy':
        return Colors.red;
      default:
        return AppTheme.primaryColor;
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
}

class PeriodLog {
  final DateTime startDate;
  final DateTime endDate;
  final String flow;
  final List<String> symptoms;
  final String notes;

  PeriodLog({
    required this.startDate,
    required this.endDate,
    required this.flow,
    required this.symptoms,
    required this.notes,
  });
}

class DailyLog {
  final DateTime date;
  final String mood;
  final String exercise;
  final String food;
  final String notes;

  DailyLog({
    required this.date,
    required this.mood,
    required this.exercise,
    required this.food,
    required this.notes,
  });
}
