import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/assetAudioPlayer.dart';
import 'package:voice_maker/audioplay.dart';
import 'package:voice_maker/models/communityAllModel.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/audioPlayerdemo.dart';
import 'package:voice_maker/utils/string.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/sateManagement.dart';
import 'package:voice_maker/view/screens/usageMethod.dart';
import 'package:voice_maker/view/screens/voiceScreen.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';
import '../../utils/Constant.dart';
import '../authView/logIn.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  TextEditingController urlController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  final fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<UserViewModel>(context, listen: false);
print("object");
    return Scaffold(
      appBar: CustomAppBar(
        title: appbar_Generate,
        sideIcon: svg_information,
        onTap: () {
          const UsageMathod()
              .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: generate_GenerateVoice,
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 33,
                        fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                          text: generate_Explore,
                          style: GoogleFonts.lato(color: colorPrimary)),
                      TextSpan(
                          text: generate_your,
                          style: GoogleFonts.lato(color: black)),
                      TextSpan(
                          text: generate_Idea,
                          style: GoogleFonts.lato(color: colorPrimary)),
                    ])).paddingTop(spacing_twinty),
            Image.asset(uploadVoice).paddingTop(spacing_thirty),
            AssetAudioPlayer(
              audioUrl:'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
              imageUrl: "",
              name: 'Sami Ullah',
              appName: 'AI Voice Changer',
            ),

            Form(
              key: fromkey,
              child: TextFormField(
                controller: urlController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                    hintText: generate_EnterURL,
                    suffixIcon: TextButton(
                      onPressed: () {
                        !urlController.text.contains("https://")
                            ? utils().flushBar(
                                context, "Please enter the correct URl")
                            : urlController.text.isNotEmpty
                                ? const VoiceScreen().launch(context,
                                    pageRouteAnimation: PageRouteAnimation.Fade)
                                : utils().flushBar(context,
                                    "Please enter the Url or Pick the file from internal Storage");

                        // provider.initialValue++;
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: colorPrimary, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: color_white,
                          size: 15,
                        ),
                      ),
                    ),
                    enabled: true,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary)),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: colorPrimary),
                    )),
              ).paddingTop(spacingBig),
            ),
            text("Or").paddingTop(spacing_standard_new),
            Consumer<UserViewModel>(
              builder: (BuildContext context, consumerfile, Widget? child) {
                return GradientButton(
                        onPressed: () {
                          consumerfile.pickAudio();
                          const VoiceScreen().launch(context);
                        },
                        child: text(generate_Uploadfile,
                            googleFonts: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: textSizeLargeMedium,
                                color: color_white)))
                    .paddingTop(spacing_standard_new);
              },
            ),
            const SizedBox(height: 20),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
