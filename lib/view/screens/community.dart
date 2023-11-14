import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/assetAudioPlayer.dart';
import 'package:voice_maker/res/appUrl.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/audioPlayerdemo.dart';
import 'package:voice_maker/utils/string.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/screens/communityComment.dart';
import 'package:voice_maker/view/screens/communityPost.dart';
import 'package:voice_maker/view/screens/communityUserProfile.dart';
import 'package:voice_maker/view/screens/shareVoice.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel2.dart';

import 'Community.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudioFromUrl(String playAudiourl) async {
    await audioPlayer.play(UrlSource(playAudiourl));
  }

  // var isplayed = false;

  // playStop() {
  //   isplayed = !isplayed;
  // }
  Future<void> download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var savingPath = Directory("/storage/emulated/0/Download/AIVoice");
      savingPath.createSync(recursive: true);
      try {
        await FlutterDownloader.enqueue(
          url: url,
          headers: {}, // optional: header send with url (auth token etc)
          savedDir: savingPath.path,
          showNotification:
              true, // show download progress in status bar (for Android)
          saveInPublicStorage: true,
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
      } catch (e) {
        print("Download failed: $e");
      }
    } else {
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel2>(context, listen: false);
    var provider2 = Provider.of<UserViewModel>(context, listen: false);
    //  final homeViewprovider = Provider.of<HomeViewModel>(context,listen: false);

    // return  Scaffold(
    //   appBar: CustomAppBar(
    //     title: appbar_Community,
    //   ),
    //   body:
    //   FutureBuilder(
    //       future: HomeViewModel().fetchCommunityData(context),
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(child: CustomLoadingIndicator());
    //         } else if (snapshot.hasError) {
    //           return Center(
    //               child: text(snapshot.error.toString(),
    //                   maxLine: 5, isCentered: true));
    //         } else {
    //           return
    //            Consumer<HomeViewModel>(
    //              builder: (BuildContext context, api, Widget? child) {
    //              return ListView.builder(
    //               physics:
    //                   const BouncingScrollPhysics(parent: PageScrollPhysics()),
    //               itemCount: api.items.length+1,
    //               shrinkWrap: true,
    //               itemBuilder: (context, index) {
    //                  if (index == api.items.length) {
    //                        api.fetchCommunityData(context);
    //                        return Center(child: _buildProgressIndicator());
    //                  }else{
    //                 // var data = snapshot.data["data"][index];
    //               var data=  api.items[index];
    //                 return Card(
    //                   elevation: 0,
    //                   color: whiteColor,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [

    //                       GestureDetector(
    //                         onTap: () {
    //                           CommunityUserProfile(userId:data["referenceToUser"]["_id"].toString(),).launch(context);
    //                         },
    //                         child: Row(
    //                           children: [
    //                             CircleAvatar(
    //                               radius: 30,
    //                               child: ClipOval(
    //                                 child: Image.network(
    //                                   data["referenceToUser"]["userImageURl"].toString()
    //                                 ),
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               width: spacing_standard_new,
    //                             ),
    //                             Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 text(
    //                                   data["referenceToUser"]["name"].toString(),
    //                                   googleFonts: GoogleFonts.lato(
    //                                       fontSize: textSizeLargeMedium,
    //                                       fontWeight: FontWeight.w600),
    //                                 ),

    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),

    //                       text(
    //                         data["communityDescription"].toString(),
    //                         maxLine: 5,
    //                         googleFonts: GoogleFonts.lato(
    //                             fontSize: textSizeSMedium,
    //                             fontWeight: FontWeight.w400),
    //                       ).paddingTop(spacing_control),
    //                 VoiceMessage(
    //                 // audioSrc:"https://download.samplelib.com/mp3/sample-3s.mp3",
    //                 played: false, // To show played badge or not.
    //                 me: true, // Set message side.
    //                 noiseWidth: double.infinity,
    //                 width: double.infinity,
    //                 meBgColor: black.withOpacity(.05),
    //                 meFgColor: colorPrimary,
    //                 mePlayIconColor: whiteColor,
    //                 waveColor: colorPrimary,
    //                 waveBgColor: redColor,
    //                 duration:const Duration(minutes: 1),
    //                 showDuration: true,
    //                 noiseCount:30 ,
    //                 noiseHeight:20 ,
    //                 waveForm: [20,20,20],
    //                 contactPlayIconBgColor: colorPrimary,
    //                 contactPlayIconColor: redColor,
    //                 onPlay: () {
    //                   // print('aaaaaaa  :${isplayed}');
    //                   playAudioFromUrl(data["audioURL"].toString());
    //                 }, header: {}, // Do something when voice played.
    //               ).paddingTop(spacing_twinty),
    //                       const Divider().paddingTop(spacing_twinty),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Consumer<UserViewModel>(
    //                             builder: (context, value, child) =>
    //                                 AnimatedContainer(
    //                               alignment: Alignment.center,
    //                               duration: const Duration(milliseconds: 300),
    //                               curve: Curves.easeInOut,
    //                               child: Comunity_Likes(
    //                                 svgIcons: svg_Like,
    //                                 color: data["isLiked"]
    //                                     ? colorPrimary
    //                                     : Colors.grey,
    //                                 texts: data["likes"].toString(),
    //                                 onPressed: () {
    //                                   setState(() {

    //                                   });
    //                                   HomeViewModel().likeIncreaseApi(context, data["_id"].toString());
    //                                   // provider2.toggleLike();
    //                                   api.fetchCommunityData(context);
    //                                   print(data["isLiked"]);

    //                                 },
    //                               ),
    //                             ),
    //                           ),
    //                           Comunity_Likes(
    //                             svgIcons: svg_Comment,
    //                             texts: "",
    //                             onPressed: () {
    //                               provider2.getCommunityId(data["_id"].toString());
    //                                CommunityComment(communityData: data,).launch(context,
    //                                   pageRouteAnimation:
    //                                       PageRouteAnimation.Fade);
    //                             },
    //                           ),
    //                           Consumer<UserViewModel>(
    //                             builder: (context, value2, child) =>
    //                                 Comunity_Likes(
    //                               svgIcons: svg_Download,
    //                               texts: "${data["downloads"]}",
    //                               onPressed: () {
    //                                download(data["audioURL"]).then((value) => HomeViewModel().downloadIncreaseApi(context, data["_id"].toString()));

    //                               },
    //                             ),
    //                           ),
    //                           Consumer<UserViewModel>(
    //                             builder: (context, value3, child) =>
    //                                 Comunity_Likes(
    //                               svgIcons: svg_Share,
    //                               texts: "${data["shares"]}",
    //                               onPressed: () {
    //                                 showModalBottomSheet(
    //                                         shape: const RoundedRectangleBorder(
    //                                             borderRadius: BorderRadius.only(
    //                                                 topLeft: Radius.circular(35),
    //                                                 topRight:
    //                                                     Radius.circular(35))),
    //                                         context: context,
    //                                         builder: (context) {
    //                                           // SharePage page Called (Model BottomSheet)............>>
    //                                           return  ShareVoice(voiceUrl: data["audioURL"].toString(), shareId: data["_id"],);
    //                                         },
    //                                       );
    //                               },
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ).paddingSymmetric(
    //                       horizontal: spacing_twinty,
    //                       vertical: spacing_standard_new),
    //                 );
    //               }
    //                        })
    //                 .paddingTop(spacing_thirty)
    //                 .paddingSymmetric(horizontal: spacing_twinty);
    //            },);
    //         }
    //      }),
    //   floatingActionButton: Consumer<UserViewModel2>(builder: (context, value, child) {
    //     return FloatingActionButton.extended(
    //     elevation: 0,
    //     splashColor: const Color(0xff9B22C5),
    //     backgroundColor: colorPrimary,
    //     onPressed:() {
    //        value.toggleExpansion();
    //     },
    //     icon: SvgPicture.asset(
    //       svg_uplaod,
    //       height: 18,
    //       width: 18,
    //       fit: BoxFit.cover,
    //       color: Colors.white,
    //     ),
    //     label: provider.isExpanded
    //         // provider.isExpanded
    //         ? GestureDetector(
    //             onTap: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (context) {
    //                   // communityPost (Dialog Box) is Called.............>>>
    //                   return  communityPost(userId: provider2.userId,);
    //                 },
    //               );
    //             },
    //             child: text("Upload Voice Post",
    //                 googleFonts: GoogleFonts.lato(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: textSizeLargeMedium,
    //                     color: color_white)),
    //           )
    //         : const SizedBox.shrink(),
    //   );
    //   },)
    // );
    return Scaffold(
        appBar: CustomAppBar(
        title: appbar_Community,
      ),
      body: StreamBuilder<http.Response>(
        stream: HomeViewModel().StreemGetCommunity(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: text(snapshot.error.toString(), maxLine: 10));
          } else {
            
            var response = jsonDecode(snapshot.data!.body);
            return ListView.builder(
                physics:
                    const BouncingScrollPhysics(parent: PageScrollPhysics()),
                itemCount: response["data"].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  
                  //  if (index == api.items.length) {
                  //        api.fetchCommunityData(context);
                  //        return Center(child: _buildProgressIndicator());
                  //  }else{
                  // var data = snapshot.data["data"][index];
                  var data = response["data"][index];
                 
                  return Card(
                    elevation: 0,
                    color: whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            CommunityUserProfile(
                              userId:
                                  data["referenceToUser"]["_id"].toString(),
                            ).launch(context);
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: Image.network(data["referenceToUser"]
                                          ["userImageURl"]
                                      .toString()),
                                ),
                              ),
                              const SizedBox(
                                width: spacing_standard_new,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(
                                    data["referenceToUser"]["name"]
                                        .toString(),
                                    googleFonts: GoogleFonts.lato(
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        text(
                          data["communityDescription"].toString(),
                          maxLine: 5,
                          googleFonts: GoogleFonts.lato(
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w400),
                        ).paddingTop(spacing_control),
                        AssetAudioPlayer(
              audioUrl:data["audioURL"].toString(),
                  // 'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
              imageUrl: "",
              name: 'Sami Ullah',
              appName: 'AI Voice Changer',
            ),

                     data["audioURL"] != null
                            ?     Consumer<UserViewModel2>(
                          builder: (context, audioConsumer, child) {
                            return BubbleNormalAudio(
                            
                              color: Color(0xFFE8E8EE),
                              duration:
                                  audioConsumer.duration.inSeconds.toDouble(),
                              position:
                                  audioConsumer.position.inSeconds.toDouble(),
                              isPlaying: audioConsumer.isPlaying,
                              isLoading: audioConsumer.isLoading,
                              isPause: audioConsumer.isPause,
                              onSeekChanged:(value) {
                                audioConsumer.changeSeek(value);
                              },

                              onPlayPauseButtonClick: () {
                                audioConsumer
                                    .playAudio(data["audioURL"].toString());
                              },
                            );
                          },
                        ):const SizedBox.shrink(),



                        const Divider().paddingTop(spacing_twinty),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<UserViewModel>(
                              builder: (context, like, child) =>
                                  AnimatedContainer(
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Comunity_Likes(
                                  svgIcons: svg_Like,
                                  color: data["isLiked"] == false
                                      ? Colors.grey
                                      : colorPrimary,
                                  texts: data["likes"].toString(),
                                  onPressed: () {
                                    // setState(() {

                                    // });
                                  
                                    HomeViewModel().likeIncreaseApi(context, data["_id"].toString());
                                    // likev.toggleLike();
                                    print("Comminty Like:  "+data["isLiked"].toString());
                                  },
                                ),
                              ),
                            ),
                            Comunity_Likes(
                              svgIcons: svg_Comment,
                              texts: "",
                              onPressed: () {
                                provider2
                                    .getCommunityId(data["_id"].toString());
                                CommunityComment(
                                  communityData: data,
                                ).launch(context,
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
                                  download(data["audioURL"]).then((value) =>
                                      HomeViewModel().downloadIncreaseApi(
                                          context, data["_id"].toString()));
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
                                            topRight: Radius.circular(35))),
                                    context: context,
                                    builder: (context) {
                                      // SharePage page Called (Model BottomSheet)............>>
                                      return ShareVoice(
                                        voiceUrl: data["audioURL"].toString(),
                                        shareId: data["_id"],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(
                        horizontal: spacing_standard_new,
                        vertical: spacing_standard_new),
                  );
                  // }
                });
          }
        },
      ).paddingSymmetric(horizontal:spacing_twinty),
    );
  }
}

// Widget buildProgressIndicator() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Consumer<HomeViewModel>(
//       builder: (context, value, _) => Center(
//         child: Opacity(
//           opacity: value.isloading ? 1.0 : 0.0,
//           child: const CircularProgressIndicator(),
//         ),
//       ),
//     ),
//   );
// }
Widget _buildProgressIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<HomeViewModel>(
      builder: (context, paginationProvider, _) => Center(
        child: Opacity(
          opacity: paginationProvider.loadingcommunity ? 1.0 : 0.0,
          child: const Center(child: CustomLoadingIndicator()),
        ),
      ),
    ),
  );
}

// ignore: camel_case_types, must_be_immutable
class Comunity_Likes extends StatelessWidget {
  String? texts;
  String? svgIcons;
  Color? color;
  VoidCallback? onPressed;
  Comunity_Likes({
    this.svgIcons,
    this.color,
    this.onPressed,
    this.texts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(
            svgIcons!,
            color: color,
          ),
          const SizedBox(
            width: 10,
          ),
          text(
            texts,
            maxLine: 5,
            googleFonts: GoogleFonts.lato(
                color: textGreyColor,
                fontSize: textSizeSmall,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
