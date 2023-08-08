import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RelaxingPlayer extends StatefulWidget {
  //final IconData iconData;
  //final VoidCallback onPressed;
  final String imeZvoka;
  final String potDoZvoka;
  final IconData iconData;

  const RelaxingPlayer({required this.imeZvoka, required this.potDoZvoka, required this.iconData});

  @override
  _RelaxingPlayerState createState() => _RelaxingPlayerState();
}

class _RelaxingPlayerState extends State<RelaxingPlayer> {
  bool isPlaying = false;
  double _currentSliderValue = 0;
  var player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(widget.iconData, size: 50, color: isPlaying ? Color.fromRGBO(217, 202, 179, 1.0) : Color.fromRGBO(246, 246, 246, 1)),
        Container(
          alignment: Alignment.center,
          child: Text(widget.imeZvoka, style: TextStyle(color: Color.fromRGBO(246, 246, 246, 1), fontSize: 20),),
          width: 100,
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          backgroundColor: Color.fromRGBO(217, 202, 179, 1.0),
          foregroundColor: Color.fromRGBO(246, 246, 246, 1),
          hoverColor: Color.fromRGBO(109, 152, 134, 1),
          
            onPressed: () async {
              if (isPlaying) {
                await player.pause();
                setState(() {
                  isPlaying = false;
                });
              } else {
                await player.play(AssetSource(
                    widget.potDoZvoka)); // will immediately start playing
                setState(() {
                  isPlaying = true;
                });
              }
            },
            child: Icon(isPlaying ? Icons.stop : Icons.play_arrow)),
        //FloatingActionButton(
        //    onPressed: () async {
        //      await player1.stop(); // will immediately start playing
        //    },
        //    child:  Icon(isPlaying ? Icons.play_arrow : Icons.stop)),
        Slider(
          activeColor: Color.fromRGBO(109, 152, 134, 1),
          value: _currentSliderValue,
          max: 1,
          divisions: 20,
          label: _currentSliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              player.setVolume(_currentSliderValue);
            });
          },
        ),
      ],
    );
  }
}
