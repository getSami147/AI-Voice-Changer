import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/view/screens/overview.dart';
import 'package:voice_changer/view/screens/overview.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/colors.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/components/component.dart';
import 'package:voice_changer/view/screens/contectUs.dart';
import 'package:voice_changer/view/screens/deleteAccount%20.dart';
import 'package:voice_changer/view/screens/fAQs.dart';
import 'package:voice_changer/view/screens/logOut.dart';
import 'package:voice_changer/view/screens/MySubcription.dart';
import 'package:voice_changer/view/screens/pricing.dart';
import 'package:voice_changer/view/screens/profileScreen.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

import '../../viewModel/authViewModel.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
var data;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: appbar_Account,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                    color: const Color(0xff000000).withOpacity(.1))
              ]),
          child: Column(
            children: [          
              FutureBuilder(
                future: AuthViewModel().getMeApi(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CustomLoadingIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: text(snapshot.error.toString()));
                  } else {
                    data = snapshot.data["data"]["me"];
                    var provider= Provider.of<UserViewModel>(context,listen: false);
                    provider.getuserProfile(data["name"], data["email"]);
                    return Column(
                      children: [
                       data["userImageURl"]==null? CircleAvatar(
                          radius: 55,
                          backgroundColor: colorPrimary,
                          child: ClipOval(
                              child: Image.asset(
                              profilePic,
                            height: size.width * .23,
                            width: size.width * .23,
                            fit: BoxFit.cover,
                          )),
                        ):CircleAvatar(
                          radius: 55,
                          backgroundColor: colorPrimary,
                          child: ClipOval(
                              child: Image.network(
                              data["userImageURl"].toString(),
                            height: size.width * .24,
                            width: size.width * .24,
                            fit: BoxFit.cover,
                          )),
                        ),
                        text(data["name"].toString(),
                                fontSize: textSizeLargeMedium,
                                fontWeight: FontWeight.w600)
                            .paddingTop(spacing_middle),
                        text(data["email"].toString(),
                            fontSize: 11.0, textColor: textGreyColor),
                      ],
                    );
                  }
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    DraweTile(
                  imagename: nav_ic_profile,
                  textName: "Profile",
                  onTap: () {
                        UserViewModel().setUserData(data["name"].toString(), data["email"].toString());
                    const ProfileScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
                  DraweTile(
                  imagename: drawer_ic_overview,
                  textName: "Overview",
                  onTap: () {
                         const OverviewScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
                 DraweTile(
                  imagename: drawer_ic_pricing,
                  textName: "Pricing",
                  onTap: () {
                    const PricingScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
                 DraweTile(
                  imagename: drawer_ic__payment,
                  textName: "My Subscription",
                  onTap: () {
                    const MySubcription().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
              
                DraweTile(
                  imagename: drawer_ic_contectUs,
                  textName: "Contect Us",
                  onTap: () {
                    const ContactUs().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                ),
                DraweTile(
                    imagename: drawer_ic_helpFAQs, textName: "Help & FAQs",
                    onTap: () {
                      const FAQsScreen().launch(context,pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    ),
                DraweTile(
                  imagename: drawer_ic_logOut,
                  textName: "Log Out",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        var provider = Provider.of<UserViewModel>(context,listen: false);
                        // Delete Page (Dialog Box) is Called.............>>>
                        return AccountLogOut(
                          refreshtoken: provider.refreshtoken,
                        );
                      },
                    );
                  },
                ),
                  DraweTile(
                  imagename: drawer_ic_deleteAccount,
                
                  textName: "Delete Account",
                  onTap: () {
                    showDialog(context: context,builder: (context) {
                                      // Delete Page (Dialog Box) is Called.............>>>
                                      return const DeleteAccount();
                                    },
                                  );
                  },
                )
                  ],
                ),
              ))
            ],
          ).paddingSymmetric(
              horizontal: spacing_large, vertical: spacing_twinty),
        ).paddingTop(spacing_twinty)
            .paddingSymmetric(horizontal: spacing_twinty));
  }
}
