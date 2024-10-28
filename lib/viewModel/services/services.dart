// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:voice_changer/models/userModel.dart';
// import 'package:voice_changer/view/authView/logIn.dart';
// import 'package:voice_changer/view/screens/dashboard.dart';
// import 'package:voice_changer/viewModel/userViewModel.dart';

// class SplashSerives {
//   // Future<Access> getUserData() => UserViewModel().getUser();

//   void checkAuthentication(BuildContext context) async {
//     getUserData().then((value) {
//       if (kDebugMode) {
//         print("token: ${value.token}");
//       }
//       value.token == "null" || value.token == ""
//           ? const LoginScreen().launch(context)
//           : const Dashboard().launch(context);
//     });
//   }
// }
