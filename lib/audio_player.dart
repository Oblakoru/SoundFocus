import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RelaxingPlayer extends StatefulWidget {

  final String imeZvoka;
  final String potDoZvoka;
  final IconData iconData;

  const RelaxingPlayer(
      {super.key,
      required this.imeZvoka,
      required this.potDoZvoka,
      required this.iconData});

  @override
  _RelaxingPlayerState createState() => _RelaxingPlayerState();
}

class _RelaxingPlayerState extends State<RelaxingPlayer>
    with AutomaticKeepAliveClientMixin<RelaxingPlayer> {
  bool isPlaying = false;
  double _currentSliderValue = 0;
  var player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setVolume(0);
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        //Pridobitev velikosti zaslona
        double screenWidth = MediaQuery.of(context).size.width;
        bool isPhone = screenWidth < 600;

        //Vrnemo drugačen widget glede na velikost zaslona (telefon ima odstranjeno besedilo)
        if (!isPhone) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.iconData,
                size: 30,
                color: isPlaying
                    ? Colors.greenAccent
                    : const Color.fromRGBO(246, 246, 246, 1),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text(
                  widget.imeZvoka,
                  style: const TextStyle(
                      color: Color.fromRGBO(246, 246, 246, 1), fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton.small(
                backgroundColor: isPlaying
                    ? Colors.greenAccent
                    : Colors.white, 
                foregroundColor: Colors
                    .grey.shade900, 
                hoverColor: Colors
                    .greenAccent, 
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

                    player.onPlayerComplete.listen((event) {
                      setState(() {
                        player.play(AssetSource(widget.potDoZvoka));
                      });
                    });
                  }
                },
                child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
              ),
              const SizedBox(
                width: 10,
              ),
              Slider(
                activeColor: Colors
                    .greenAccent, 
                value: _currentSliderValue,
                max: 1,
                divisions: 100,
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
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.iconData,
                size: 30,
                color: isPlaying
                    ? Colors.greenAccent
                    : const Color.fromRGBO(246, 246, 246, 1),
              ),
              FloatingActionButton.small(
                backgroundColor: isPlaying
                    ? Colors.greenAccent
                    : Colors.white, 
                foregroundColor: Colors
                    .grey.shade900,
                hoverColor: Colors
                    .greenAccent,
                onPressed: () async {
                  if (isPlaying) {
                    await player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    await player.play(AssetSource(
                        widget.potDoZvoka));
                    setState(() {
                      isPlaying = true;
                    });

                    player.onPlayerComplete.listen((event) {
                      setState(() {
                        player.play(AssetSource(widget.potDoZvoka));
                      });
                    });
                  }
                },
                child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
              ),
              Slider(
                activeColor: Colors
                    .greenAccent, //const Color.fromRGBO(109, 152, 134, 1),
                value: _currentSliderValue,
                max: 1,
                divisions: 100,
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
