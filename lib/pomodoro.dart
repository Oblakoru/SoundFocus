import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro>
    with AutomaticKeepAliveClientMixin<Pomodoro> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);

  late double time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Template https://github.com/DizoftTeam/simple_count_down/blob/master/example/lib/main.dart
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Start'),
              onPressed: () {
                _controller.start();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            // Pause
            ElevatedButton(
              child: const Text('Pause'),
              onPressed: () {
                _controller.pause();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            // Resume
            ElevatedButton(
              child: const Text('Resume'),
              onPressed: () {
                _controller.resume();
              },
            ),
            const SizedBox(
              width: 20,
            ),
            // Stop
            ElevatedButton(
              child: const Text('Restart'),
              onPressed: () {
                _controller.restart();
              },
            ),
          ],
        ),
        Countdown(
          controller: _controller,
          seconds: 2 * 60,
          build: (BuildContext context, time) {
            
            double progress = 1 - (time / (2 * 60));


            int minute = time ~/ 60;
            int sekunde = (time % 60).truncate();

            if (sekunde == 60) {
              minute++; // Increment the minute when seconds reach 60
              sekunde = 0; // Reset seconds to 0
            }

             // Assuming you're using 20 seconds
            //if (time == (0)) {
            //  // Show alert when timer finishes
            //  Future.delayed(Duration.zero, () {
            //    //_showAlert(context);
            //  });
            //}

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  minHeight: 20,
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.greenAccent,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
                const SizedBox(height: 20),
                //Text(time.toString(),
                //    style: const TextStyle(fontSize: 100, color: Colors.white)),
                Text("$minute:${sekunde < 10 ? '0$sekunde' : sekunde}",
                    style: const TextStyle(fontSize: 100, color: Colors.white))
              ],
            );
          },
          interval: const Duration(milliseconds: 100),
          onFinished: () {
            print('Timer is done!');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Timer is done!'),
              ),
            );
          },
        ),
      ],
    );
  }

  // Function to show an alert
  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Timer Finished'),
          content: const Text('The timer has finished.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
