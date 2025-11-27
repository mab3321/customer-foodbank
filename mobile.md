// =====================================
// MOBILE APP TIMER IMPLEMENTATION GUIDE
// =====================================

// ===== React Native Implementation =====

import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Animated } from 'react-native';

const OrderTimer = ({ order }) => {
const [timeLeft, setTimeLeft] = useState(0);
const [progress, setProgress] = useState(0);
const [isOverdue, setIsOverdue] = useState(false);
const progressAnim = new Animated.Value(0);

useEffect(() => {
if (!order.timer || !order.timer.process_started_at) return;

    const interval = setInterval(() => {
      const now = new Date();
      const startTime = new Date(order.timer.process_started_at);
      const elapsedSeconds = Math.floor((now - startTime) / 1000);
      const estimatedSeconds = order.timer.estimated_wait_time * 60;
      const remainingSeconds = Math.max(0, estimatedSeconds - elapsedSeconds);

      const progressPercentage = Math.min(100, (elapsedSeconds / estimatedSeconds) * 100);

      setTimeLeft(remainingSeconds);
      setProgress(progressPercentage);
      setIsOverdue(remainingSeconds <= 0);

      // Animate progress bar
      Animated.timing(progressAnim, {
        toValue: progressPercentage,
        duration: 500,
        useNativeDriver: false,
      }).start();

    }, 1000);

    return () => clearInterval(interval);

}, [order.timer]);

const formatTime = (seconds) => {
if (seconds <= 0) {
const overdue = Math.abs(seconds);
const mins = Math.floor(overdue / 60);
const secs = overdue % 60;
return `-${mins}:${secs.toString().padStart(2, '0')}`;
}
const mins = Math.floor(seconds / 60);
const secs = seconds % 60;
return `${mins}:${secs.toString().padStart(2, '0')}`;
};

if (!order.timer) return null;

return (
<View style={styles.timerContainer}>
<Text style={styles.title}>🍽️ Your order is being prepared</Text>

      <View style={styles.timeDisplay}>
        <Text style={[
          styles.timeText,
          isOverdue ? styles.overdue : styles.normal
        ]}>
          {formatTime(timeLeft)}
        </Text>
        <Text style={styles.subtitle}>
          {isOverdue ? 'Running late' : 'Estimated time remaining'}
        </Text>
      </View>

      <View style={styles.progressContainer}>
        <Text style={styles.progressLabel}>Progress</Text>
        <View style={styles.progressBar}>
          <Animated.View
            style={[
              styles.progressFill,
              {
                width: progressAnim.interpolate({
                  inputRange: [0, 100],
                  outputRange: ['0%', '100%']
                }),
                backgroundColor: isOverdue ? '#EF4444' : progress > 80 ? '#F59E0B' : '#10B981'
              }
            ]}
          />
        </View>
        <Text style={styles.progressText}>{Math.round(progress)}%</Text>
      </View>

      <View style={styles.infoRow}>
        <Text style={styles.infoText}>
          Estimated: {order.timer.estimated_wait_time} min
        </Text>
        {isOverdue && (
          <Text style={styles.overdueText}>
            ⚠️ Order is running late
          </Text>
        )}
      </View>
    </View>

);
};

const styles = StyleSheet.create({
timerContainer: {
backgroundColor: '#F3F4F6',
padding: 16,
borderRadius: 12,
margin: 16,
},
title: {
fontSize: 16,
fontWeight: '600',
textAlign: 'center',
marginBottom: 16,
},
timeDisplay: {
alignItems: 'center',
marginBottom: 16,
},
timeText: {
fontSize: 32,
fontWeight: 'bold',
fontFamily: 'monospace',
},
normal: {
color: '#10B981',
},
overdue: {
color: '#EF4444',
},
subtitle: {
fontSize: 14,
color: '#6B7280',
marginTop: 4,
},
progressContainer: {
marginBottom: 16,
},
progressLabel: {
fontSize: 12,
color: '#6B7280',
marginBottom: 4,
},
progressBar: {
height: 8,
backgroundColor: '#E5E7EB',
borderRadius: 4,
overflow: 'hidden',
},
progressFill: {
height: '100%',
borderRadius: 4,
},
progressText: {
fontSize: 12,
textAlign: 'right',
marginTop: 4,
color: '#6B7280',
},
infoRow: {
flexDirection: 'row',
justifyContent: 'space-between',
alignItems: 'center',
},
infoText: {
fontSize: 12,
color: '#6B7280',
},
overdueText: {
fontSize: 12,
color: '#EF4444',
fontWeight: '600',
},
});

