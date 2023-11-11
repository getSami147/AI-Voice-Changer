import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/utils/constant.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Frequently FAQ's ",
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: FutureBuilder(
          future: HomeViewModel().getFAQs(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: text(snapshot.error.toString(),
                      maxLine: 5, isCentered: true));
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  var data = snapshot.data["data"][index];
                  return ExpansionTile(  
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    initiallyExpanded: false,
                    iconColor: colorPrimary,
                    tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: text(data["question"],
                        fontSize: textSizeMedium,
                        textColor: colorPrimary,
                        fontWeight: FontWeight.w400),
                        childrenPadding: const EdgeInsets.symmetric(horizontal: spacing_middle,vertical: 0),
                      
                    children: [
                      text(data["answer"],
                          fontSize: textSizeSmall,
                          maxLine: 34,
                          overflow: TextOverflow.ellipsis),
                          const SizedBox(height: spacing_middle,)
                    ],
                  );
                },
              ).paddingTop(spacing_twinty);
            }
          }).paddingSymmetric(horizontal: spacing_twinty),
    );
  }
}
