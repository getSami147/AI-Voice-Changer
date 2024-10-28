
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Constant.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/sateManagement.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/screens/pitchSetting.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel2.dart';

import '../components/component.dart';
import 'dashboard.dart';
import 'dreemVoice.dart';
import 'genarateAudio.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> pages = [];
  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;

  // PageController pageController = PageController();
  @override
  void initState() {
    var provider = Provider.of<StateManagementClass>(context, listen: false);
    provider.pageControllerMethod();
    super.initState();
  }

  @override
  void dispose() {
    var provider = Provider.of<StateManagementClass>(context, listen: false);
    provider.pageController.dispose();
    super.dispose();
  }

  List<String> svgIcons = [
    svg_Folder,
    svg_Voice,
    svg_generate,
    svg_InventoryDone
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel2>(context);
    return Consumer<StateManagementClass>(
      builder: (context, value, child) => Scaffold(
        appBar: CustomAppBar(
            backPressed:value.initialValue == 0
                            ?  () {
              Navigator.pop(context);
            }:() {
              value.pageController
                  .previousPage(duration: _kDuration, curve: _kCurve);
                  // .then(
                  //     (val) => value.initialValue == 0 ? finish(context) : "");
            },
            backbutton: true,
            title: value.initialValue == 0
                ? appbar_SelectVoice
                : value.initialValue == 1
                    ? appbar_PitchSetting
                    : value.initialValue == 2
                        ? appbar_AudioGenerated
                        : ""),
        body: Column(
          children: [
            value.initialValue == 0
                ? CustomRichText(
                    text1: voice_Selectyour,
                    text2: voice_Selectyour2,
                    colorText2: colorPrimary,
                  ).paddingTop(spacing_twinty)
                : value.initialValue == 1
                    ? CustomRichText(
                        text1: voice_customizePitch,
                        text2: voice_customizePitch2,
                        colorText2: colorPrimary,
                      ).paddingTop(spacing_twinty)
                    : CustomRichText(
                        text1: voice_audioGenarated,
                        text2: voice_audioGenarated2,
                        colorText2: colorPrimary,
                      ).paddingTop(spacing_twinty),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < svgIcons.length; i++,) ...[
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value.initialValue >= i - 1
                                    ? colorPrimary
                                    : const Color(0xffD9D9D9)),
                            child: SvgPicture.asset(
                              svgIcons[i],
                              // ignore: unrelated_type_equality_checks
                              color: value.initialValue >= i - 1
                                  ? color_white
                                  : Colors.grey,
                            )).paddingAll(5),
                      ),
                      i == value.initialValue
                          ? SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 10,
                                color: colorPrimary.withOpacity(.6),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ]
              ],
            )
                .paddingTop(spacing_thirty)
                .paddingSymmetric(horizontal: spacing_twinty),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: value.pageController,
                scrollDirection: Axis.horizontal,
                children:  [
                   DreemVoice(),
                   PitchSetting(),
                GenarateAudio(),
                ],
              ),
            ),
            value.initialValue == 2
                ? Container()
                : GradientButton(
                  loading: provider.generatedloading,
                        onPressed: value.initialValue == 1
                            ? () {

                    //      showDialog(
                    //             barrierDismissible:false,
                    //   context: context,
                    //   builder: (context) {
                    //     return const LoadngIndicator();
                    //   },
                    // );
                                var filePathprovider =Provider.of<UserViewModel>(context,listen: false);
                                var p2 =Provider.of<UserViewModel2>(context,listen: false);
                                Map<String, String> data = {
                                  'voiceType': provider.actorId.toString(),
                                  'PitchChange':provider.pitchChange.toString(),
                                  'OverallPitchChange':provider.pitchChange.toString(),
                                  'VoiceConversionOptions':
                                      '{"IndexRate":"${provider.indexRate / 100}","FilterRadius":${provider.filterRadius.toString()},"RMSMixRate":${provider.rmsMaxRate / 100},"protectRate":${provider.protectRate / 100}}',
                                  'VolumeChange':
                                      '{"MainVocals":${provider.mianVocals.toString()},"BackupVocals":${provider.backupVocals.toString()},"Music":${provider.music.toString()}}',
                                  'ReverbControlOnAIVocals':
                                      '{"RoomSize":${provider.romSize / 100},"WetnessLevel":${provider.wetnessLevel / 100},"DrynessLevel":${provider.drynessLevel / 100},"DampingLevel":${provider.dampingLevel / 100}}',
                                  'isURLRequired': 'true',
                                  'userId': "${filePathprovider.userId}",
                                };
                                HomeViewModel().generateVoice(
                                    context, data, filePathprovider.filePath).then((val)async => {
                                      p2.setLoading(false),
                                      value.pageController.nextPage(
                                        duration: _kDuration, curve: _kCurve),

                                    });
                              }
                            : value.initialValue == 0
                                ? () {
                                    provider.selectedValue == null
                                        ? utils().flushBar(
                                            context, "Please choose the actor")
                                        : value.pageController.nextPage(
                                            duration: _kDuration,
                                            curve: _kCurve);
                                  }
                                : () {
                                    value.pageController.nextPage(
                                        duration: _kDuration, curve: _kCurve);
                                  },
                        child: text(voice_Next,
                            googleFonts: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: textSizeLargeMedium,
                                color: color_white)))
                    .paddingSymmetric(
                        vertical: spacing_twinty, horizontal: spacing_twinty)
          ],
        ),
      ),
    );
  }
}
class LoadngIndicator extends StatelessWidget {
  const LoadngIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(

      backgroundColor: color_white,
      insetPadding: const EdgeInsets.symmetric(horizontal: spacing_xxLarge),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child:Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Generating audio",fontWeight: FontWeight.w500),
              const SizedBox(width: spacing_twinty,),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomRichText extends StatelessWidget {
  String? text1, text2, text3, text4;
  Color? colorText2, colorText3, colorText4 = Colors.black;
  CustomRichText({
    required this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.colorText2,
    this.colorText3,
    this.colorText4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: text1,
            style: GoogleFonts.lato(
                color: Colors.black, fontSize: 33, fontWeight: FontWeight.w700),
            children: [
              TextSpan(text: text2, style: GoogleFonts.lato(color: colorText2)),
              TextSpan(text: text3, style: GoogleFonts.lato(color: colorText3)),
              TextSpan(text: text4, style: GoogleFonts.lato(color: colorText4)),
            ]));
  }
}
