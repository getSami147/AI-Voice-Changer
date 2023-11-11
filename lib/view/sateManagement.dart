import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateManagementClass with ChangeNotifier {
  bool _passwordObsecure = true;
  bool get passwordObsecure => _passwordObsecure;
  bool _passwordObsecure2 = true;
  bool get passwordObsecure2 => _passwordObsecure2;

  // var token;
  // var userid;

  // Pageview..........................................................>>>
  PageController pageController = PageController();
  int initialValue = 0;

  pageControllerMethod() {
    pageController.addListener(() {
      initialValue = pageController.page!.toInt();
      notifyListeners();
    });
  }

  // //isLoading..........................................................>>>
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // // Get Token..........................................................>>>
  // void getToken(context) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString("usertoken");
  //   userid = prefs.getString('userid');
  //   notifyListeners();
  // }

  // // isCheack Login ..........................................................>>>
  // void isCheackLogin(context) async {
  //   String? logintoken;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   logintoken = prefs.getString("usertoken");
  //   if (logintoken == null) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const StatingScreen(),
  //         ));
  //   } else {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Dashboard(),
  //         ));
  //   }
  //   notifyListeners();
  // }
}
