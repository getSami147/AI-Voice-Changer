import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/assetAudioPlayer.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/screens/Community.dart';
import 'package:voice_changer/view/screens/communityGeneratedPost.dart';
import 'package:voice_changer/view/screens/communityPost.dart';
import 'package:voice_changer/view/screens/voiceScreen.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

import '../../utils/Constant.dart';
import '../../utils/string.dart';

class GenarateAudio extends StatefulWidget {
  // var generateURl;
  // Map<String, String>? data;
  GenarateAudio({ super.key});

  @override
  State<GenarateAudio> createState() => _GenarateAudioState();
}

class _GenarateAudioState extends State<GenarateAudio> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudioFromUrl(String playAudiourl) async {
    await audioPlayer.play(UrlSource(playAudiourl));
  }
    var isplayed=false;

  playStop(){
    isplayed=!isplayed;
  }

Future<void> download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var savingPath = Directory("/storage/emulated/0/Download/AIVoice");
      savingPath.createSync(recursive: true);
      try {
        await FlutterDownloader.enqueue(
          url: url,
          headers: {}, // optional: header send with url (auth token etc)
          savedDir: savingPath.path,
          showNotification: true, // show download progress in status bar (for Android)
          saveInPublicStorage: true,  
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        );
      } catch (e) {
        print("Download failed: $e");
      }
    } else {
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
   var provider= Provider.of<UserViewModel>(context,listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: ClipOval(
                        child: Image.asset(
                          profilePic,
                        ),
                      ),
                    ),
                    text(
                      "Sami Ullah",
                      googleFonts: GoogleFonts.lato(
                          fontSize: textSizeLargeMedium,
                          fontWeight: FontWeight.w600),
                    ).paddingTop(spacing_twinty),
                    text(
                      "Pakistan",
                      googleFonts: GoogleFonts.lato(
                          fontSize: textSizeSMedium,
                          fontWeight: FontWeight.w500),
                    ).paddingTop(spacing_control_half),
                      AssetAudioPlayer(
                         audioUrl:  provider.url.toString(),
                          imageUrl: "",
                          name: 'Sami Ullah',
                          appName: 'AI Voice Changer', 
                        ).paddingTop(spacing_twinty),
                    Row(
                      children: [
                        Expanded(
                          child: GradientButton(
                              onPressed: () {
                                 download(provider.url);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    svg_Download,
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: spacing_standard_new,
                                  ),
                                  text("Download",
                                      googleFonts: GoogleFonts.lato(
                                          fontWeight: FontWeight.w500,
                                          fontSize: textSizeLargeMedium,
                                          color: color_white)),
                                ],
                              )).paddingTop(spacing_standard_new),
                        ),
                        const SizedBox(
                          width: spacing_standard_new,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: textGreyColor,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  // communityPost (Dialog Box) is Called.............>>>
                                  return  communityGeneratedPost(data:provider. data, generateURl:provider.url);
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              svg_shareFilled,
                              height: 25,
                              width: 25,
                              color: Colors.black,
                            ).paddingAll(10),
                          ),
                        ).paddingTop(spacing_standard_new),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    vertical: spacing_twinty, horizontal: spacing_standard_new),
              ).paddingTop(spacingBig),
            ],
          ).paddingSymmetric(horizontal: spacing_twinty),
        ),
      ),
    );
  }
}
