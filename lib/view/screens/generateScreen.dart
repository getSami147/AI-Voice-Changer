import 'package:audio_wave_url_package/voice_message_package.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/models/communityAllModel.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Images.dart';
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
  PlayerController controller = PlayerController();

  TextEditingController urlController = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  final fromkey=GlobalKey<FormState>();
  // void playAudio() {
  //   var provider = Provider.of<UserViewModel>(context, listen: false);

  //   if (provider.filePath != null) {
  //     var d= UrlSource(provider. filePath!,);
  //     // DeviceFileSource(filePath);
  //     audioPlayer.play(d);
  //   }
  // }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<UserViewModel>(context, listen: false);
   
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
            Form(
              key: fromkey,
              child: TextFormField(
                controller: urlController,
                keyboardType: TextInputType.url,
               
                decoration: InputDecoration(
                    hintText: generate_EnterURL,
                    suffixIcon: TextButton(
                      onPressed: () {
                 
                        !urlController.text.contains("https://")?utils().flushBar(context,
                                "Please enter the correct URl"):
                        urlController.text.isNotEmpty
                            ? 
                            const VoiceScreen().launch(context,
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

           return consumerfile.filePath!=null?Container(
          padding: const EdgeInsets.only(bottom: 6, right: 10, top: 6),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(.05),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (!controller.playerState.isStopped)
         controller.playerState.isPlaying?   IconButton(
                onPressed: () async {
                  //  playAudioFromUrl(data["audioURL"].toString());

       await controller.preparePlayer(
      path: consumerfile.filePath,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
                  if (controller.playerState.isPlaying) {
                    await controller.pausePlayer();
                  } else {
                    await controller.startPlayer(finishMode: FinishMode.stop,);
                  }
                 
                },
                icon: const Icon(
                   Icons.stop,     
                  color: Colors.blue, // Replace with your color
                ),
                color: Colors.orange,
                highlightColor: Colors.blue.withOpacity(.5),
              ): IconButton(
                onPressed: () async {
                  //  playAudioFromUrl(data["audioURL"].toString());

       await controller.preparePlayer(
      path: consumerfile.filePath,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
    // print(consumerfile.filePath);
                  if (controller.playerState.isPlaying) {
                    await controller.pausePlayer();
                  } else {
                    await controller.startPlayer(finishMode: FinishMode.stop,);
                  }
                 
                },
                icon: Icon(
                  controller.playerState.isPlaying
                      ? Icons.stop
                      : Icons.play_arrow,
                  color: Colors.blue, // Replace with your color
                ),
                color: Colors.orange,
                highlightColor: Colors.blue.withOpacity(.5),
              ),
              AudioFileWaveforms(
                size: Size(MediaQuery.of(context).size.width / 1.5, 40),
                playerController: controller,
                backgroundColor: Colors.blueGrey, // Replace with your color
                continuousWaveform: true,
                enableSeekGesture: true,
                waveformData: [],
                waveformType: WaveformType.fitWidth,
                playerWaveStyle: const PlayerWaveStyle(
                  seekLineColor: Colors.pink,
                  backgroundColor: Colors.yellow,
                  fixedWaveColor: Colors.white54,
                  liveWaveColor: Colors.blue, // Replace with your color
                  spacing: 6,
                  showBottom: true,
                  
                ),
              ),
            ],
          ),
        ):
             GradientButton( 
                      onPressed: () {
                        consumerfile.pickAudio();
                        // const VoiceScreen().launch(context);
                      },
                      child: text(generate_Uploadfile,
                          googleFonts: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: textSizeLargeMedium,
                              color: color_white)))
                  .paddingTop(spacing_standard_new); },
            ),
            const SizedBox(height: 20),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
