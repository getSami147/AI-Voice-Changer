import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Constant.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/authView/otpVerification.dart';
import 'package:voice_changer/view/authView/restPassword.dart';
import 'package:voice_changer/view/components/component.dart';
import 'package:voice_changer/viewModel/authViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: Forgot_ForgetPassword,
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
              Forgot_text,
              maxLine: 5,
              textColor: textGreyColor,
              googleFonts: GoogleFonts.lato(color: textGreyColor),
            ).paddingOnly(
                top: spacing_middle,
                left: spacing_middle,
                right: spacing_middle),
            text(
              Forgot_Email,
              googleFonts: GoogleFonts.lato(
                fontSize: textSizeSMedium,
              ),
            ).paddingTop(spacing_twinty),
            textformfield(
              hinttext: LogIn_Email,
              controller: emailController,
            ).paddingTop(spacing_middle),
           Consumer<AuthViewModel>(builder: (context, value, child) => 
            GradientButton(
                    loading: value.loading,

                    onPressed: () {
                      // var headers = {
                      //   'Content-Type': 'application/json',
                      //   'Authorization': 'Bearer ${provider.logintoken}'
                      // };
                      
                      // AuthViewModel().forgotApi(
                      //     {"email": emailController.text.trim().toString()},
                      //     headers,
                      //     context);
                      const ResetPassword().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    child: text(Forgot_SendCode,
                        textAllCaps: true,
                        googleFonts: GoogleFonts.lato(
                            fontWeight: FontWeight.w500, color: color_white))),)
                .paddingTop(150),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
