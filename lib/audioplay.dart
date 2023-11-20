
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration postion = Duration.zero;

//   void playerAudiourl(String url) async {
//     await player.play(UrlSource(url));
//   }

//   void stopAudio() {
//     player.stop();
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   @override
//   void initState() {
//     setAudio();
//     player.onPlayerStateChanged.listen((State) {
//       setState(() {
//         isPlaying = State == PlayerState.playing;
//       });
//     });
//     player.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//     player.onPositionChanged.listen((newPosition) {
//       setState(() {
//         postion = newPosition;
//       });
//     });

//     super.initState();
//   }

//   Future setAudio() async {
//     player.setReleaseMode(ReleaseMode.stop);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('HomeScreen'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // FutureBuilder(
//             //   future: AuthViewModel().getMeApi(context),
//             //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//             //     if (snapshot.connectionState == ConnectionState.waiting) {
//             //       return const Center(child: CircularProgressIndicator());
//             //     } else if (snapshot.hasError) {
//             //       return Text(" error :${e.toString()}");
//             //     } else {
//             //       //print('data......${snapshot.data}');
//             //       return Container();
//             //     }
//             //   },
//             // ),
//             Column(
//               children: [
//                 Column(
//                   children: [
//                     Slider(
//                         min: 0,
//                         max: duration.inSeconds.toDouble(),
//                         value: postion.inSeconds.toDouble(),
//                         onChanged: (value) async {
//                           final position = Duration(seconds: value.toInt());
//                           await player.seek(position);
//                           await player.resume();
//                         }),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(formatTime(postion)),
//                           Text(formatTime(duration - postion))
//                         ],
//                       ),
//                     ),
//                     CircleAvatar(
//                       radius: 35,
//                       child: Center(
//                         child: IconButton(
//                           onPressed: () async {
//                             if (isPlaying) {
//                               await player.pause();
//                             } else {
//                               player.play(UrlSource(
//                                       'https://multivendorswedenuzrtech.s3.amazonaws.com/v1-mixkit-female-microphone-countdown-341.wav')

//                                   // snapshot.data['data'][0]['audioURL']

//                                   );
//                               setState(() {
//                                 isPlaying = true;
//                               });
//                             }
//                           },
//                           icon: Icon(
//                             isPlaying ? Icons.pause : Icons.play_arrow,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
              
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');

//     final houres = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [if (duration.inHours > 0) houres, minutes, seconds].join(':');
//   }
// }