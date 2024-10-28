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
import 'package:voice_changer/view/sateManagement.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/components/component.dart';
import 'package:voice_changer/viewModel/authViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var gendervalue = 'Male';
  bool? ischecked = false;
  final obSecurePassword = ValueNotifier(true);
  final obSecureConfromPassword = ValueNotifier(true);
  // controller
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contectNumberController = TextEditingController();
  // Focus Node
  final nameFouseNode = FocusNode();
  final usernameFouseNode = FocusNode();
  final emailFouseNode = FocusNode();
  final passwordFouseNode = FocusNode();
  final contectNumberFouseNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contectNumberController.dispose();
    nameFouseNode.dispose();
    usernameFouseNode.dispose();
    emailFouseNode.dispose();
    passwordFouseNode.dispose();
    contectNumberFouseNode.dispose();
    obSecurePassword.dispose();
    obSecureConfromPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: signUp_Signup,
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                SignUp_text,
                maxLine: 5,
                isCentered: true,
                googleFonts: GoogleFonts.lato(color: textGreyColor),
              ).paddingOnly(
                  top: spacing_middle,
                  left: spacing_standard_new,
                  right: spacing_standard_new),
              text(
                SignUp_Name,
                googleFonts: GoogleFonts.lato(
                  fontSize: textSizeSMedium,
                ),
              ).paddingTop(spacing_middle),
              textformfield(
                controller: nameController,
                focusNode: nameFouseNode,
                onFieldSubmitted: (value) {
                  utils().formFocusChange(
                      context, nameFouseNode, usernameFouseNode);
                },
                hinttext: SignUp_Name,
              ).paddingTop(spacing_middle),
              text(
                SignUp_userName,
                googleFonts: GoogleFonts.lato(
                  fontSize: textSizeSMedium,
                ),
              ).paddingTop(spacing_middle),
              textformfield(
                controller: usernameController,
                focusNode: usernameFouseNode,
                onFieldSubmitted: (value) {
                  utils()
                      .formFocusChange(context, nameFouseNode, emailFouseNode);
                },
                hinttext: SignUp_userName,
              ).paddingTop(spacing_middle),
              text(
                SignUp_Email,
                googleFonts: GoogleFonts.lato(
                  fontSize: textSizeSMedium,
                ),
              ).paddingTop(spacing_middle),
              textformfield(
                focusNode: emailFouseNode,
                controller: emailController,
                hinttext: LogIn_Email,
                onFieldSubmitted: (value) {
                  utils().formFocusChange(
                      context, nameFouseNode, passwordFouseNode);
                },
              ).paddingTop(spacing_middle),
              text(
                LogIn_password,
                googleFonts: GoogleFonts.lato(),
              ).paddingTop(spacing_standard_new),
              ValueListenableBuilder(
                valueListenable: obSecurePassword,
                builder: (context, value, child) => textformfield(
                  focusNode: passwordFouseNode,
                  controller: passwordController,
                  hinttext: "*********",
                  onFieldSubmitted: (value) {
                    utils().formFocusChange(
                        context, nameFouseNode, contectNumberFouseNode);
                  },
                  suffixIcons: GestureDetector(
                          onTap: () {
                            obSecurePassword.value = !obSecurePassword.value;
                          },
                          child: SvgPicture.asset(
                              obSecurePassword.value ? svg_hide : svg_unHide))
                      .paddingRight(spacing_middle),
                  obscureText: obSecurePassword.value,
                ).paddingTop(spacing_middle),
              ),
              text(
                SignUp_contectNumber,
                googleFonts: GoogleFonts.lato(
                  fontSize: textSizeSMedium,
                ),
              ).paddingTop(spacing_middle),
              textformfield(
                focusNode: contectNumberFouseNode,
                controller: contectNumberController,
                hinttext: SignUp_contectNumber,
                keyboardType: TextInputType.phone,
              ).paddingTop(spacing_middle),
              DropdownButtonFormField(
                borderRadius: BorderRadius.circular(8),
                dropdownColor: color_white,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                elevation: 0,
                value: gendervalue,
                isExpanded: true,
                items: [
                  // DropdownMenuItem<String>(
                  //   value: 'Select the Gender',
                  //   child: text('Select the Gender',
                  //       googleFonts: GoogleFonts.lato(
                  //         fontSize: textSizeSMedium,
                  //       )),
                  // ),
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: text('Female'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Select Sides please';
                  }
                  return null;
                },
                onChanged: (value) {
                  gendervalue = value!;
                },
              ).paddingTop(spacing_twinty),
              CheckboxListTile(
                contentPadding: const EdgeInsets.all(0),
                activeColor: colorPrimary,
                controlAffinity: ListTileControlAffinity.leading,
                title: RichText(
                    text: TextSpan(
                        text: SignUp_Agree,
                        style: GoogleFonts.lato(
                          color: colorPrimary,
                          fontSize: textSizeMedium,
                        ),
                        children: [
                      TextSpan(
                          text: SignUp_Agreetext,
                          style: GoogleFonts.lato(color: textGreyColor)),
                      TextSpan(
                          text: SignUp_Privacy,
                          style: GoogleFonts.lato(color: colorPrimary)),
                      TextSpan(
                          text: " & ",
                          style: GoogleFonts.lato(color: textGreyColor)),
                      TextSpan(
                          text: SignUp_Policy,
                          style: GoogleFonts.lato(color: colorPrimary))
                    ])).paddingTop(spacing_control),
                value: ischecked,
                onChanged: (value) {
                  setState(() {
                    ischecked = value;
                  });
                },
              ),
              Consumer<AuthViewModel>(
                builder: (context, value, child) => GradientButton(
                        loading: value.loading,
                        onPressed: () {
                          if (nameController.text.isEmptyOrNull) {
                            utils().flushBar(context, "Please enter the name");
                          } else if (usernameController.text.isEmptyOrNull) {
                            utils().flushBar(
                                context, "Please enter the unique user name");
                          } else if (emailController.text.isEmptyOrNull) {
                            utils().flushBar(
                                context, "Please enter the email address");
                          } else if (!emailController.text.contains("@")) {
                            utils().flushBar(
                                context, "Please enter the valid email");
                          } else if (passwordController.text.isEmptyOrNull) {
                            utils()
                                .flushBar(context, "Please enter the password");
                          } else if (contectNumberController
                              .text.isEmptyOrNull) {
                            utils().flushBar(
                                context, "Please enter your contect number");
                          } else if (gendervalue.isEmptyOrNull) {
                            utils()
                                .flushBar(context, "Please select the gender");
                          } else {
                            Map data = {
                              "name": nameController.text.trim().toString(),
                              "userName":
                                  usernameController.text.trim().toString(),
                              "email": emailController.text.trim().toString(),
                              "password":
                                  passwordController.text.trim().toString(),
                              "role": "user",
                              "gender": gendervalue.toString(),
                              "userImageURl": "😎",
                              "contact": contectNumberController.text
                                  .trim()
                                  .toString(),
                              "status": "active",
                              "isVerified": false
                            };
                           
                            authViewModel.singUpApi(data, {'Content-Type': 'application/json'}, context);
                          }
                        },
                        child: text(signUp_Signup,
                            textAllCaps: true,
                            googleFonts: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                color: color_white)))
                    .paddingTop(60),
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
              ).paddingTop(spacing_twinty),
              GestureDetector(
                onTap: () {
                  const LoginScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                },
                child: RichText(
                    text: TextSpan(
                        text: SignUp_HaveAccount,
                        style: GoogleFonts.lato(color: Colors.black),
                        children: [
                      TextSpan(
                          text: SignUp_LoginNow,
                          style: GoogleFonts.lato(color: colorPrimary))
                    ])).center().paddingTop(spacing_twinty),
              )
            ],
          ).paddingSymmetric(horizontal: spacing_twinty),
        ),
      ),
    );
  }
}
