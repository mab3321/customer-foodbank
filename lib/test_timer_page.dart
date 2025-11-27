import 'package:flutter/material.dart';
import '/widgets/countdown_timer.dart';
import '/utils/theme_colors.dart';

class TestTimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Test'),
        backgroundColor: ThemeColors.baseThemeColor,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Testing Countdown Timer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              CountdownTimer(
                initialSeconds: 300, // 5 minutes
                onTimerComplete: () {
                  print('Timer completed!');
                },
              ),
              SizedBox(height: 30),
              Text(
                'This should show a 5-minute countdown timer',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
