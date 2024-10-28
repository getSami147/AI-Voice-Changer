// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/colors.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/string.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/screens/subscription_process.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel2.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: appbar_Pricing,
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
              final activeSubscription =
                  (snapshot.data != null && snapshot.data.containsKey('data'))
                      ? snapshot.data['data']
                          .where((e) => e['status'] == 'Active')
                          .toList()
                      : [];

              return
activeSubscription.isEmpty?FutureBuilder(
                future: HomeViewModel().getPricingApi(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CustomLoadingIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: text(snapshot.error.toString(),
                            maxLine: 5, isCentered: true));
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: text("No subscription"),
                    );
                  } else {
                 
                    return Consumer<UserViewModel2>(
                      builder: (BuildContext context, val, Widget? child) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data["data"].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                          
                            var data = snapshot.data["data"][index];
                            return InkWell(
                              onTap: () {
                           
                              },
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text("\$${data["price"]}/mth",
                                            fontSize: textSizeXXLarge,
                                            fontWeight: FontWeight.w600)
                                        .center()
                                        .paddingTop(spacing_twinty),
                                    text(data['subscriptionType'],
                                            fontSize: textSizeNormal,
                                            textAllCaps: true,
                                            fontWeight: FontWeight.w600)
                                        .center()
                                        .paddingTop(spacing_standard_new),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          data["subscriptionText"].length,
                                      itemBuilder: (context, index) {
                                        var boolean =
                                            data["subscriptionBoolean"][index];

                                        return Row(
                                          children: [
                                            Image.asset(
                                              boolean
                                                  ? pricing_Checkbox
                                                  : pricing_Cross,
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: spacing_middle,
                                            ),
                                            text(
                                                data["subscriptionText"][index],
                                                textColor: textGreyColor)
                                          ],
                                        );
                                      },
                                    ).paddingTop(spacing_thirty),

                                     GradientButton(
                                            onPressed: () async {
                                              utils().toastMethod("wait...");
                                               init(
                                                      "\$${data["price"]}",
                                                      data["priceId"],
                                                      provider.getname,
                                                      provider.getemail,
                                                      data["_id"].toString(),
                                                      context);
                                            },
                                            child: text(
                                               "Subscribe",   
                                              textAllCaps: true,
                                              googleFonts: GoogleFonts.lato(
                                                fontWeight: FontWeight.w500,
                                                color: color_white,
                                              ),
                                            ),
                                          ).paddingTop(spacing_thirty),
                                  
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ).paddingSymmetric(
                                  horizontal: spacing_large,
                                ),
                              ).paddingTop(10),
                            );
                          },
                        ).paddingSymmetric(horizontal: spacing_twinty);
                      },
                    );
                  }
                },
              )
           
                              :
 FutureBuilder(
                future: HomeViewModel().getPricingApi(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CustomLoadingIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: text(snapshot.error.toString(),
                            maxLine: 5, isCentered: true));
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: text("No subscription"),
                    );
                  } else {
                    String? priceId = activeSubscription[0]["subscriptionType"]
                            ["priceId"]
                        .toString();
                    var subscriptionId = activeSubscription[0]
                            ["subscriptionStripeId"]
                        .toString();
                    var customerId =
                        activeSubscription[0]["customerId"].toString();
                    if (kDebugMode) {
                      print("price id: ${priceId}");
                      print("subscriptionId: ${subscriptionId}");
                      print("_id: ${activeSubscription[0]["_id"]}");
                    }
                    return Consumer<UserViewModel2>(
                      builder: (BuildContext context, val, Widget? child) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data["data"].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // var price = productPriceList[index];
                            // var priceId = productIdList[index];
                            var data = snapshot.data["data"][index];
                            return InkWell(
                              onTap: () {
                                // val.selectedCardMethod(index);
                                // val.selectedCardIndex = index;
                              },
                              child: Card(
                                elevation: 0,
                                color: activeSubscription.isEmpty
                                    ? null
                                    : priceId == data["priceId"]
                                        ? colorPrimary.withOpacity(.2)
                                        : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: priceId.isNotEmpty == data["priceId"]
                                        ? colorPrimary.withOpacity(.2)
                                        : Colors.white,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text("\$${data["price"]}/mth",
                                            fontSize: textSizeXXLarge,
                                            fontWeight: FontWeight.w600)
                                        .center()
                                        .paddingTop(spacing_twinty),
                                    text(data['subscriptionType'],
                                            fontSize: textSizeNormal,
                                            textAllCaps: true,
                                            fontWeight: FontWeight.w600)
                                        .center()
                                        .paddingTop(spacing_standard_new),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          data["subscriptionText"].length,
                                      itemBuilder: (context, index) {
                                        var boolean =
                                            data["subscriptionBoolean"][index];

                                        return Row(
                                          children: [
                                            Image.asset(
                                              boolean
                                                  ? pricing_Checkbox
                                                  : pricing_Cross,
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: spacing_middle,
                                            ),
                                            text(
                                                data["subscriptionText"][index],
                                                textColor: textGreyColor)
                                          ],
                                        );
                                      },
                                    ).paddingTop(spacing_thirty),

                                    // Check if provider.priceId is equal to the current card's priceId
                                    priceId.isNotEmpty == data["priceId"]
                                        ? GradientButton(
                                            onPressed: null,
                                            child: text(
                                              "Current Plan",
                                              textAllCaps: true,
                                              googleFonts: GoogleFonts.lato(
                                                fontWeight: FontWeight.w500,
                                                color: color_white,
                                              ),
                                            ),
                                          ).paddingTop(spacing_thirty)
                                        : GradientButton(
                                            onPressed: () async {
                                              utils().toastMethod("wait...");
                                              priceId == null
                                                  ? init(
                                                      "\$${data["price"]}",
                                                      data["priceId"],
                                                      provider.getname,
                                                      provider.getemail,
                                                      data["_id"].toString(),
                                                      context)
                                                  : showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return CustomeArltDialogue(
                                                          title: "Alert!",
                                                          subtitle:
                                                              "If you choose to upgrade your current subscription, it will automatically cancel the existing one.",
                                                          filledbutton:
                                                              "Upgrade",
                                                          titleColor:
                                                              Colors.red,
                                                          filledOnTap: () {
                                                            finish(context);
                                                            upgradeSubscription(
                                                                customerId,
                                                                subscriptionId,
                                                                data[
                                                                    "priceId"]);
                                                          },
                                                          outlineButton:
                                                              "Go Back",
                                                          outlineOnTap: () {
                                                            finish(context);
                                                          },
                                                        );
                                                      },
                                                    );
                                            },
                                            child: text(
                                              priceId == null
                                                  ? "Subscribe"
                                                  : "Upgrade",
                                              textAllCaps: true,
                                              googleFonts: GoogleFonts.lato(
                                                fontWeight: FontWeight.w500,
                                                color: color_white,
                                              ),
                                            ),
                                          ).paddingTop(spacing_thirty),
                                    priceId == data["priceId"]
                                        ? GradientButton(
                                            onPressed: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return CustomeArltDialogue(
                                                    title: "Warrning!",
                                                    titleColor: Colors.red,
                                                    subtitle:
                                                        "Do you want to cancel your current subscription?",
                                                    filledbutton: "Yes",
                                                    filledOnTap: () {
                                                      finish(context);
                                                      cancelSubscription(subscriptionId, "id", context)
                                                          .then((value) {
                                                        UserViewModel()
                                                            .removeMysubscriptionDetails();
                                                      });
                                                    },
                                                    outlineButton: "No",
                                                    outlineOnTap: () {
                                                      finish(context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: text(
                                              "Cancle Plan",
                                              textAllCaps: true,
                                              googleFonts: GoogleFonts.lato(
                                                fontWeight: FontWeight.w500,
                                                color: color_white,
                                              ),
                                            ),
                                          ).paddingTop(spacing_twinty)
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ).paddingSymmetric(
                                  horizontal: spacing_large,
                                ),
                              ).paddingTop(10),
                            );
                          },
                        ).paddingSymmetric(horizontal: spacing_twinty);
                      },
                    );
                  }
                },
              );
           
            }
          }),
    );
  }
}

