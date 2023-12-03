import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/colors.dart';
// import 'package:voice_maker/utils/colors.dart';

class AssetAudioPlayer extends StatefulWidget {
  var audioUrl;
  var imageUrl;
  var name;
  var appName;

  AssetAudioPlayer({required this.audioUrl, this.imageUrl, this.name, this.appName, super.key});

  @override
  _AssetAudioPlayerState createState() => _AssetAudioPlayerState();
}

class _AssetAudioPlayerState extends State<AssetAudioPlayer> {
  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    openPlayer();
  }

  void openPlayer() async {
    await assetsAudioPlayer.open(
      Audio.network(
        widget.audioUrl,
        metas: Metas(
          id: widget.audioUrl,
          title: widget.appName,
          artist: widget.name,
          image: MetasImage.network(
            widget.imageUrl,
          ),
        ),
      ),
      showNotification: true,
      autoStart: false,
      
    );

    // Subscribe to the playlistAudioFinished event
    // subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
    //   // Handle the event, e.g., activate something
  
    // }));
  }

  void activate() {
    assetsAudioPlayer.stop();
    // Implement the activation logic here
    print('Activated!');
    return openPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return assetsAudioPlayer.builderCurrent(
      builder: (context, Playing? playing) {
        return Container(
            alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8EE),
        borderRadius: BorderRadius.only(
          bottomLeft: radiusCircular(10),
          topLeft: radiusCircular(10),
          topRight: radiusCircular(10),
        ),
      ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PlayerBuilder.isPlaying(
                player: assetsAudioPlayer,
                builder: (context, isPlaying) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            assetsAudioPlayer.playOrPause();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                colorPrimaryS,
                                colorPrimary
                              ]),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 25,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: assetsAudioPlayer.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos? infos) {
                    if (infos == null) {
                      return CircularProgressIndicator();
                    } else {
                      return PositionSeekWidget(
                        currentPosition: infos.currentPosition,
                        duration: infos.duration,
                        seekTo: (to) {
                          assetsAudioPlayer.seek(to);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of subscriptions
    subscriptions.forEach((subscription) => subscription.cancel());
    print('dispose');
    super.dispose();
  }
}

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    super.key,
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
  double get percent =>
      widget.duration.inMilliseconds == 0 ? 0 : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
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
          inactiveColor: colorPrimary.withOpacity(.3),
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

  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
