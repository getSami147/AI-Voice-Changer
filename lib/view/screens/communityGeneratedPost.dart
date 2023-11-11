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

class communityGeneratedPost extends StatefulWidget {
  var generateURl;
  Map<String, String>? data;
  communityGeneratedPost(
      {required this.data, required this.generateURl, super.key});

  @override
  State<communityGeneratedPost> createState() => _communityGeneratedPostState();
}

class _communityGeneratedPostState extends State<communityGeneratedPost> {
  final messegeController = TextEditingController();
  final messegeFocusNode = FocusNode();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    // var time = DateTime.now().toString();
    return Dialog(
      backgroundColor: whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: spacing_twinty),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
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
                  text("Post to Commnunity",
                      googleFonts: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: textSizeNormal,
                      )),
                  text(
                      "Join the discussion and share your thoughts on our latest community initiative! Your voice matters",
                      googleFonts: GoogleFonts.lato(
                        fontSize: textSizeSMedium,
                        color: blackColor.withOpacity(0.4),
                      ),
                      maxLine: 5),
                  text(
                    "Post Details",
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

                    // hinttext: ContactUs_Name,
                  ).paddingTop(spacing_control),
                  GradientButton(
                      onPressed: () {
                        Map<String, String> postdata = {
                          "audioURL": widget.generateURl,
                          "referenceToUser": widget.data!["userId"].toString(),
                          'referenceToVoice':
                              widget.data!["voiceType"].toString(),
                          'communityDescription':
                              messegeController.text.trim().toString(),
                          // "createdAt":"",
                        };
                        HomeViewModel().shareToCommunityPost(context, postdata);
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
                      )).paddingTop(spacing_thirty),
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
    );
  }
}
