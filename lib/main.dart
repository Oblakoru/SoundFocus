import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:sound_focus/audio_player.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sound_focus/pomodoro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Sound Focus',
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,

        //flexibleSpace je z namenom, da naslov ni prikazan
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.black54,
          flexibleSpace: const SafeArea(
              child: TabBar(
            unselectedLabelColor: Color.fromRGBO(246, 246, 246, 1),
            labelColor: Color.fromRGBO(246, 246, 246, 1),
            indicatorColor: Colors.greenAccent,
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
          )),
        ),

        body: const TabBarView(
          children: [
            //Razdeli Tab na dva dela
            Column(
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
              child: Pomodoro(),
            ),
          ],
        ),
      ),
    );
  }
}
