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

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';


class WaveformAudioPlayerClass extends StatefulWidget {
  final String audioUrl;

  const WaveformAudioPlayerClass({required this.audioUrl, Key? key}) : super(key: key);

  @override
  _WaveformAudioPlayerClassState createState() => _WaveformAudioPlayerClassState();
}

class _WaveformAudioPlayerClassState extends State<WaveformAudioPlayerClass> {
  // late AudioController _audioController;

  @override
  void initState() {
    super.initState();
    // _audioController = AudioController(url: widget.audioUrl, onLoading: () {});
  }

  @override
  void dispose() {
    // _audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WaveformAudioPlayerClass(audioUrl: "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3"),
        // ElevatedButton(
        //   onPressed: () {
        //     // if (_audioController.isPlaying) {
        //     //   _audioController.pause();
        //     // } else {
        //     //   _audioController.play();
        //     // }
        //   },
        //   child: Text(_audioController.isPlaying ? 'Pause' : 'Play'),
        // ),
      ],
    );
  }
}
