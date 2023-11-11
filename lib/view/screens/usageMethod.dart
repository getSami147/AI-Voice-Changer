import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/components/component.dart';
import '../../utils/string.dart';

class UsageMathod extends StatelessWidget {
  const UsageMathod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backbutton: true,
        backPressed: () {
          finish(context);
        },
        title: appbar_Use,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsageSteps(
                title: usage_PastAudio,
                explaination: usage_PastAudioExplain,
                image: uploadingVoiceMethod),
            UsageSteps(
                title: usage_selesctAudio,
                explaination: usage_selesctAudioExplain,
                image: selectAudio),
            UsageSteps(
                title: usage_usePitches,
                explaination: usage_usePitchesExplian,
                image: customizePitch),
            UsageSteps(
                title: usage_audioResult,
                explaination: usage_audioResultExplain,
                image: result)
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}

// ignore: must_be_immutable
class UsageSteps extends StatelessWidget {
  var title;
  var explaination;
  var image;

  UsageSteps({
    required this.title,
    required this.explaination,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(
          title.toString(),
          googleFonts: GoogleFonts.lato(
              fontSize: textSizeLargeMedium, fontWeight: FontWeight.w700),
        ).paddingTop(spacing_twinty),
        text(
          explaination.toString(),
          maxLine: 10,
          googleFonts: GoogleFonts.lato(
              fontSize: textSizeMedium, fontWeight: FontWeight.w400),
        ).paddingTop(
          spacing_standard,
        ),
        Image.asset(
          image.toString(),
          width: 300,
          fit: BoxFit.cover,
        ).paddingSymmetric(vertical: spacing_xxLarge).center(),
      ],
    );
  }
}
