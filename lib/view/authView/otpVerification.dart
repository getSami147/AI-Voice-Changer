import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/restPassword.dart';
import 'package:voice_changer/view/components/component.dart';

import 'logIn.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: OTP_text,
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(
              OTP_Subtitle,
              maxLine: 5,
              googleFonts: GoogleFonts.lato(),
            ).paddingOnly(
                top: spacing_middle,
                left: spacing_middle,
                right: spacing_middle),
            const CustomOTPCode().paddingTop(60),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(2)),
              child: text(
                "01:02",
                googleFonts: GoogleFonts.lato(fontWeight: FontWeight.w500),
              ).paddingSymmetric(horizontal: 5),
            ).center().paddingTop(spacing_xxLarge),
            text(
              OTP_Resend,
              textAllCaps: true,
              googleFonts: GoogleFonts.lato(
                  fontSize: textSizeMedium,
                  fontWeight: FontWeight.w500,
                  color: colorPrimary),
            ).center().paddingTop(spacingBig),
            GradientButton(
                    onPressed: () {
                      const ResetPassword().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    child: text(OTP_Submit,
                        textAllCaps: true,
                        googleFonts: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, color: color_white)))
                .paddingTop(spacing_twinty),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
