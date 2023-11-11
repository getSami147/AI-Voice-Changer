import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/repository/homeRepository.dart';
import 'package:voice_maker/utils/Colors.dart';
import 'package:voice_maker/utils/Constant.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';

class MySubcription extends StatefulWidget {
  const MySubcription({super.key});

  @override
  State<MySubcription> createState() => _MySubcriptionState();
}

class _MySubcriptionState extends State<MySubcription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "My Subscription",
          backbutton: true,
          backPressed: () {
            finish(context);
          },
        ),
        body: FutureBuilder(
            future: HomeViewModel().getmysubscription(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CustomLoadingIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: text(snapshot.error.toString(), maxLine: 10));
              } else {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                physics:  const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = snapshot.data["data"][index];
                  return PaymentCard(
                    onpress: () {},
                    title:
                        data["subscriptionType"]["subscriptionType"].toString(),
                    subtitle: DateFormat("yMMMMEEEEd").format(DateTime.parse(
                        data["subscriptionType"]["createdAt"].toString())),
                    trailing:
                        "\$${data["subscriptionType"]["price"].toString()}",
                  );
                },
              ).paddingSymmetric(horizontal: spacing_twinty);
            }
  })
            );
  }
}

class PaymentCard extends StatelessWidget {
  VoidCallback? onpress;
  VoidCallback? onpress2;
  String? title;
  String? subtitle;
  String? trailing;
  PaymentCard(
      {Key? key,
      this.onpress2,
      this.trailing,
      this.title,
      this.subtitle,
      this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: textColorPrimary.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 4),
              spreadRadius: 0)
        ]),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(title,
                        fontSize: textSizeSmall,
                        textAllCaps: true,
                        fontWeight: FontWeight.w500),
                    text(subtitle,
                        fontSize: textSizeSmall, textColor: textGreyColor),
                  ]),
              Row(
                children: [
                  text(trailing,
                      fontSize: textSizeSmall, fontWeight: FontWeight.w500),
                ],
              )
            ],
          ).paddingSymmetric(
              horizontal: spacing_standard_new, vertical: spacing_standard_new),
        ).paddingTop(10),
      ),
    );
  }
}
