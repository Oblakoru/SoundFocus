import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:sound_focus/audio_player.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Sound_Focus',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 0;
  bool _isActive = false;
  Timer? _timer;

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(109, 152, 134, 1),
          title: const Text(
            "Sound_Focus",
            style: TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
            unselectedLabelColor: Color.fromRGBO(246, 246, 246, 1),
            labelColor: Color.fromRGBO(246, 246, 246, 1),
            indicatorColor: Color.fromRGBO(246, 246, 246, 1),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
                text: "Domov",
              ),
              Tab(
                icon: Icon(
                  Icons.access_time_rounded,
                  color: Color.fromRGBO(246, 246, 246, 1),
                ),
                text: "Pomodoro",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RelaxingPlayer(
                  imeZvoka: "Rain",
                  potDoZvoka: "rain.mp3",
                  iconData: Icons.water,
                ),
                RelaxingPlayer(
                  imeZvoka: "Fire",
                  potDoZvoka: "fire.mp3",
                  iconData: Icons.sunny,
                ),
                RelaxingPlayer(
                    imeZvoka: "Wind",
                    potDoZvoka: "wind.mp3",
                    iconData: Icons.wind_power),
                RelaxingPlayer(
                  imeZvoka: "River",
                  potDoZvoka: "river.mp3",
                  iconData: Icons.water_drop,
                ),
                RelaxingPlayer(
                  imeZvoka: "Thunder",
                  potDoZvoka: "thunder.mp3",
                  iconData: Icons.thunderstorm,
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isActive = !_isActive;
                          if (_isActive) {
                            _startTimer();
                          } else {
                            _stopTimer();
                          }
                        });
                      },
                      child: const Text("Start")),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "$_seconds seconds ",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
