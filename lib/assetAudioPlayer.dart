import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/viewModel/services/playerProvider.dart';
class AssetAudioPlayer extends StatefulWidget {
  var audioUrl;
  var imageUrl;
  var name;
  var appName;

  AssetAudioPlayer(
      {required this.audioUrl, this.imageUrl, this.name, this.appName, Key? key})
      : super(key: key);

  @override
  _AssetAudioPlayerState createState() => _AssetAudioPlayerState();
}

class _AssetAudioPlayerState extends State<AssetAudioPlayer> {
  late AssetsAudioPlayer assetsAudioPlayer;
  final List<StreamSubscription> subscriptions = [];
  bool isAudioComplete = false;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    openPlayer();
  }

  @override
  void dispose() {
    // Dispose of subscriptions
    subscriptions.forEach((subscription) => subscription);
    assetsAudioPlayer.dispose(); // Dispose of the audio player
    print('dispose');
    super.dispose();
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
      showNotification: false, // Set this to false to hide the notification
      autoStart: false,
    );

    // Add a completion listener to handle when the audio playback is completed
    assetsAudioPlayer.playlistAudioFinished.listen((finished) {
      if (finished==true) {
        // Handle the audio playback completion here
        setState(() {
          isAudioComplete = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return assetsAudioPlayer.builderCurrent(
      builder: (context, Playing? playing) {
        return Visibility(
          visible: isAudioComplete == false,
          child: Container(
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
                  builder: (context, bool isPlaying) {
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
                        return const CircularProgressIndicator();
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
          ),
        );
      },
    );
  }
}