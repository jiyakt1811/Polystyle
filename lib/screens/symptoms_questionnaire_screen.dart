import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'premium_screen.dart';

class SymptomsQuestionnaireScreen extends StatefulWidget {
  const SymptomsQuestionnaireScreen({super.key});

  @override
  State<SymptomsQuestionnaireScreen> createState() => _SymptomsQuestionnaireScreenState();
}

class _SymptomsQuestionnaireScreenState extends State<SymptomsQuestionnaireScreen> {
  final List<SymptomQuestion> _questions = [
    SymptomQuestion(
      question: "Do you experience irregular menstrual cycles?",
      description: "Cycles longer than 35 days or shorter than 21 days",
    ),
    SymptomQuestion(
      question: "Do you have excessive hair growth on face, chest, or back?",
      description: "Hirsutism - male-pattern hair growth",
    ),
    SymptomQuestion(
      question: "Do you experience acne or oily skin?",
      description: "Persistent acne that doesn't respond to usual treatments",
    ),
    SymptomQuestion(
      question: "Do you have difficulty losing weight?",
      description: "Struggling with weight loss despite diet and exercise",
    ),
    SymptomQuestion(
      question: "Do you experience hair thinning or hair loss?",
      description: "Thinning hair on the scalp",
    ),
    SymptomQuestion(
      question: "Do you have dark patches on your skin?",
      description: "Acanthosis nigricans - dark, velvety patches",
    ),
    SymptomQuestion(
      question: "Do you experience mood swings or depression?",
      description: "Frequent mood changes or feelings of depression",
    ),
    SymptomQuestion(
      question: "Do you have difficulty getting pregnant?",
      description: "Infertility or difficulty conceiving",
    ),
  ];

  final Map<int, bool> _answers = {};
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Symptoms Assessment'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: AppTheme.borderColor,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
              
              const SizedBox(height: 20),
              
              // Question counter
              Text(
                'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                style: AppTheme.bodyStyle.copyWith(
                  color: AppTheme.lightTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Question card
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.help_outline,
                            size: 30,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Question
                        Text(
                          currentQuestion.question,
                          style: AppTheme.headingStyle.copyWith(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          currentQuestion.description,
                          style: AppTheme.bodyStyle.copyWith(
                            color: AppTheme.lightTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Answer buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _answerQuestion(false),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppTheme.primaryColor),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 16),
                            
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _answerQuestion(true),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Disclaimer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: Colors.orange.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Important Notice',
                          style: AppTheme.bodyStyle.copyWith(
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This assessment is for informational purposes only and should not replace professional medical diagnosis. Please consult your gynecologist for proper diagnosis.',
                      style: AppTheme.bodyStyle.copyWith(
                        color: Colors.orange.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _answerQuestion(bool answer) {
    _answers[_currentQuestionIndex] = answer;
    
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final positiveAnswers = _answers.values.where((answer) => answer).length;
    final percentage = (positiveAnswers / _questions.length * 100).round();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Assessment Results'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              percentage > 50 ? Icons.medical_services : Icons.check_circle,
              size: 60,
              color: percentage > 50 ? Colors.orange : Colors.green,
            ),
            const SizedBox(height: 16),
            Text(
              'You showed ${positiveAnswers} out of ${_questions.length} potential symptoms.',
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (percentage > 50) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Based on your responses, you may benefit from consulting a healthcare provider for proper evaluation.',
                  style: AppTheme.bodyStyle.copyWith(
                    color: Colors.orange.shade700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Your responses suggest a lower likelihood, but regular check-ups are always recommended.',
                  style: AppTheme.bodyStyle.copyWith(
                    color: Colors.green.shade700,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PremiumScreen(),
                ),
              );
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class SymptomQuestion {
  final String question;
  final String description;

  SymptomQuestion({
    required this.question,
    required this.description,
  });
} 