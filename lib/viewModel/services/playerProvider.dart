import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/colors.dart';

class AudioPlayerProvider extends ChangeNotifier {
  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> subscriptions = [];

  audioPlayermthod() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    openPlayer();
  }

  void openPlayer() async {
    await assetsAudioPlayer.open(
      Audio.network(
        'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
        metas: Metas(
          id: 'audioUrl',
          title: 'appName',
          artist: 'name',
          image: MetasImage.network(
            'imageUrl',
          ),
        ),
      ),
      showNotification: true,
      autoStart: false,
    );

    // Subscribe to the playlistAudioFinished event
    subscriptions.add(assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      // Handle the event, e.g., activate something
      activate();
    }));
  }

  void activate() {
    assetsAudioPlayer.stop();
    // Implement the activation logic here
    print('Activated!');
    openPlayer();
    notifyListeners();
  }

  void playOrPause() {
    assetsAudioPlayer.playOrPause();
    notifyListeners();
  }

  void seekTo(Duration to) {
    assetsAudioPlayer.seek(to);
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   // Dispose of subscriptions
  //   subscriptions.forEach((subscription) => subscription.cancel());
  //   print('dispose');
  //   super.dispose();
  // }
}

class AssetAudioPlayerWidget extends StatelessWidget {
  var url;
  AssetAudioPlayerWidget({this.url});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AudioPlayerProvider(),
      child: Builder(
        builder: (context) {
          var audioPlayer = Provider.of<AudioPlayerProvider>(context);
          return audioPlayer.assetsAudioPlayer.builderCurrent(
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
                      player: audioPlayer.assetsAudioPlayer,
                      builder: (context, isPlaying) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: InkWell(
                                onTap: () {
                                  audioPlayer.playOrPause();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      colorPrimaryS,
                                      colorPrimary,
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
                      child: audioPlayer.assetsAudioPlayer.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos? infos) {
                          if (infos == null) {
                            return CircularProgressIndicator();
                          } else {
                            return PositionSeekWidget(
                              currentPosition: infos.currentPosition,
                              duration: infos.duration,
                              seekTo: (to) {
                                audioPlayer.seekTo(to);
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
        },
      ),
    );
  }
}

class PositionSeekWidget extends StatelessWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    Key? key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 40,
          child: Text(durationToString(currentPosition)),
        ),
        Slider(
          min: 0,
          max: duration.inMilliseconds.toDouble(),
          value: currentPosition.inMilliseconds.toDouble(),
          activeColor: colorPrimary,
          inactiveColor: colorPrimary.withOpacity(.3),
          onChangeEnd: (newValue) {
            seekTo(Duration(milliseconds: newValue.floor()));
          }, onChanged: (double value) {  },
        ),
        SizedBox(
          width: 40,
          child: Text(durationToString(duration)),
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
