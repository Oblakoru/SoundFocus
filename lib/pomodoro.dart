import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro>
    with AutomaticKeepAliveClientMixin<Pomodoro> {
  TextEditingController _textController = TextEditingController();

  final CountdownController _controller =
      new CountdownController(autoStart: false);

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  //late double time;
  bool isTimer = false;
  int zacetniCas = 600;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Template https://github.com/DizoftTeam/simple_count_down/blob/master/example/lib/main.dart
        Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _textController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Vnesi čas učenja',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  tooltip: "Start",
                  onPressed: () {
                    setState(() {
                      if (_textController.text == '' ||
                          int.parse(_textController.text) == 0) {
                      } else {
                        isTimer = true;
                        if (zacetniCas ==
                            int.parse(_textController.text) * 60) {
                          _controller.restart();
                        } else {
                          zacetniCas = int.parse(_textController.text) * 60;
                          _controller.start();
                          //print("hej");
                          
                        }
                        _textController.clear();
                      }
                    });
                  },
                  child: Icon(
                    Icons.timer_outlined,
                  ),
                  backgroundColor: Colors.greenAccent,
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  tooltip: "Play/Pause",
                  onPressed: () {
                    setState(() {
                      if (isTimer) {
                        isTimer = !isTimer;
                        _controller.pause();
                      } else {
                        isTimer = !isTimer;
                        _controller.resume();
                      }
                    });
                  },
                  child: Icon(
                    !isTimer ? Icons.play_arrow : Icons.pause,
                  ),
                  backgroundColor: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
        Countdown(
          controller: _controller,
          seconds: zacetniCas,
          build: (BuildContext context, time) {
            double progress = 1 - (time / (zacetniCas));
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
            SystemSound.play(SystemSoundType.alert);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Konec!'),
              ),
            );
          },
        ),
      ],
    );
  }

  // Function to show an alert
  //void _showAlert(BuildContext context) {
  //  showDialog(
  //    context: context,
  //    builder: (BuildContext context) {
  //      return AlertDialog(
  //        title: const Text('Timer Finished'),
  //        content: const Text('The timer has finished.'),
  //        actions: [
  //          TextButton(
  //            onPressed: () {
  //              Navigator.pop(context); // Close the alert
  //            },
  //            child: const Text('OK'),
  //          ),
  //        ],
  //      );
  //    },
  //  );
  //}

  @override
  bool get wantKeepAlive => true;
}
