import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/res/appUrl.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/components/component.dart';
import 'package:voice_changer/viewModel/authViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final tokenController= TextEditingController();
  final passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Rest_RestPassword,
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
              Rest_RestSubtitle,
              maxLine: 5,
              googleFonts: GoogleFonts.lato(),
            ).paddingOnly(
                top: spacing_middle,
                left: spacing_standard_new,
                right: spacing_standard_new),
            text(
              Rest_NewPassword,
              googleFonts: GoogleFonts.lato(
                fontSize: textSizeSMedium,
              ),
            ).paddingTop(spacing_middle),
            textformfield(
              
              controller: tokenController,
              hight: 60.0,

              hinttext: "Token",

              fontSize: 12.0,
            ).paddingTop(spacing_middle),
            text(
              Rest_ConfirmPassword,
              googleFonts: GoogleFonts.lato(),
            ).paddingTop(spacing_standard_new),
            textformfield(
              controller: passwordController,
              // obscureText: true,
              hinttext: "*********",
            ).paddingTop(spacing_middle),
           Consumer<AuthViewModel>(builder: (context, value, child) =>  
           GradientButton(
                    loading: value.loading,
                    onPressed: () {
                       var headers = {
                        'Content-Type': 'application/json ',
                      };
                      
                      AuthViewModel().restPasswordApi(
                          {"password": passwordController.text.trim().toString()},
                          headers,
                          context);

                    },
                    child: text("Conform",
                        textAllCaps: true,
                        googleFonts: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, color: color_white))),)
                .paddingTop(70),
          ],
        )
        .paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
