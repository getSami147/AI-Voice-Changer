import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/widget.dart';

// ignore: must_be_immutable
class AppbarContainer extends StatelessWidget {
  var dynamicText;
  bool? backbutton;
  String? fristIcon;
  VoidCallback? fristOnTap;
  VoidCallback? lastOnTap;
  String? lastIcon;
  VoidCallback? onPressed;
  AppbarContainer(
      {required this.dynamicText,
      this.fristOnTap,
      this.lastOnTap,
      this.fristIcon,
      this.lastIcon,
      super.key,
      this.backbutton = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(spacing_control),
          width: double.infinity,
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
          child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              titleAlignment: ListTileTitleAlignment.center,
              leading: backbutton == true
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: blackColor,
                      ).paddingLeft(10),
                    )
                  : null,
              title: Padding(
                padding: backbutton == true
                    ? const EdgeInsets.only(right: 45)
                    : const EdgeInsets.only(right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: fristOnTap,
                        child: SvgPicture.asset(fristIcon.toString())),
                    text(dynamicText.toString(),
                            isCentered: true,
                            googleFonts: GoogleFonts.lato(
                                fontSize: 22.0, fontWeight: FontWeight.w600))
                        .paddingLeft(spacing_middle),
                    GestureDetector(
                      onTap: lastOnTap,
                      child: SvgPicture.asset(lastIcon.toString())
                          .paddingLeft(spacing_middle),
                    ),
                  ],
                ),
              ))),
    );
  }
}

//

// ignore: must_be_immutable
class DraweTile extends StatelessWidget {
  // IconData? iconA;
  String? imagename;
  String? textName;
  VoidCallback? onTap;

  DraweTile(
      {Key? key,
      required this.imagename,
      required this.textName,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                imagename.toString(),
                height: 25,
                width: 25,
                color: textcolorSecondary,
                fit: BoxFit.contain,
              ),
              text(textName, fontFamily: 'Poppins')
                  .paddingLeft(spacing_standard_new),
            ],
          ).paddingTop(spacing_large),
          // const Divider().paddingTop(spacing_middle)
        ],
      ).paddingTop(spacing_standard),
    );
  }
}
