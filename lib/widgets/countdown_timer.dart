import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/theme_colors.dart';

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onTimerComplete;
  final double? apiProgress;
  final int? estimatedMinutes;

  const CountdownTimer({
    Key? key,
    required this.initialSeconds,
    this.onTimerComplete,
    this.apiProgress,
    this.estimatedMinutes,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late Timer _timer;
  late int _remainingSeconds;
  late int _totalSeconds;
  late AnimationController _pulseController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;
  bool _isOverdue = false;
  double _progress = 0.0;
  
  // Notification milestone tracking
  bool _notified75Percent = false;
  bool _notified90Percent = false;
  bool _notifiedReady = false;
  bool _notifiedOverdue = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _totalSeconds = widget.initialSeconds;
    print(
      'CountdownTimer initialized with ${widget.initialSeconds} seconds (total: $_totalSeconds)',
    );

    // Initialize pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Initialize progress animation
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );

    _pulseController.repeat(reverse: true);

    // Start countdown
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _isOverdue = false;
        } else {
          _isOverdue = true;
          _remainingSeconds--; // Continue counting negative for overdue display
        }

        // Calculate live progress based on estimated minutes if available
        if (widget.estimatedMinutes != null) {
          final totalEstimatedSeconds = widget.estimatedMinutes! * 60;
          final elapsedSeconds = totalEstimatedSeconds - _remainingSeconds;
          _progress = (elapsedSeconds / totalEstimatedSeconds).clamp(0.0, 1.0);
        } else if (_totalSeconds > 0) {
          final elapsed = _totalSeconds - _remainingSeconds;
          _progress = (elapsed / _totalSeconds).clamp(0.0, 1.0);
        }
        _progressController.animateTo(_progress);
        
        // Check for milestone notifications
        _checkMilestoneNotifications();
      });

      // Stop pulse animation if overdue
      if (_isOverdue && _pulseController.isAnimating) {
        _pulseController.stop();
      }

      // Trigger completion callback when timer reaches 0 (not for overdue)
      if (_remainingSeconds == 0 && widget.onTimerComplete != null) {
        widget.onTimerComplete!();
      }
    });
  }
  
  void _checkMilestoneNotifications() {
    final progressPercentage = (_progress * 100).round();
    
    // 75% completion notification
    if (progressPercentage >= 75 && !_notified75Percent) {
      _notified75Percent = true;
      _showNotification(
        'Order Progress', 
        '🍽️ Your order is 75% complete! Almost ready.',
      );
    }
    
    // 90% completion notification
    if (progressPercentage >= 90 && !_notified90Percent) {
      _notified90Percent = true;
      _showNotification(
        'Order Almost Ready', 
        '⏰ Your order is 90% complete! Getting ready soon.',
      );
    }
    
    // Order ready notification
    if (_remainingSeconds <= 0 && !_isOverdue && !_notifiedReady) {
      _notifiedReady = true;
      _showNotification(
        'Order Ready! 🎉', 
        '✅ Your order is ready for pickup! Please collect it now.',
      );
    }
    
    // Overdue notification
    if (_isOverdue && !_notifiedOverdue) {
      _notifiedOverdue = true;
      _showNotification(
        'Order Update', 
        '⚠️ Your order is taking a bit longer than expected. Thank you for your patience!',
      );
    }
  }
  
  void _showNotification(String title, String message) {
    // Show in-app notification using GetX snackbar
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 4),
      backgroundColor: _remainingSeconds <= 0 && !_isOverdue 
          ? Colors.green.withOpacity(0.9)
          : _isOverdue 
              ? Colors.orange.withOpacity(0.9)
              : ThemeColors.baseThemeColor.withOpacity(0.9),
      colorText: Colors.white,
      icon: Icon(
        _remainingSeconds <= 0 && !_isOverdue 
            ? Icons.check_circle 
            : _isOverdue 
                ? Icons.access_time 
                : Icons.restaurant_menu,
        color: Colors.white,
      ),
      margin: EdgeInsets.all(16),
      borderRadius: 8,
    );
    
    print('Notification: $title - $message');
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    if (seconds <= 0) {
      final overdue = seconds.abs();
      final mins = overdue ~/ 60;
      final secs = overdue % 60;
      return '-${mins.toString()}:${secs.toString().padLeft(2, '0')}';
    }

    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use live calculated progress for real-time updates
    final progressPercentage = (_progress * 100).round();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: _isOverdue
              ? Colors.red.withOpacity(0.3)
              : ThemeColors.baseThemeColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            '🍽️ ' + 'YOUR_ORDER_IS_BEING_PREPARED'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _isOverdue ? Colors.red[700] : ThemeColors.baseThemeColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          // Time Display
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: !_isOverdue && _remainingSeconds > 0
                    ? _pulseAnimation.value
                    : 1.0,
                child: Column(
                  children: [
                    Text(
                      _remainingSeconds > 0
                          ? _formatTime(_remainingSeconds)
                          : 'READY'.tr,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: _isOverdue
                            ? Colors.red
                            : _remainingSeconds > 0
                            ? ThemeColors.baseThemeColor
                            : Colors.green,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _isOverdue
                          ? 'RUNNING_LATE'.tr
                          : _remainingSeconds > 0
                          ? 'ESTIMATED_TIME_REMAINING'.tr
                          : 'ORDER_READY_FOR_PICKUP'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: _isOverdue ? Colors.red[600] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 16),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PROGRESS'.tr,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  Text(
                    '$progressPercentage%',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  // Use live calculated progress for real-time updates
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isOverdue
                          ? Colors.red
                          : _progress > 0.8
                          ? Colors.orange
                          : ThemeColors.baseThemeColor,
                    ),
                    minHeight: 8,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),

          // Info Row
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ESTIMATED'.tr +
                    ': ${widget.estimatedMinutes ?? (_totalSeconds / 60).ceil()} min',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              if (_isOverdue) ...[
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'ORDER_RUNNING_LATE'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
