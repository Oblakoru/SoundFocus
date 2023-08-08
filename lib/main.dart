import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sound_focus/audio_player.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(109, 152, 134, 1),
        title: const Text("Sound_Focus", style: TextStyle(color: Colors.white),),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         
          RelaxingPlayer(imeZvoka: "Rain", potDoZvoka: "rain.mp3", iconData: Icons.water ,),

          RelaxingPlayer(imeZvoka: "Fire", potDoZvoka: "fire.mp3", iconData: Icons.sunny,),

          RelaxingPlayer(imeZvoka: "Wind", potDoZvoka: "wind.mp3", iconData: Icons.wind_power),

          RelaxingPlayer(imeZvoka: "River", potDoZvoka: "river.mp3", iconData: Icons.water_drop,),

          RelaxingPlayer(imeZvoka: "Thunder", potDoZvoka: "thunder.mp3", iconData: Icons.thunderstorm,),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
