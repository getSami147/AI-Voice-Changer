import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/colors.dart';

class AssetAudioPlayer extends StatefulWidget {
  var audioUrl;
  var imageUrl;
  var name;
  var appName;
  AssetAudioPlayer({required this.audioUrl,this.imageUrl,this.name, this.appName, super.key});
  @override
  _AssetAudioPlayerState createState() => _AssetAudioPlayerState();
}

class _AssetAudioPlayerState extends State<AssetAudioPlayer> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
 

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      return openPlayer();
      // print('playlistAudioFinished : $data');
    }));
    // _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
    //   return openPlayer();
    //   // print('audioSessionId : $sessionId');
    // }));

    openPlayer();
    
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
    Audio.network(widget.audioUrl,
      metas: Metas(
        id: widget.audioUrl,
        title: widget.appName,
        artist: widget.name,
        image:  MetasImage.network(
          widget.imageUrl,
        ),)
    ),
  
      showNotification: true,
       autoStart: false,
       
    
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      decoration: BoxDecoration(color: const Color(0xFFE8E8EE),
      borderRadius: BorderRadius.only(
        bottomLeft:radiusCircular(10),
        topLeft:radiusCircular(10),
        topRight:radiusCircular(10),
        

        )
      ),
      child: _assetsAudioPlayer.builderCurrent(
        builder: (context, Playing? playing) {
          return Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PlayerBuilder.isPlaying(
                player: _assetsAudioPlayer,
                builder: (context, isPlaying) {
                  return PlayingControls(
                    isPlaying: isPlaying,
                    // onStop: () {
                    //   _assetsAudioPlayer.stop();
                    // },
                    onPlay: () {
                      _assetsAudioPlayer.playOrPause();
                    },
                  );
                },
              ),      
              Expanded(
                child: _assetsAudioPlayer.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos? infos) {
                    if (infos == null) {
                      return const Text("Please Wait...");
                      }
                    return PositionSeekWidget(
                      currentPosition: infos.currentPosition,
                      duration: infos.duration,
                      seekTo: (to) {
                        _assetsAudioPlayer.seek(to);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
      
  }
}

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  // final LoopMode? loopMode;
  // final bool isPlaylist;
  // final Function()? onPrevious;
  final Function() onPlay;
  // final Function()? onNext;
  // final Function()? toggleLoop;
  // final Function()? onStop;

  PlayingControls({
    required this.isPlaying,
    // this.isPlaylist = false,
    // this.loopMode,
    // this.toggleLoop,
    // this.onPrevious,
    required this.onPlay,
    // this.onNext,
    // this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: InkWell(
            onTap: onPlay,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration:  const BoxDecoration(
                gradient: LinearGradient(colors: [
                  colorPrimaryS,
                  colorPrimary,
                ]),
                shape: BoxShape.circle
              ),
              child: Icon(
                isPlaying
                    ?Icons.pause
                    :Icons.play_arrow,
                size: 25,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({super.key, 
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (!listenOnlyUserInterraction) {
    //   _visibleValue = widget.currentPosition;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 40,
          child: Text(durationToString(widget.currentPosition)),
        ),
        Slider(
          min: 0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: percent * widget.duration.inMilliseconds.toDouble(),
          activeColor: colorPrimary,
          inactiveColor: colorPrimaryS.withOpacity(.3),
          onChangeEnd: (newValue) {
            setState(() {
              listenOnlyUserInterraction = false;
              widget.seekTo(_visibleValue);
            });
          },
          onChangeStart: (_) {
            setState(() {
              listenOnlyUserInterraction = true;
            });
          },
          onChanged: (newValue) {
            setState(() {
              final to = Duration(milliseconds: newValue.floor());
              _visibleValue = to;
            });
          },
        ),
        SizedBox(
          width: 40,
          child: Text(durationToString(widget.duration)),
        ),
      ],
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}