// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audio_wave/audio_wave.dart';
// import 'package:http/http.dart'as http;
// import 'package:voice_maker/utils/widget.dart';
// import 'package:voice_maker/viewModel/homeViewModel.dart';


// class VoicePlayer extends StatefulWidget {
//   @override
//   _VoicePlayerState createState() => _VoicePlayerState();
// }

// class _VoicePlayerState extends State<VoicePlayer> {
//   final AudioPlayer audioPlayer = AudioPlayer();

//   Future<void> playAudioFromUrl(String playAudiourl) async {
//     await audioPlayer.play(UrlSource(playAudiourl));
//   }
//   bool isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Voice Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               height: 200,
//               child: StreamBuilder<http.Response>(
//                 stream:HomeViewModel(). fetchData(context),
//                 builder: (context, snapshot) {
// var response = jsonDecode(snapshot.data!.body);
// return ListView.builder(
//                     itemCount:response["data"].length ,
//                     itemBuilder: (BuildContext context, int index) {  
//                   var data=  response["data"][index];
//                   print(response.data);

//                     return
                     
//                  }, );
//                 },
//               ),
//             ),
      
          
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     audioPlayer.stop();
//     super.dispose();
//   }
// }
