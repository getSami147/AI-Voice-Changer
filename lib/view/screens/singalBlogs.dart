import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';

class SingalBlogs extends StatelessWidget {
var blogId;
   SingalBlogs({required this.blogId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: appbar_SingleBlog,
          backbutton: true,
          backPressed: () {
            finish(context);
          },
        ),
        body: FutureBuilder(
          future: HomeViewModel().singleBlogApi(context, blogId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            } else if (snapshot.hasError) {
              return text(snapshot.error.toString());
            } else {
              var data = snapshot.data["data"];
              return ListView.builder(
               itemCount: 1,
               shrinkWrap: true,
               physics: const BouncingScrollPhysics(),
               itemBuilder: (context, index) {
                return  Card(
                   margin:
                       const EdgeInsets.symmetric(vertical: spacing_middle),
                   elevation: 0,
                   color: whiteColor,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                         child: Image.network(
                           data[0]["blogThumbURL"].toString(),
                           height: 300,
                           width: double.infinity,
                           fit: BoxFit.cover,
                         ),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           text(
                             "${data[0]["uploadedBy"].toString()}|",
                             googleFonts: GoogleFonts.lato(
                                 fontSize: textSizeLargeMedium,
                                 color: colorPrimary,
                                 fontWeight: FontWeight.w500),
                           ),
                           text(
                             DateFormat("yMMMMEEEEd").format(DateTime.parse(
                                 data[0]["updatedAt"].toString())),
                             googleFonts: GoogleFonts.lato(
                                 fontSize: textSizeSMedium,
                                 fontWeight: FontWeight.w500),
                           ),
                         ],
                       ).paddingTop(spacing_twinty),
                       text(
                         data[0]["blogTitle"].toString(),
                         maxLine: 5,
                         isCentered: true,
                         googleFonts: GoogleFonts.lato(
                             fontSize: textSizeXLarge,
                             fontWeight: FontWeight.w700),
                       ).paddingTop(spacing_middle).center(),
                       HtmlToFlutter(
                               data: data[0]["blogDescription"].toString())
                           .paddingTop(spacing_control),
                          
                       // ClipRRect(
                       //   borderRadius: BorderRadius.circular(20),
                       //   child: Image.asset(
                       //     blogPicture,
                       //     height: 300,
                       //     width: double.infinity,
                       //     fit: BoxFit.cover,
                       //   ),
                       // ).paddingTop(spacing_twinty),
                       // text(
                       //   "Enhance Your Project with Ultra-Realistic AI Voices",
                       //   maxLine: 5,
                       //   isCentered: true,
                       //   googleFonts: GoogleFonts.lato(
                       //       fontSize: textSizeXLarge,
                       //       fontWeight: FontWeight.w700),
                       // ).paddingTop(spacing_middle),
                       // text(
                       //   LogIn_text,
                       //   maxLine: 5,
                       //   isCentered: true,
                       //   googleFonts: GoogleFonts.lato(
                       //       fontSize: textSizeLargeMedium,
                       //       fontWeight: FontWeight.w500),
                       // ).paddingTop(spacing_control),
                     ],
                   ).paddingSymmetric(
                       horizontal: spacing_twinty,
                       vertical: spacing_twinty));
              
              },);
            }
          },
        ));
  }
}
