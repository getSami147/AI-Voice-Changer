import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_maker/res/appUrl.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/view/authView/logIn.dart';
import 'package:voice_maker/view/screens/dashboard.dart';
import 'package:http/http.dart'as http;
import 'package:voice_maker/viewModel/homeViewModel.dart';


class UserViewModel with ChangeNotifier {
 

// Image Picker Profile..................................
 File? _image;
 File? get image=>_image;

   Future getImages() async {
  final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
     notifyListeners();
    } else {
      utils().toastMethod("'images not picked");
      // print('images not picked');
    }
  }

  void setUserData(String name, String email) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("saveName", name);
    sp.setString("saveEmail", email);
  }
  var getname;
  var getemail;
 void getuserProfile(name,email){
getname=name;
getemail=email;
  }

   void getUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
   getname= sp.getString("saveName");
   getemail= sp.getString("saveEmail");
  }

  // Like Button.......................>>
   var isLike =false;
  // bool get isLiked => _isLiked;

  void toggleLike() {
    isLike = !isLike;
    print(isLike);
    notifyListeners();
    
  }

  // remove share Prefence data.......................>>
  void remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

// Get User Token...........................................................>>>
  String? _logintoken;
  String? _refreshtoken;
  String? _userId;
  String? get logintoken => _logintoken;
  String? get refreshtoken => _refreshtoken;
  String? get userId => _userId;

  void getUserTokens() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _logintoken = sp.getString("accessToken");
    _refreshtoken = sp.getString("refreshToken");
    _userId = sp.getString("userId");
    
  }

  // isCheack Login ..........................................................>>>
  void isCheackLogin(context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var accessToken = sp.getString("accessToken");
    // if (kDebugMode) {
    // }
    accessToken == null
        ? const LoginScreen().launch(context)
        : const Dashboard().launch(context);
    notifyListeners();
    
  }
    // Audio Picker for Community Post Screen..................................
  var pathfile;
  void audiopicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
        pathfile = result.files.first.path!;
        utils().toastMethod("Audio File Picked");
        notifyListeners();
    }
  }
  // Audio Picker for Generated Screen..................................
  var filePath;
  void pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
        filePath = result.files.first.path!;
        utils().toastMethod("Audio File Picked");
        notifyListeners();
    }
  }
  var communityId;
 void getCommunityId(id){
communityId=id;
  }

Map<String, String>? data;
var url;
 getGeneratedAudioData(Map<String, String>? getdata,geturl){
data=getdata;
url=geturl;

 }
 
}