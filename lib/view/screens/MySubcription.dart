import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
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

class _MySubcriptionState extends State<MySubcription>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  var index = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

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
        body:
         FutureBuilder(
            future: HomeViewModel().getmysubscription(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CustomLoadingIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: text(snapshot.error.toString(), maxLine: 10));
              } else {
                final activeSubscrition = snapshot.data['data']
                    .where((e) => e['status'] == 'Active')
                    .toList();
                final cencledSubscrition = snapshot.data['data']
                    .where((e) => e['status'] == 'unAcive')
                    .toList();
                return Column(
                  children: [
                    TabBar(
                      onTap: (value) {
                        index = value;
                      },
                      unselectedLabelColor: colorPrimary,
                      labelColor: white,
                      controller: controller,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [colorPrimary, colorPrimaryS]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      tabs: [
                        const Tab(text: "Current Plan")
                            .paddingSymmetric(horizontal: spacing_twinty),
                        const Tab(text: "Cancelled Plan")
                            .paddingSymmetric(horizontal: spacing_twinty),
                      ],
                    ).paddingSymmetric(vertical: spacing_thirty, horizontal: 0),
                    Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: controller,
                        children: [
                          activeSubscrition.isEmpty
                              ? Center(
                                  child: text("You don't have any Subscription",
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                )
                              : ListView.builder(
                                  itemCount: activeSubscrition.length,
                                  itemBuilder: (context, i) {
                                    return PaymentCard(
                                      onpress: () {},
                                      onpress2: () {},
                                      title: activeSubscrition[i]
                                                  ["subscriptionType"]
                                              ["subscriptionType"]
                                          .toString(),
                                      subtitle: DateFormat("yMMMMEEEEd").format(
                                          DateTime.parse(activeSubscrition[i]
                                                      ["subscriptionType"]
                                                  ["createdAt"]
                                              .toString())),
                                      trailing:
                                          "\$${activeSubscrition[i]["subscriptionType"]["price"].toString()}",
                                    );
                                  }),
                          cencledSubscrition.isEmpty
                              ? Center(
                                  child: text(
                                    "No cancelled Subscription available for now",
                                    fontSize: 14.0,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: activeSubscrition.length,
                                  itemBuilder: (context, i) {
                                    return SingleChildScrollView(
                                      child: PaymentCard(
                                          onpress: () {},
                                          onpress2: () {},
                                          title: activeSubscrition[i]
                                                      ["subscriptionType"]
                                                  ["subscriptionType"]
                                              .toString(),
                                          subtitle: DateFormat("yMMMMEEEEd")
                                              .format(DateTime.parse(
                                                  activeSubscrition[i][
                                                              "subscriptionType"]
                                                          ["createdAt"]
                                                      .toString())),
                                          trailing:
                                              "\$${activeSubscrition[i]["subscriptionType"]["price"].toString()}"),
                                    );
                                  })
                        ],
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: spacing_twinty);
              }
            }));
  
  }
}

// ignore: must_be_immutable
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
                    text(title.toString(),
                        fontSize: textSizeSmall,
                        textAllCaps: true,
                        fontWeight: FontWeight.w500),
                    text(subtitle.toString(),
                        fontSize: textSizeSmall, textColor: textGreyColor),
                  ]),
              Row(
                children: [
                  text(trailing.toString(),
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
