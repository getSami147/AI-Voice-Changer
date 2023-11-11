import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/constant.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/sateManagement.dart';
import 'package:voice_maker/view/authView/forgotPassword.dart';
import 'package:voice_maker/view/authView/signUp.dart';
import 'package:voice_maker/view/screens/dashboard.dart';
import 'package:voice_maker/viewModel/authViewModel.dart';

import '../../utils/Colors.dart';
import '../../utils/string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFouseNode = FocusNode();
  final passwordFouseNode = FocusNode();

  final obSecurePassword = ValueNotifier(true);
  final formkey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFouseNode.dispose();
    passwordFouseNode.dispose();
    obSecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(title: LogIn_Login),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                  LogIn_text,
                  maxLine: 5,
                  isCentered: true,
                  googleFonts: GoogleFonts.lato(color: textGreyColor),
                ).paddingOnly(
                    top: spacing_middle,
                    left: spacing_standard_new,
                    right: spacing_standard_new),
                text(
                  LogIn_Email,
                  googleFonts: GoogleFonts.lato(
                    fontSize: textSizeSMedium,
                  ),
                ).paddingTop(spacing_middle),
                textformfield(
                  controller: emailController,
                  
                  focusNode: emailFouseNode,
                  onFieldSubmitted: (value) {
                    utils().formFocusChange(
                        context, emailFouseNode, passwordFouseNode);
                  },
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  hinttext: "Please enter email",
                ).paddingTop(spacing_middle),
                text(
                  LogIn_password,
                  googleFonts: GoogleFonts.lato(),
                ).paddingTop(spacing_standard_new),
                ValueListenableBuilder(
                  valueListenable: obSecurePassword,
                  builder: (context, value, child) => textformfield(
                    controller: passwordController,
                    focusNode: passwordFouseNode,
                    obscureText: obSecurePassword.value,
                    suffixIcons: GestureDetector(
                            onTap: () {
                              obSecurePassword.value = !obSecurePassword.value;
                            },
                            child: SvgPicture.asset(
                                obSecurePassword.value ? svg_hide : svg_unHide))
                        .paddingRight(spacing_middle),
                    hinttext: "Please enter Password",
                  ).paddingTop(spacing_middle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                            onPressed: () {
                              const ForgotPassword().launch(context);
                            },
                            child: text(LogIn_Forgot,
                                googleFonts:
                                    GoogleFonts.lato(color: colorPrimary)))
                        .paddingTop(spacing_control),
                  ],
                ),
                Consumer<AuthViewModel>(
                  builder: (context, value, child) => GradientButton(
                          loading: value.loading,
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              utils().flushBar(
                                  context, "Please Enter the email address");
                            } else if (!emailController.text.contains("@")) {
                              utils().flushBar(
                                  context, "Please Enter the Valid email");
                            } else if (passwordController.text.isEmptyOrNull) {
                              utils().flushBar(
                                  context, "Please Enter the password");
                            } else if (passwordController.text.length < 6) {
                              utils().flushBar(context,
                                  "The password charators should not less then 6");
                            } else {
                              try{
                              Map data = {
                                "email": emailController.text.trim().toString(),
                                "password":
                                    passwordController.text.trim().toString(),
                              };
                              authViewModel.loginApi(
                                  data,
                                  {'Content-Type': 'application/json',},
                                  context);
                              }catch(e){
                                utils().flushBar(context, e.toString());
                              }
                            }
                          },
                          child: text(LogIn_LOGIN,
                              textAllCaps: true,
                              googleFonts: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: color_white)))
                      .paddingTop(70),
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                    text(LogIn_OR,
                            googleFonts:
                                GoogleFonts.lato(fontWeight: FontWeight.w500))
                        .paddingSymmetric(horizontal: spacing_standard)
                        .center(),
                    const Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                  ],
                ).paddingTop(spacing_xxLarge),
                // GestureDetector(
                //   onTap: () {},
                //   child: Center(
                //       child: SvgPicture.asset(
                //     svg_GoogleLogo,
                //     height: 64,
                //     width: 64,
                //     fit: BoxFit.cover,
                //   )).paddingTop(spacing_thirty),
                // ),
                TextButton(
                  onPressed: () {
                    const SignUpScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                  child: RichText(
                      text: TextSpan(
                          text: LogIn_DontHaveAccount,
                          style: GoogleFonts.lato(color: Colors.black),
                          children: [
                        TextSpan(
                            text: LogIn_RegisterNow,
                            style: GoogleFonts.lato(color: colorPrimary))
                      ])).center().paddingTop(spacing_thirty),
                )
              ],
            ).paddingSymmetric(horizontal: spacing_twinty),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  VoidCallback? backPressed;
  VoidCallback? onTap;
  String? sideIcon;
  bool? backbutton = false;

  CustomAppBar(
      {super.key,
      this.backPressed,
      required this.title,
      this.onTap,
      this.sideIcon,
      this.backbutton});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.white);
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
          color: color_white,
          boxShadow: [
            BoxShadow(
                color: textColorPrimary.withOpacity(.10),
                blurRadius: 24,
                offset: const Offset(0, 4))
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(20),
              bottomRight: radiusCircular(20))),
      child: Row(
        children: [
          backbutton == true
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                  onPressed: backPressed,
                )
              : const IconButton(onPressed: null, icon: Icon(null)),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(title.toString(),
                          isCentered: true,
                          googleFonts: GoogleFonts.lato(
                              fontSize: 22.0, fontWeight: FontWeight.w600))
                      .paddingLeft(spacing_middle),
                  GestureDetector(
                    onTap: onTap,
                    child: SvgPicture.asset(sideIcon.toString())
                        .paddingLeft(spacing_middle),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(null),
            onPressed: () {},
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 20);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
