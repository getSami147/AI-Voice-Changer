import 'dart:async';

import 'package:audio_wave_url_package/voice_message_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/res/appUrl.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/string.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/screens/community.dart';
import 'package:voice_maker/view/screens/updateComment.dart';
import 'package:voice_maker/models/apiModels.dart';

import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';

// ignore: camel_case_types, must_be_immutable
class CommunityComment extends StatefulWidget {
  var communityData;
   CommunityComment({required this.communityData, super.key});

  @override
  State<CommunityComment> createState() => _CommunityCommentState();
}

class _CommunityCommentState extends State<CommunityComment> {
  final fousenode=FocusNode();
  
    final messageController = TextEditingController();
    @override
  void initState() {
 
    // TODO: implement initState
    super.initState();
     var api= Provider.of<HomeViewModel>(context,listen:false);
  api.getCommentAll(context);
  }

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appbar_CommunityComment,
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 0,
                              color: whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: Image.network(
                                    widget.communityData["referenceToUser"]["userImageURl"].toString()
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: spacing_standard_new,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(
                                    widget.communityData["referenceToUser"]["name"].toString(),                                
                                    googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                                  text(
                                    "${widget.communityData["communityDescription"]}",
                                    maxLine: 5,
                                    googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeSMedium,
                                        fontWeight: FontWeight.w400),
                                  ).paddingTop(spacing_control),
                 
                                  const Divider().paddingTop(spacing_twinty),
                                  
                                  text(
                                    "Comments",
                                    maxLine: 5,
                                    googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Divider(),
                                  Consumer<HomeViewModel>(builder: (context, value, child) {
                                       if (value.isloading==true) {
                                         return const CustomLoadingIndicator();
                                       } else {
                                          return ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                value.api.data!.length,
                                            
                                            itemBuilder: (context, index) {
                                           
                                              var data =value.api.data![index];
                                                  
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        data.commentUid!.userImageURl,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),

                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffF7F8F9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              text(
                                                                  DateFormat(
                                                                          "yMMMMEEEEd")
                                                                      .format(DateTime.parse(
                                                                          data.updatedAt
                                                                              .toString())),
                                                                  fontSize:
                                                                      textSizeSmall),
                                                              PopupMenuButton<
                                                                  String>(
                                                                splashRadius: 2,
                                                                onOpened: () {
                                                                   
                                                               
                                                                },
                                                                onSelected:
                                                                    (value) {
                                                                      
                                                                },
                                                                itemBuilder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return <PopupMenuEntry<
                                                                      String>>[
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () {
                                                                         
                                                                 showDialog(context: context,builder: (context) {
                                        // Delete Page (Dialog Box) is Called.............>>>
                                        return  UpdateComment(id:data.commentUid!.id, communityId: data.communityId,);
                                      },
                                    );
                                                                          },
                                                                      value:
                                                                          'Edit',
                                                                      child: text(
                                                                          'Edit'),
                                                                    ),
                                                                    PopupMenuItem<
                                                                        String>(
                                                                      onTap:
                                                                          () {
                                                                
                                    
                                             HomeViewModel().deleteCommentApi(data.id.toString(), context);
                                                                          },
                                                                      value:
                                                                          'Delete',
                                                                      child: text(
                                                                          'Delete'),
                                                                    ),
                                                                  ];
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          text(
                                                              data.commentMessage
                                                                  .toString(),
                                                              maxLine: 10,
                                                              fontSize:
                                                                  textSizeSMedium),
                                                        ],
                                                      ).paddingAll(
                                                          spacing_standard),
                                                    ),
                                                  ),
                                               
                                                ],
                                              ).paddingTop(spacing_twinty);
                                         
                                            },
                                          );
                                        
                                       }
                                         
                                      },
                                    ),
                                  
                                                                   
                                ],
                              ).paddingSymmetric(
                                  horizontal: spacing_twinty,
                                  vertical: spacing_standard_new),
                            ).paddingTop(spacing_thirty),
                          ],
                        ).paddingSymmetric(horizontal: spacing_twinty)
                     
                    ),
          ),
                     
          Container(
            height: 95,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 50,
                    spreadRadius: 0,
                    color: const Color(0xFF000000).withOpacity(.15))
              ],
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: 
                  TextFormField(
                    
                    maxLines: 1,minLines: 1,
                    maxLength: 300,
                    focusNode:fousenode ,
                    controller: messageController,
                    decoration: const InputDecoration(
                      contentPadding:EdgeInsets.all(10) ,
                      hintText: "Start typing...",
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffAFAFAF)),
                      ),
                    ),
                  )),
                const SizedBox(
                  width: spacing_control,
                ),
                GestureDetector(
                  onTap: ()async {
                    var provider =
                        Provider.of<UserViewModel>(context, listen: false);

                    var body = {
                      "commentUid": provider.userId,
                      "communityId": provider.communityId,
                      "commentMessage":
                          messageController.text.trim().toString(),
                      "isActive": true
                    };
                    var headers = {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer ${provider.logintoken}'
                    };
                    // print(body);
                    fousenode.unfocus();
                    messageController.clear();
                   await HomeViewModel().postComment(body, headers, context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      // borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textGreyColor,
                      ),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ).paddingAll(7),
                  ).paddingBottom(spacing_twinty),
                )
              ],
            ).paddingSymmetric(horizontal: spacing_standard_new,),
          )
        ],
      ),
    );
  }
}
