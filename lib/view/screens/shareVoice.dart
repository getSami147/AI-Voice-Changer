import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voice_changer/main.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';


class ShareVoice extends StatelessWidget {
  var voiceUrl;
  String shareId;
   ShareVoice({Key? key,required this.voiceUrl,required this.shareId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("aaa  :"+shareId);
Future<void> share(SocialMedia socialPlatform) async {
  HomeViewModel().shareIncreaseApi(context, shareId.getNumericOnly());

  final shareUrl = Uri.encodeComponent(voiceUrl);
  final sharetext = Uri.encodeComponent("Experience the magic of AI voice modulation with our Voice Changer app. Instantly change your voice into various exciting and entertaining effects. From robot voices to monster growls, we've got it all!");
  
  final Map<SocialMedia, String> urls = {
    
    SocialMedia.whatsapp: "https://wa.me/?text=$sharetext&$shareUrl",
    SocialMedia.whatsappBusiness: "https://wa.me/?text=$sharetext&$shareUrl",
    SocialMedia.facebook: "https://www.facebook.com/sharer/sharer.php?u=$shareUrl&quote=$sharetext",
    SocialMedia.messanger: "https://www.messenger.com/share.php?u=$shareUrl&quote=$sharetext",
    SocialMedia.linkedin: "https://www.linkedin.com/sharing/share-offsite/?url=$shareUrl&title=$sharetext",
    SocialMedia.instagram: "https://www.instagram.com/share?url=$shareUrl&title=$sharetext",
    SocialMedia.twitter: "https://twitter.com/intent/tweet?url=$shareUrl&text=$sharetext",
    SocialMedia.message: "sms:?body=$sharetext $shareUrl",
  };

  final url = urls[socialPlatform];

  if (url != null) {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
   
    var mediaQuary = MediaQuery.of(context).size;
    return SizedBox(
      height:380,
      width: mediaQuary.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            ).paddingTop(spacing_standard),
          ),
           text("Share", fontSize: textSizeLarge, fontWeight: FontWeight.w500)
                    .paddingOnly(
                        left: spacing_large, right: spacing_large, top: spacing_twinty),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                
               
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(onClick: ()=>share(SocialMedia.whatsapp),icon:share_whatsapp,iconName: "WhatsApp", ),
                    SocialButton(onClick: ()=>share(SocialMedia.whatsappBusiness),icon:share_whatsappBusiness,iconName: "WA Business", ),
                    SocialButton(onClick: ()=>share(SocialMedia.facebook),icon:share_facebook,iconName: "Facebook", ),
                    SocialButton(onClick: ()=>share(SocialMedia.messanger),icon:share_messanger,iconName: "Messanger", ),
                      
                  ],
                ).paddingTop(spacing_twinty),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(onClick: ()=>share(SocialMedia.twitter),icon:share_twitter,iconName: "Twitter", ),
                    SocialButton(onClick: ()=>share(SocialMedia.instagram),icon:share_instagram,iconName: "Instagram", ),
                    SocialButton(onClick: ()=>share(SocialMedia.linkedin),icon:share_linkedin,iconName: "Linkedin", ),
                    SocialButton(onClick: ()=>share(SocialMedia.message),icon:share_message,iconName: "Message", ),
                      
                  ],
                ).paddingTop(spacing_twinty),
                Center(
                  child: elevatedButton(
                    context,
                    onPress: () {
                      Navigator.pop(context);
                    },
                    height: 55.0,
                    width: 270.0,
                    backgroundColor:unselectedcontainer,
                    bodersideColor: unselectedcontainer,
                    borderRadius: 15.0,
                    widget: text(
                      'Cancel',
                      textColor: colorPrimary,
                      googleFonts: GoogleFonts.lato(
                                      fontSize: textSizeSMedium,
                                      fontWeight: FontWeight.w600)
                    ),
                  ),
                ).paddingTop(spacing_xlarge)
              ]),
            ),
          ),
        
        ],
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  var icon;
  var iconName;
  VoidCallback onClick;
   SocialButton({
    super.key,required this.onClick, this.icon,required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal:0),
      onPressed: onClick,
      icon: Column(mainAxisAlignment: MainAxisAlignment.start,
        children:[ 
          Image.asset(
          icon!,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        text(
      iconName,
       googleFonts: GoogleFonts.lato(fontSize: textSizeSMedium)

    ),
       ] ),
    );
  }
}
