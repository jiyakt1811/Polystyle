import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AffirmationsPopup extends StatefulWidget {
  const AffirmationsPopup({super.key});

  @override
  State<AffirmationsPopup> createState() => _AffirmationsPopupState();
}

class _AffirmationsPopupState extends State<AffirmationsPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final List<String> _affirmations = [
    '"I am worthy of love, respect, and care exactly as I am."',
    '"My body is strong and capable of healing and growth."',
    '"I choose to be kind to myself today and every day."',
    '"I am not defined by my condition, but by my strength and resilience."',
    '"Every step I take towards self-care is a victory."',
    '"I trust my body\'s wisdom and ability to heal."',
    '"I am patient with myself and my journey."',
    '"My worth is not determined by my appearance or health status."',
    '"I deserve to feel good and take care of myself."',
    '"I am surrounded by love and support."',
    '"I have the power to create positive change in my life."',
    '"I am grateful for my body and all it does for me."',
    '"I choose to focus on what I can control."',
    '"I am becoming stronger and healthier every day."',
    '"I trust the process and my body\'s natural rhythms."',
    '"I am enough, just as I am right now."',
    '"My journey is unique and beautiful."',
    '"I have overcome challenges before and I will again."',
    '"I am learning and growing through every experience."',
    '"I choose peace and acceptance in this moment."',
  ];

  String _currentAffirmation = '';
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _getNewAffirmation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _getNewAffirmation() {
    final random = DateTime.now().millisecond;
    setState(() {
      _currentAffirmation = _affirmations[random % _affirmations.length];
    });
  }

  void showAffirmation() {
    _getNewAffirmation();
    setState(() {
      _isVisible = true;
    });
    _animationController.forward();
  }

  void hideAffirmation() {
    _animationController.reverse().then((_) {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Material(
      color: Colors.black54,
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
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
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 20,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: hideAffirmation,
                            icon: const Icon(Icons.close),
                            color: AppTheme.lightTextColor,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Affirmation text
                      Text(
                        _currentAffirmation,
                        style: AppTheme.bodyStyle.copyWith(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                _getNewAffirmation();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('New Affirmation'),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppTheme.primaryColor),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: hideAffirmation,
                              icon: const Icon(Icons.check),
                              label: const Text('Got it!'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tip
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: AppTheme.primaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Take a moment to breathe and let this affirmation sink in.',
                                style: AppTheme.bodyStyle.copyWith(
                                  fontSize: 12,
                                  color: AppTheme.primaryColor,
                                ),
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
          },
        ),
      ),
    );
  }
}
