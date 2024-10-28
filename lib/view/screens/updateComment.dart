import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/constant.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/viewModel/authViewModel.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

class UpdateComment extends StatefulWidget {
  var id;
  var communityId;
   UpdateComment({ required this.id,required this.communityId, Key? key}) : super(key: key);

  @override
  State<UpdateComment> createState() => _UpdateCommentState();
}

class _UpdateCommentState extends State<UpdateComment> {
  final messegeController = TextEditingController();
    final mesaageFouse=FocusNode();

    @override
  void dispose() {
    // TODO: implement dispose
    messegeController.dispose();
    mesaageFouse.dispose();
    super.dispose();
  }
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
                  text(
                    "Edit Comment",
                    fontWeight: FontWeight.w500,
                    fontSize: textSizeLargeMedium,
                    textColor: colorPrimary,
                  ),
                  textformfield(
                    hinttext: "Type your Comment here..",
                    controller: messegeController,
                    focusNode: mesaageFouse,
                    hight: 150.0,
                    obscureText: false,
                    filledColor: filledColor,
                    maxLine: 30,

                    // hinttext: ContactUs_Name,
                  )
                      .paddingTop(spacing_standard_new)
                      .paddingSymmetric(horizontal: spacing_middle),
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
                    bodersideColor: Colors.black,
                    widget: text("Cancel", fontSize: textSizeSMedium),
                  ),
                  const SizedBox(
                    width: spacing_standard_new,
                  ),
                  elevatedButton(
                    context,
                    onPress: () {
                      var provider = Provider.of<UserViewModel>(context,listen: false);
                      var data = {
                        "commentUid": "${provider.userId}",
                        "commentMessage": messegeController.text.trim().toString(),
                        "communityId":widget.communityId,
                        
                      };
                    mesaageFouse.unfocus();
                    messegeController.clear();
                      HomeViewModel().updateCommentApi(data, widget.id, context);
                      finish(context);
                    },
                    height: 45.0,
                    width: 150.0,
                    borderRadius: 5.0,
                    backgroundColor: colorPrimary,
                    bodersideColor: colorPrimary,
                    widget: text("Update",
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
