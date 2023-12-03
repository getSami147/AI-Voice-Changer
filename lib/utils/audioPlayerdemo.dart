// import 'dart:ffi';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:voice_maker/assetAudioPlayer.dart';


// class CustomAudioPlayer extends StatefulWidget {
//   var url;
//     CustomAudioPlayer({required this.url, super.key});
//   @override
//   _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
// }

// class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
//   bool _play = false;
//   String _currentPosition = '';
//   double _sliderValue = 0.0;

//   final assetsAudioPlayer = AssetsAudioPlayer();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AudioWidget.network(
//           onFinished: () {
//             setState(() {
//               _play = false;
//             });
//           },
//           url: "https://multivendorswedenuzrtech.s3.amazonaws.com/v1-mixkit-female-microphone-countdown-341.wav",
//           play: _play,
//           onReadyToPlay: (total) {
//             setState(() {
//               _currentPosition = '0:00 / ${total}';
//             });
//           },
//           onPositionChanged: (current, total) {
//             setState(() {
//               _currentPosition = '${ current} / ${ total}';
//               _sliderValue = current as double ;
//             });
//           },
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: CircleBorder(),
//                     backgroundColor: Theme.of(context).primaryColor,
//                     padding: EdgeInsets.all(10),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _play = !_play;
//                     });
//                   },
//                   child: Icon(
//                     _play ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: assetsAudioPlayer.builderRealtimePlayingInfos(
//                             builder: (context, RealtimePlayingInfos? infos) {
//                           if (infos == null) {
//                             return SizedBox();
//                           }else{
//                             return PositionSeekWidget(
//                             currentPosition: infos.currentPosition,
//                             duration: infos.duration,
//                             seekTo: (to) {
//                               assetsAudioPlayer.seek(to);
//                             },
//                           );
//                           }
                          
//                         }),
//               ),
//               Text(_currentPosition),
//             ],
//           ).paddingSymmetric(horizontal: 20),
//         ),
          
//       ],
//     );
//   }

//   String _formatDuration(Duration duration) {
//     return DateFormat('mm:ss').format(DateTime(0, 1, 1, 0, 0, duration.inSeconds));
//   }
// }
