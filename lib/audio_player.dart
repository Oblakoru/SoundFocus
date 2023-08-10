import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RelaxingPlayer extends StatefulWidget {
  //final IconData iconData;
  //final VoidCallback onPressed;
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

    // Set your variables here
    player.setVolume(0);
  }

  @override
  void dispose() {
    // Cleanup resources in the dispose method
    player.dispose(); // Cancel the stream subscription

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //player.setVolume(0);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        //print('Screen Width: $screenWidth');

        bool isPhone = screenWidth < 600;
        //print('isPhone: $isPhone');

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
                    : Colors.white, //const Color.fromRGBO(217, 202, 179, 1.0),
                foregroundColor: Colors
                    .grey.shade900, //const Color.fromRGBO(246, 246, 246, 1),
                hoverColor: Colors
                    .greenAccent, //const Color.fromRGBO(109, 152, 134, 1),
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
                    //await player.setVolume(0.5);
                  }
                },
                child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
              ),
              //FloatingActionButton(
              //    onPressed: () async {
              //      await player1.stop(); // will immediately start playing
              //    },
              //    child:  Icon(isPlaying ? Icons.play_arrow : Icons.stop)),
              const SizedBox(
                width: 10,
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
                    : Colors.white, //const Color.fromRGBO(217, 202, 179, 1.0),
                foregroundColor: Colors
                    .grey.shade900, //const Color.fromRGBO(246, 246, 246, 1),
                hoverColor: Colors
                    .greenAccent, //const Color.fromRGBO(109, 152, 134, 1),
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
                    //await player.setVolume(0.5);
                  }
                },
                child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
              ),
              //FloatingActionButton(
              //    onPressed: () async {
              //      await player1.stop(); // will immediately start playing
              //    },
              //    child:  Icon(isPlaying ? Icons.play_arrow : Icons.stop)),
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
