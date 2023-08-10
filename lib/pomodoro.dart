import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> with AutomaticKeepAliveClientMixin<Pomodoro> {
  double time = 0;
  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 20,
      build: (BuildContext context, time) {
        // Calculate progress
        double progress = 1 - (time / 20); // Assuming you're using 20 seconds
        if (time == 0) {
          // Show alert when timer finishes
          Future.delayed(Duration.zero, () {
            //_showAlert(context);
          });
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),
            Text(time.toString(), style: TextStyle(fontSize: 100, color: Colors.white)),
          ],
        );
      },
      interval: Duration(milliseconds: 100),
      onFinished: () {
        print('Timer is done!');
      },
    );
  }
  
   // Function to show an alert
  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timer Finished'),
          content: Text('The timer has finished.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}