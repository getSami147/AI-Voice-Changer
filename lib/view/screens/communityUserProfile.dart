import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/utils/constant.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/screens/community.dart';
import 'package:voice_maker/view/screens/communityComment.dart';
import 'package:voice_maker/view/screens/shareVoice.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';

class CommunityUserProfile extends StatelessWidget {
  final String userId;
  const CommunityUserProfile({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        backbutton: true,
        backPressed: (){Navigator.pop(context);},
      ),
      
      body: SafeArea(
        child: FutureBuilder(
          future: HomeViewModel().getCommunityUserProfile(context, userId),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: text(snapshot.error.toString(),
                  maxLine: 5, isCentered: true));
        } else {
            var user=snapshot.data["user"];
           return  Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              
               CircleAvatar(
                 radius: 60,
                 child: ClipOval(
               child: Image.network(
                   user["image"].toString(),
                   fit: BoxFit.cover,
                   ),
                 ),
               ).center().paddingTop(spacing_thirty),
               const SizedBox(
                 width: spacing_standard_new,
               ),
               text(
                user["name"].toString(),
        
                 googleFonts: GoogleFonts.lato(
                     fontSize: textSizeLargeMedium,
                     fontWeight: FontWeight.w600),
               ).center(),
               text(
               user["email"].toString(),
        
                 googleFonts: GoogleFonts.lato(
                     fontSize: textSizeSMedium,
                     fontWeight: FontWeight.w500),
               ).center(),
                text("User Post List",googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600),
                                  ).paddingTop(spacing_twinty),
               
               Expanded(
                 child: ListView.builder(
                             itemCount: snapshot.data["data"].length,
                             shrinkWrap: true,
                             physics: const BouncingScrollPhysics(),
                             
                  itemBuilder: (context, index) {
                           var data=snapshot.data["data"][index];
                       
                   return  Card(
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
                                    
                                    user["image"].toString(),
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
                                    user["name"].toString(),
                                
                                    googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // text(
                                  // user["userName"].toString(),
                                  
                                  //   googleFonts: GoogleFonts.lato(
                                  //       fontSize: textSizeSMedium,
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          
                          text(
                            data["communityDescription"].toString(),
                            maxLine: 5,
                            googleFonts: GoogleFonts.lato(
                                fontSize: textSizeSMedium,
                                fontWeight: FontWeight.w400),
                          ).paddingTop(spacing_control),
                   
                          const Divider().paddingTop(spacing_twinty),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<UserViewModel>(
                                builder: (context, value, child) =>
                                    AnimatedContainer(
                                  alignment: Alignment.center,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: Comunity_Likes(
                                    svgIcons: svg_Like,
                                    color: data["isLiked"]
                                        ? colorPrimary
                                        : Colors.grey,
                                    texts: data["likes"].toString(),
                                    onPressed: () {
                                      // setState(() {
                                        
                                      // });
                                      // HomeViewModel().likeIncreaseApi(context, data["_id"].toString());
                                      // provider2.toggleLike();
                                      // print(data["isLiked"]);
                       
                       
                                     
                                    },
                                  ),
                                ),
                              ),
                              Comunity_Likes(
                                svgIcons: svg_Comment,
                                texts: "",
                                onPressed: () {
                                   CommunityComment(communityData: data["_id"].toString(),).launch(context,
                                      pageRouteAnimation:
                                          PageRouteAnimation.Fade);
                                },
                              ),
                              Consumer<UserViewModel>(
                                builder: (context, value2, child) =>
                                    Comunity_Likes(
                                  svgIcons: svg_Download,
                                  texts: "${data["downloads"]}",
                                  onPressed: () {
                                  //  download(data["audioURL"]).then((value) => HomeViewModel().downloadIncreaseApi(context, data["_id"].toString()));
                                    
                                  },
                                ),
                              ),
                              Consumer<UserViewModel>(
                                builder: (context, value3, child) =>
                                    Comunity_Likes(
                                  svgIcons: svg_Share,
                                  texts: "${data["shares"]}",
                                  onPressed: () {
                                    showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(35),
                                                    topRight:
                                                        Radius.circular(35))),
                                            context: context,
                                            builder: (context) {
                                              // SharePage page Called (Model BottomSheet)............>>
                                              return  ShareVoice(voiceUrl: data["audioURL"].toString(), shareId: data["_id"],);
                                            },
                                          );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(
                          horizontal: spacing_twinty,
                          vertical: spacing_standard_new),
                    );
                 },).paddingTop(spacing_middle),
               )
             ],
           ).paddingSymmetric(horizontal: spacing_twinty);
          }
        }),
      ),
    
    );
  }
}
