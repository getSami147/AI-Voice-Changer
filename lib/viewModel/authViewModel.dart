import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/repository/authRepository.dart';
import 'package:voice_changer/res/appUrl.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/authView/logIn.dart';
import 'package:voice_changer/view/authView/otpVerification.dart';
import 'package:voice_changer/view/authView/restPassword.dart';
import 'package:voice_changer/view/screens/Account.dart';
import 'package:voice_changer/view/screens/profileScreen.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';
import 'package:http/http.dart'as http;

import '../view/screens/dashboard.dart';

class AuthViewModel with ChangeNotifier {
  final authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
// Get APIs //.........................................................................>>
  // getMeApi..............................................................>>
  Future<void> getMeApi(
      BuildContext context,) async {
    //  authRepository.getMeApi(context).then((value) => {});
    return  authRepository.getMeApi(context);
  }

// Post APIs //.........................................................................>>
// Login API..............................................................>>
  Future<void> loginApi(
      dynamic data, dynamic headers, BuildContext context) async {
    setLoading(true);
    authRepository.loginApi(data, headers).then((value) async {

 final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("accessToken", value["tokens"]["access"]["token"].toString());
    sp.setString("refreshToken", value["tokens"]["refresh"]["token"].toString());
    sp.setString("userId",value["user"]["_id"].toString());
      setLoading(false);
       // ignore: use_build_context_synchronously
       const Dashboard().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,isNewTask: true,
      );
      // ignore: use_build_context_synchronously
      utils().flushBar(context, "Congrats! Your are succussfully logined");
          
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }
  // signUP API.........................................................>>
  Future<void> singUpApi(
      dynamic data, dynamic headers, BuildContext context) async {
    setLoading(true);
    authRepository.signUpApi(data, headers).then((value) {
      setLoading(false);
      const LoginScreen().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
        isNewTask: true,
      );
      utils().flushBar(context, "Congrats! Your Registred Succusfully");

      if (kDebugMode) {
        print("signUp debug:  ${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }
  // logOutApi..............................................................>>
  Future<void> logOutApi(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    authRepository.logOutApi(data, headers).then((value) {
      setLoading(true);
      const LoginScreen().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
        isNewTask: true,
      );
      utils().flushBar(context, "Logout Succussfull");
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, "on error : $error");
    });
  }
  // forgot Password Api..............................................................>>
  Future<void> forgotApi(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    setLoading(true);

    authRepository.forgotApi(data, headers).then((value) {
    setLoading(false);
      const ResetPassword().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
        
      );
      utils().flushBar(context, value["message"].toString());
    }).onError((error, stackTrace) {
      // setLoading(false);
      utils().flushBar(context, "on error : $error");
    });
  }
  // Rest Password Api..............................................................>>
  Future<void> restPasswordApi(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    setLoading(true);

    authRepository.restPasswordApi(data, headers).then((value) {
      const OtpVerification().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
       
      );
    // setLoading(false);
      utils().flushBar(context, "The password has been changed succusfull");
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
    setLoading(false);
      utils().flushBar(context, "on error : $error");
      print(error.toString());
    });
  }

  // Delete APIs..............................................................>>
  // DeleteMe..............................................................>>
 Future<void> deleteMe(BuildContext context) async { 
    setLoading(true);
    authRepository.deleteMe(context).then((value) async {
      setLoading(false);
       const LoginScreen().launch(context,isNewTask: true,
        pageRouteAnimation: PageRouteAnimation.Fade);
      utils().flushBar(context, value["status"]);      
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }

  // Update APIs..............................................................>>
  // UpdateMe Profile..............................................................>>
 Future<void> updateMeApi(
      dynamic data, BuildContext context) async { 
    setLoading(true);
    authRepository.updateMeApi(data,context).then((value) async {
      setLoading(false);
       const Account().launch(context,
        pageRouteAnimation: PageRouteAnimation.Fade);
      utils().flushBar(context, "Congrats you are Profile has been Updated");      
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }
   /////////
     // Update Kitchen 
  updateMe(BuildContext context, String name, String email)async{
     var p = Provider.of<UserViewModel>(context, listen: false);
  var headers = {'Authorization': 'Bearer ${p.logintoken}'};
   
var request = http.MultipartRequest('PATCH', Uri.parse(AppUrls.urlUpdateMe));
request.fields.addAll({
   'name': name,
    'email': email,
    });
 
 request.files.add(await http.MultipartFile.fromPath('userImageURl',p.image!.path));
    request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
 utils().flushBar(context, "Profile Uploaded");
 const Dashboard().launch(context,isNewTask: true);
}
else {

}

  }
   ///



   Future<void> updateProfile(BuildContext context, String name, String email) async {
  var p = Provider.of<UserViewModel>(context, listen: false);
  var headers = {'Authorization': 'Bearer ${p.logintoken}'};
  
  showDialog(
    context: context,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  if (p.image != null) {
    var stream = http.ByteStream(p.image!.openRead());
    stream.cast();
    var length = await p.image!.length();
    var uri = Uri.parse(AppUrls.urlUpdateMe);
    var request = http.MultipartRequest('PATCH', uri);
    var multipartFile = http.MultipartFile('userImageURl', stream, length);
    
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields.addAll({
      'name': name,
      'email': email,
    });

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString(); // Get the response body as a string

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200) {
        print('Image Uploaded');
        // utils().flushBar(context, "Image Uploaded");
      } else {
        print('Uploading Failed');
        // utils().flushBar(context, "Uploading Failed");
      }
    } catch (error) {
      print('Error: $error');
      // utils().flushBar(context, "Error: $error");
    } finally {
      Navigator.pop(context); // Close the dialog
    }
  } else {
    // Handle the case where p.image is null, possibly show an error message.
    print('Image is null. Cannot upload.');
    // utils().flushBar(context, "Image is null. Cannot upload.");
    Navigator.pop(context); // Close the dialog
  }
}


  

//
}

