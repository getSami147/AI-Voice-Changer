import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/viewModel/UserViewModel.dart';
import 'package:voice_changer/viewModel/authViewModel.dart';

class AccountLogOut extends StatefulWidget {
  var refreshtoken;

  AccountLogOut({required this.refreshtoken, Key? key}) : super(key: key);

  @override
  State<AccountLogOut> createState() => _AccountLogOutState();
}

class _AccountLogOutState extends State<AccountLogOut> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: color_white,
      insetPadding: const EdgeInsets.symmetric(horizontal: spacing_twinty),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    drawer_ic_logOut,
                    color: colorPrimary,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: spacing_twinty,
                  ),
                  text("Logout Account",
                      googleFonts: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: textSizeNormal,
                      )),
                  const SizedBox(
                    height: spacing_control,
                  ),
                  text("Do you want to logout the App?",
                      googleFonts: GoogleFonts.lato(
                          fontSize: textSizeMedium, color: textGreyColor)),
                  const SizedBox(
                    height: spacing_control,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: spacing_twinty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  elevatedButton(
                    context,
                    onPress: () {
                      Navigator.pop(context);
                    },
                    height: 45.0,
                    width: 150.0,
                    borderRadius: 5.0,
                    backgroundColor: color_white,
                    bodersideColor: blackColor,
                    widget: text("Cancel", fontSize: textSizeSMedium),
                  ),
                  const SizedBox(
                    width: spacing_standard_new,
                  ),
                  elevatedButton(
                    context,
                    onPress: () {
                      //  var provider= Provider.of<UserViewModel>(context,listen: false);
                      // print(widget.refreshtoken);
                      AuthViewModel().logOutApi({
                        "refreshToken":widget.refreshtoken.toString(),
                      }, {'Content-Type': 'application/json'}, context).then((value) => {UserViewModel().remove(),});
                    },
                    height: 45.0,
                    width: 150.0,
                    borderRadius: 5.0,
                    backgroundColor: Dissmisable_RedColor,
                    bodersideColor: Dissmisable_RedColor,
                    widget: text("LogOut",
                        textColor: color_white, fontSize: textSizeSMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