class CustomeArltDialogue extends StatelessWidget {
  var title;
  var subtitle;
  var outlineButton;
  var filledbutton;
  Color? titleColor;

  VoidCallback? outlineOnTap;
  VoidCallback? filledOnTap;
  CustomeArltDialogue(
      {required this.title,
      this.titleColor = colorPrimary,
      required this.subtitle,
      required this.filledbutton,
      required this.filledOnTap,
      required this.outlineButton,
      required this.outlineOnTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                  const SizedBox(
                    height: spacing_standard,
                  ),
                  Center(
                    child: text(
                      title,
                      fontWeight: FontWeight.w700,
                      fontSize: textSizeNormal,
                      textColor: titleColor,
                    ),
                  ),
                  const SizedBox(
                    height: spacing_standard_new,
                  ),
                  Center(
                    child: text(subtitle,
                        fontSize: 16.0, maxLine: 5, isCentered: true),
                  ),
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
                    onPress: outlineOnTap,
                    height: 45.0,
                    width: 150.0,
                    borderRadius: 5.0,
                    backgroundColor: color_white,
                    bodersideColor: Colors.black,
                    widget: text(outlineButton, fontSize: textSizeSMedium),
                  ),
                  const SizedBox(
                    width: spacing_standard_new,
                  ),
                  elevatedButton(
                    context,
                    onPress: filledOnTap,
                    height: 45.0,
                    width: 150.0,
                    borderRadius: 5.0,
                    backgroundColor: Dissmisable_RedColor,
                    bodersideColor: Dissmisable_RedColor,
                    widget: text(filledbutton,
                        textColor: color_white, fontSize: textSizeSMedium),
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
