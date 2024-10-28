import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/screens/singalBlogs.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';
import 'package:intl/intl.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

import '../../res/appUrl.dart';
import '../authView/logIn.dart';
import 'Community.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    return 
    Scaffold(
        appBar: CustomAppBar(
          title: appbar_AllBlogs,
        ),
        body: FutureBuilder(
          future: HomeViewModel().blogApi(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            } else if (snapshot.hasError) {
              return Center(child: text(snapshot.error.toString(),maxLine: 10));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                physics:  const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = snapshot.data["data"];
                  return GestureDetector(
                    onTap: () {
;                           SingalBlogs(blogId: data[index]["_id"].toString(),).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    child: Card(
                        elevation: 0,
                        color: whiteColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data[index]["blogThumbURL"].toString(),
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                              const SizedBox(
                                  width: spacing_standard_new,
                                ),
                                text(
                                  "${data[index]["uploadedBy"].toString()} | ",
                                  googleFonts: GoogleFonts.lato(
                                      fontSize: textSizeMedium,
                                      color: colorPrimary,
                                      fontWeight: FontWeight.w500),
                                ),
                                text(
                                  DateFormat("yMMMMEEEEd").format(DateTime.parse(
                                data[0]["updatedAt"].toString())
                                ),
                                  googleFonts: GoogleFonts.lato(
                                      fontSize: textSizeSMedium,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ).paddingTop(spacing_thirty),
                            text(
                              data[index]["blogTitle"].toString(),
                              googleFonts: GoogleFonts.lato(
                                  fontSize: textSizeLarge,
                                  fontWeight: FontWeight.w700),
                            ).paddingTop(spacing_twinty),
                            HtmlToFlutter(
                                    data: data[index]["blogDescription"]
                                        .toString())
                                .paddingTop(spacing_control),
                            const Divider().paddingTop(spacing_twinty),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                text(
                                  DateFormat("yMMMMEEEEd").format(
                                      DateTime.parse(data[index]
                                              ["updatedAt"]
                                          .toString())),
                                  maxLine: 5,
                                  googleFonts: GoogleFonts.lato(
                                      fontSize: textSizeSMedium,
                                      color: colorPrimary,
                                      fontWeight: FontWeight.w400),
                                ),
                                Comunity_Likes(
                                  svgIcons: svg_Share,
                                  texts: "1.3k",
                                ),
                              ],
                            ).paddingTop(spacing_middle),
                          ],
                        ).paddingSymmetric(
                            horizontal: spacing_twinty,
                            vertical: spacing_standard_new)),
                  );
                },
              ).paddingSymmetric(vertical: spacing_twinty).paddingSymmetric(horizontal: spacing_twinty);
            }
          },
        ));

    
    
  }
}
