import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/utils/string.dart';
import 'package:voice_maker/view/sateManagement.dart';
import 'package:voice_maker/view/screens/Community.dart';
import 'package:voice_maker/view/screens/blogs.dart';
import 'package:voice_maker/view/screens/generateScreen.dart';
import 'package:voice_maker/view/screens/Account.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';

import '../../utils/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    provider.getUserTokens();
    super.initState();
  }

  int selectedIndex = 0;
  var pages = [
    const GenerateScreen(),
    const CommunityScreen(),
    const BlogsScreen(),
    const Account()
  ];
  List<String> navBarIcons = [
    nav_ic_Generate,
    nav_ic_Community,
    nav_ic_Blog,
    nav_ic_profile,
  ];

  List<Widget> navText = [
    text(NavBar_Generate, fontSize: textSizeSmall),
    text(NavBar_Community, fontSize: textSizeSmall),
    text(NavBar_Blogs, fontSize: textSizeSmall),
    text(NavBar_Profile, fontSize: textSizeSmall),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: color_white,
            boxShadow: [
              BoxShadow(
                  color: textColorPrimary.withOpacity(.15),
                  blurRadius: 45,
                  offset: const Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: radiusCircular(15))),
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: navBarIcons.map((e) {
              int i = navBarIcons.indexOf(e);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      e,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      color: i == selectedIndex ? colorPrimary : null,
                    ),
                    onPressed: () {
                      selectedIndex = i;
                      setState(() {});
                    },
                  ),
                  navText[i]
                ],
              );
            }).toList()),
      ),
      body: WillPopScope(
        
        onWillPop: () async {
          return true;
        },
        child: PageView(
          children: [pages[selectedIndex]],
        ),
      ),
    );
  }
}
