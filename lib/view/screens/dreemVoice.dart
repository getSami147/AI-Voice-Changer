import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/repository/homeRepository.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/view/screens/voiceScreen.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel2.dart';

import '../../utils/Constant.dart';
import '../../utils/string.dart';
import '../../utils/widget.dart';

class DreemVoice extends StatefulWidget {

  const DreemVoice({ super.key});

  @override
  State<DreemVoice> createState() => _DreemVoiceState();
}

class _DreemVoiceState extends State<DreemVoice> {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(String url) async {
    await audioPlayer.play(UrlSource(url));
  }
  @override
  Widget build(BuildContext context) {
     var provider =Provider.of<UserViewModel2>(context,listen: false);
    print('object');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                    future: HomeViewModel().voiceGetAll(context),
                    builder: (BuildContext context, AsyncSnapshot snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CustomLoadingIndicator(),
                              )
                            : snapshot.hasError
                                ? Center(child: text(snapshot.error.toString()))
                                // : Consumer<UserViewModel2>(
                                //   builder: (BuildContext context, value, Widget? child) {  
                                //   return 
                                 : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshot.data["data"].length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                       
                                
                                        var data = snapshot.data["data"][index];
                                
                                        bool? isSelected =
                                            provider.selectedValue == index;
                                
                                        return Card(
                                          elevation: 0,
                                          color: whiteColor,
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            selected: isSelected,
                                            onTap: () {
                                              // print(provider.actorId);
                                              // print(provider.selectedValue);
                                              provider.selectActorMethod(index,data["_id"].toString());
                                            },
                                            horizontalTitleGap: -10,
                                            contentPadding:
                                                const EdgeInsets.only(right: 10),
                                            selectedTileColor: isSelected
                                                ? colorPrimary
                                                : Colors.white,
                                            leading: CircleAvatar(
                                              radius: 55,
                                              child: ClipOval(
                                                child: Image.network(
                                                  data["voiceImageURL"]
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            title: text(
                                              data["voiceName"].toString(),
                                              googleFonts: GoogleFonts.lato(
                                                  color: isSelected
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontSize: textSizeLargeMedium,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                text(
                                                  data["voiceType"].toString(),
                                                  googleFonts: GoogleFonts.lato(
                                                      color: isSelected
                                                          ? whiteColor
                                                          : blackColor,
                                                      fontSize: textSizeSMedium,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                text(
                                                  data["trainedLanguage"]
                                                      .toString(),
                                                  googleFonts: GoogleFonts.lato(
                                                      color: isSelected
                                                          ? whiteColor
                                                          : blackColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                playAudio(data["demoVoiceURL"]
                                                    .toString());
                                
                                                // data["demoVoiceURL"].toString();
                                              },
                                              icon: SvgPicture.asset(
                                                svg_playOutline,
                                                color: isSelected
                                                    ? whiteColor
                                                    : blackColor,
                                                height: 33,
                                                width: 33,
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                // },)
                                )
                .paddingTop(
                  spacing_xlarge,
                )
                .paddingSymmetric(horizontal: spacing_twinty),
          ),
        ],
      ),
    );
  }
}
