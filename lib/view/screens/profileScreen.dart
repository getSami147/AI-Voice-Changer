import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/res/appUrl.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/colors.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/components/component.dart';

import 'package:http/http.dart' as http;
import 'package:voice_changer/viewModel/authViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  // final emailFouseNode = FocusNode();
  final nameFouseNode = FocusNode();
  final emailFouseNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.sizeOf(context);
var provider=Provider.of<UserViewModel>(context,listen: false);
  nameController.text= provider.getname;
  emailController.text= provider.getemail;
      return Scaffold(
      appBar: CustomAppBar(
        title: appbar_MyProfile,
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: FutureBuilder(
        future: AuthViewModel().getMeApi(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child:
                    text(snapshot.error.toString()).paddingTop(spacing_thirty));
          } else {
            var data = snapshot.data["data"]["me"];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UserViewModel>(
                    builder: (BuildContext context, value, Widget? child) =>
                        Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: colorPrimary,
                          child: value.image == null
                              ? ClipOval(
                                  child: Image.network(
                                  data["userImageURl"].toString(),
                                  height: size.width * .23,
                                  width: size.width * .23,
                                  fit: BoxFit.cover,
                                ))
                              : ClipOval(
                                  child: Image.file(
                                    File(value.image!.path).absolute,
                                    height: size.width * .24,
                                    width: size.width * .24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                color: colorPrimary, shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: () {
                                value.getImages();
                              },
                              icon: const Icon(Icons.edit_outlined),
                              color: whiteColor,
                              iconSize: 20,
                            ))
                      ],
                    ).center(),
                  ),
                  text(data["name"].toString(),
                          fontSize: textSizeLargeMedium,
                          fontWeight: FontWeight.w600)
                      .paddingTop(spacing_middle),
                  text(data["email"].toString(),
                      fontSize: 11.0, textColor: textGreyColor),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stack(
                        //   alignment: Alignment.bottomRight,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 55,
                        //       backgroundColor: colorPrimary,
                        //       child:provider.image==null? ClipOval(
                        //           child: Image.asset(
                        //         profilePic,
                        //         height: size.width * .23,
                        //         width: size.width * .23,
                        //         fit: BoxFit.cover,
                        //       )):ClipOval(
                        //         child: Image.file(
                        //           File(provider.image!.path).absolute,
                        //           height: size.width * .24,
                        //         width: size.width * .24,
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //         alignment: Alignment.center,
                        //         height: 35,
                        //         width: 35,
                        //         decoration: const BoxDecoration(
                        //             color: colorPrimary, shape: BoxShape.circle),
                        //         child: IconButton(
                        //           onPressed: () {
                        //           provider.getImages();

                        //           },
                        //           icon: const Icon(Icons.edit_outlined),
                        //           color: whiteColor,
                        //           iconSize: 20,
                        //         ))
                        //   ],
                        // ).center(),

                        text(
                          ContactUs_Name,
                          googleFonts: GoogleFonts.lato(
                            fontSize: textSizeMedium,
                            color: blackColor.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textformfield(
                          controller: nameController,
                          focusNode: nameFouseNode,
                          onFieldSubmitted: (value) {
                            utils().formFocusChange(
                                context, emailFouseNode, emailFouseNode);
                          },
                          obscureText: false,
                          filledColor: filledColor,
                          hinttext: ContactUs_Name,
                        ).paddingTop(spacing_control),
                        text(
                          ContactUs_Email,
                          googleFonts: GoogleFonts.lato(
                            fontSize: textSizeMedium,
                            color: blackColor.withOpacity(0.4),
                            fontWeight: FontWeight.w600,
                          ),
                        ).paddingTop(spacing_twinty),
                        textformfield(
                          controller: emailController,
                          focusNode: emailFouseNode,
                          obscureText: false,
                          filledColor: filledColor,
                          hinttext: ContactUs_Email,
                        ).paddingTop(spacing_control),
                        GradientButton(
                                onPressed: () {
                                  AuthViewModel().updateMe(
                                      context,
                                      nameController.text.trim().toString(),
                                      emailController.text.trim().toString());
                                  // print(body);
                                },
                                child: text(ContactUs_Submit,
                                    googleFonts: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        fontSize: textSizeLargeMedium,
                                        color: color_white)))
                            .paddingTop(spacing_xxLarge)
                      ],
                    ).paddingSymmetric(
                        vertical: spacing_twinty,
                        horizontal: spacing_standard_new),
                  ).paddingSymmetric(vertical: spacing_twinty)
                ],
              ),
            );
          }
        },
      ).paddingSymmetric(horizontal: spacing_large),
    );
  }
}
