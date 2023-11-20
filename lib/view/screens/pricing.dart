import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/Images.dart';
import 'package:voice_maker/utils/colors.dart';
import 'package:voice_maker/utils/constant.dart';
import 'package:voice_maker/utils/string.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/screens/subscription_process.dart';
import 'package:voice_maker/viewModel/homeViewModel.dart';
import 'package:voice_maker/viewModel/userViewModel2.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appbar_Pricing,
        backbutton: true,
        backPressed: () {
          finish(context);
        },
      ),
      body: FutureBuilder(
          future: HomeViewModel().getPricingApi(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: text(snapshot.error.toString(),
                      maxLine: 5, isCentered: true));
            } else {
              return Consumer<UserViewModel2>(
                builder: (BuildContext context, val, Widget? child) {  
               return ListView.builder(
                    physics:
                        const BouncingScrollPhysics(),
                    itemCount: snapshot.data["data"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data["data"][index];
                      return InkWell(
                        onTap: () {
                          val.selectedCardMethod(index);
                       val.selectedCardIndex=index;  
                        },child: Card(
                            elevation: 0,
                            color: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color:val.selectedCardIndex==index? colorPrimary:Colors.white,)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text("\$${data['price'].toString()}/mth",
                                          fontSize: textSizeXXLarge,
                                          fontWeight: FontWeight.w600)
                                      .center()
                                      .paddingTop(spacing_twinty),
                                       text(data['subscriptionType'],
                                          fontSize: textSizeNormal,
                                          fontWeight: FontWeight.w600)
                                      .center().paddingTop(spacing_standard_new),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data["subscriptionText"].length,
                                    itemBuilder: (context, index) {
                        var boolean=data["subscriptionBoolean"][index];
                      
                                      return Row(children: [
                                       Image.asset(boolean ? pricing_Checkbox:pricing_Cross,height: 20,width: 20,),
                                        const SizedBox(width: spacing_middle,),
                                        text(data["subscriptionText"][index],textColor: textGreyColor)
                                      ],);
                                    },
                                  ).paddingTop(spacing_thirty),
                                  GradientButton(
                                          onPressed: ()async {
                                          //  await HomeViewModel().makePayment(amount: "200", currency: 'USD');
                                          init("\$ ${ data['price'].toString()}");
                                          },
                                          child: text("Get started",
                                              textAllCaps: true,
                                              googleFonts: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w500,
                                                  color: color_white)))
                                      .paddingTop(spacing_thirty),
                                ]).paddingSymmetric(
                                horizontal: spacing_large,
                                vertical: spacing_twinty)).paddingTop(10),
                      );
                            
                    }).paddingSymmetric(horizontal: spacing_twinty);
            });
            }
          }),
    );
  }
  
}
