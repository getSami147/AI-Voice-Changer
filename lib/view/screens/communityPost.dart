import 'package:audio_wave_url_package/voice_message_package.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:voice_maker/viewModel/UserViewModel.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';

class communityPost extends StatefulWidget {
  var userId;
   communityPost({required this.userId, super.key});

  @override
  State<communityPost> createState() => _communityPostState();
}

class _communityPostState extends State<communityPost> {
  final messegeController = TextEditingController();
  final messegeFocusNode = FocusNode();
  var filePath;
  void pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
        filePath = result.files.first.path!;
        setState(() {
          
        });
        utils().toastMethod("Audio File Picked");
        
    }
  }

  void playAudio() {
    if (filePath  != null) {
      var d = UrlSource(
        filePath!,
      );
      // DeviceFileSource(filePath);
      
    }
  }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);

    return Dialog(
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: spacing_twinty),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        child: InkWell(autofocus: true,
          onTap: () {
            
             Navigator.pop(context);
          },
          child: Container(
            height: 480,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
        
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        "Post Details*",
                        googleFonts: GoogleFonts.lato(
                          fontSize: textSizeMedium,
                          color: blackColor.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                        ),
                      ).paddingTop(spacing_twinty),
                      textformfield(
                        controller: messegeController,
                        hight: 150.0,
                        maxLine: 30,
                        obscureText: false,
                        filledColor: filledColor,
                        hinttext: "Write Somthing here..",
                      ).paddingTop(spacing_control),
                    filePath != null
                          ? 
                          VoiceMessage(
                              audioSrc: filePath.toString(),
                              played: true, // To show played badge or not.
                              me: true, // Set message side.
                              meBgColor: black.withOpacity(.05),
                              noiseWidth: double.infinity,
                              width: double.infinity,
                              meFgColor: colorPrimary,
                              mePlayIconColor: whiteColor,
                              duration: const Duration(minutes: 5),
                              showDuration: true,
                              noiseCount: 30,
                              onPlay: () {
                                // playAudio();
                              },
                              header: {}, // Do something when voice played.
                            )
                            .paddingTop(spacing_twinty)
                          : Row(
                              children: [
                                text("Choose audio file"),
                                TextButton(
                                    style: const ButtonStyle(),
                                    onPressed: () {
                                      pickAudio();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          svg_uplaod,
                                          height: 20,
                                          width: 20,
                                          color: colorPrimary,
                                        ),
                                        //  text("Pick Voice").paddingLeft(spacing_middle),
                                      ],
                                    )),
                              ],
                            ).paddingTop(spacing_thirty),
                      const Divider().paddingTop(spacing_middle),
                      GradientButton(
                          onPressed: () {
                           Map<String, String> data = {
                              "audioURL":filePath.toString(),
                              'communityDescription':messegeController.text.trim().toString(),
                              'referenceToUser': "${widget.userId}",
                            };
                            // print(data);
                            HomeViewModel().comunityPost(context,filePath, data);
                            messegeController.clear();
                            messegeFocusNode.unfocus();
                            finish(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                svg_uplaod,
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: spacing_standard_new,
                              ),
                              text("Upload Post",
                                  googleFonts: GoogleFonts.lato(
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSizeLargeMedium,
                                      color: color_white)),
                            ],
                          )).paddingTop(spacing_standard_new),
                    ],
                  ),
                
                Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle),
                  child: GestureDetector(
                      onTap: () {
                        
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ).paddingAll(2)),
                )
              ],
            ).paddingSymmetric(
                vertical: spacing_twinty, horizontal: spacing_standard_new),
          ),
        ),
      ),
    );
  }
}