export default OrderTimer;

// ===== Flutter Implementation =====

/\*
import 'dart:async';
import 'package:flutter/material.dart';

class OrderTimer extends StatefulWidget {
final Map<String, dynamic> order;

OrderTimer({required this.order});

@override
\_OrderTimerState createState() => \_OrderTimerState();
}

class \_OrderTimerState extends State<OrderTimer>
with TickerProviderStateMixin {

Timer? \_timer;
int \_timeLeft = 0;
double \_progress = 0.0;
bool \_isOverdue = false;
late AnimationController \_progressController;

@override
void initState() {
super.initState();
\_progressController = AnimationController(
duration: Duration(milliseconds: 500),
vsync: this,
);

    if (widget.order['timer'] != null &&
        widget.order['timer']['process_started_at'] != null) {
      _startTimer();
    }

}

void \_startTimer() {
\_timer = Timer.periodic(Duration(seconds: 1), (timer) {
final now = DateTime.now();
final startTime = DateTime.parse(widget.order['timer']['process_started_at']);
final elapsedSeconds = now.difference(startTime).inSeconds;
final estimatedSeconds = widget.order['timer']['estimated_wait_time'] \* 60;
final remainingSeconds = (estimatedSeconds - elapsedSeconds).clamp(0, double.infinity).toInt();

      final progressPercentage = (elapsedSeconds / estimatedSeconds * 100).clamp(0.0, 100.0);

      setState(() {
        _timeLeft = remainingSeconds;
        _progress = progressPercentage / 100;
        _isOverdue = remainingSeconds <= 0;
      });

      _progressController.animateTo(_progress);
    });

}

String \_formatTime(int seconds) {
if (seconds <= 0) {
final overdue = seconds.abs();
final mins = overdue ~/ 60;
final secs = overdue % 60;
return '-$mins:${secs.toString().padLeft(2, '0')}';
}
final mins = seconds ~/ 60;
final secs = seconds % 60;
return '$mins:${secs.toString().padLeft(2, '0')}';
}

@override
Widget build(BuildContext context) {
if (widget.order['timer'] == null) return Container();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '🍽️ Your order is being prepared',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          Column(
            children: [
              Text(
                _formatTime(_timeLeft),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: _isOverdue ? Colors.red : Colors.green,
                ),
              ),
              Text(
                _isOverdue ? 'Running late' : 'Estimated time remaining',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Progress', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              SizedBox(height: 4),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _isOverdue ? Colors.red : _progress > 0.8 ? Colors.orange : Colors.green,
                ),
              ),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(_progress * 100).round()}%',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated: ${widget.order['timer']['estimated_wait_time']} min',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              if (_isOverdue)
                Text(
                  '⚠️ Order is running late',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );

}

@override
void dispose() {
\_timer?.cancel();
\_progressController.dispose();
super.dispose();
}
}
\*/

// ===== API Integration Example =====

// Your API now returns this structure for orders:
/_
{
"status": 200,
"data": [
{
"id": 123,
"order_code": "ORD-001234",
"status": 15, // PROCESS status
"status_name": "Process",
"timer": {
"process_started_at": "2025-11-26T14:43:00.000000Z",
"estimated_wait_time": 15,
"remaining_time": 12,
"elapsed_time": 3,
"is_overdue": false,
"progress_percentage": 20,
"formatted_remaining_time": "12:00"
},
// ... other order fields
}
]
}
_/

// ===== Key Features for Mobile App =====

/\*
✅ Real-time Countdown: Updates every second
✅ Progress Bar: Visual progress indicator  
✅ Overdue Detection: Red color when late
✅ Smooth Animations: Progress bar animations
✅ Status Messages: "Running late" vs "On time"
✅ Milestone Notifications: Can add push notifications
✅ Offline Handling: Can cache timer data
✅ Battery Optimization: Reduce updates when app backgrounded

🔔 Push Notification Integration:

- Send notification when order is 90% complete
- Send notification when order becomes overdue
- Send notification when order is ready for pickup

📱 UI/UX Best Practices:

- Use monospace font for timer display
- Smooth color transitions (Green → Orange → Red)
- Clear visual hierarchy
- Accessibility support
- Responsive design for different screen sizes
  \*/
