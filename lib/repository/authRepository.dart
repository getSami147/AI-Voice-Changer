import 'package:provider/provider.dart';
import 'package:voice_maker/data/network/baseApiServices.dart';
import 'package:voice_maker/data/network/networkApiServices.dart';
import 'package:voice_maker/res/appUrl.dart';
import 'package:voice_maker/viewModel/userViewModel.dart';

class AuthRepository {
  BaseApiServices apiServices = NetworkApiServices();

// Get APIs........................................................>>
  // getMe API...........
  Future<dynamic> getMeApi(context) async {
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlGetMe, {'Authorization': 'Bearer ${Provider.of<UserViewModel>(context,listen: false).logintoken}'
                  });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //
// Post APIs........................................................>>
  //login...........
  Future<dynamic> loginApi(dynamic data, dynamic headers) async {
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlLogin, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //signUp...........
  Future<dynamic> signUpApi(dynamic data, Map<String, String> headers) async {
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlSignUp, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
   // logoutApi API...........
  Future<dynamic> logOutApi(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlLogOut, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
   // forgot Password API...........
  Future<dynamic> forgotApi(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlForgotPassword, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  // Rest Password Api...........
  Future<dynamic> restPasswordApi(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlResetPassword, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
 
 // Update Me API //...................................................>>>
   // Update Me Profile.................................................>>
  Future<dynamic> updateMeApi(dynamic data,context) async {
        var provider=Provider.of<UserViewModel>(context,listen: false);
    try {
      dynamic response = await apiServices.updateApi(data, AppUrls.urlUpdateMe, {'Authorization': 'Bearer ${provider.logintoken}'});
      return response;
    } catch (e) {
      rethrow;
    }
  }
  // Delete APIs //.......................................................>>>
  // Delete Me api......................................................>>>
  Future<dynamic> deleteMe(context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {
  'Authorization': 'Bearer ${provider.logintoken}'
};
    try {
      dynamic response = await apiServices.deleteApi(AppUrls.urlDeleteMe, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  
}


