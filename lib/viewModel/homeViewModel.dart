import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/data/appException.dart';
import 'package:voice_changer/repository/homeRepository.dart';
import 'package:voice_changer/res/appUrl.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:voice_changer/models/apiModels.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';
import 'package:voice_changer/viewModel/userViewModel2.dart';

class HomeViewModel with ChangeNotifier {
  List<dynamic> items = [];
  bool loadingcommunity = false;

  final homeRepository = HomeRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // <<< Get API's..........................>>> //
  // blogApi..............................................................>>
  Future<void> blogApi(BuildContext context) async {
    return homeRepository.blogApi(context);
  }

  // single BlogApi..............................................................>>
  Future<void> singleBlogApi(BuildContext context, String id) async {
    return homeRepository.singleBlogApi(context, id);
  }

  Future<void> fetchCommunityData(BuildContext context) async {
    var page = 1;
    var limit = 3;
    if (!loadingcommunity) {
      loadingcommunity = true;
      notifyListeners();
      try {
        dynamic response =
            await homeRepository.communityApi(context, page, limit);
        // Assuming 'data' is the key for the list in the response
        List<dynamic> fetchedData = response['data'];
        items.addAll(fetchedData);
        page++;
        limit++;
        notifyListeners();
      } catch (e) {
        throw e.toString();
      }
      loadingcommunity = false;
      notifyListeners();
    }
      notifyListeners();

  }

  // communityApi..............................................................>>
  // Future<void> communityApi(
  //     BuildContext context) async {
  //   return homeRepository.communityApi(context);
  // }
  // singleCommunityApi..............................................................>>
  Future<void> singleCommunityApi(BuildContext context, String id) async {
    return homeRepository.singleCommunityApi(context, id);
  }

  //
  // // streemlikeIncrease..............................................................>>
  // Future<void> streemlikeIncrease(BuildContext context, String id) async {
  //   notifyListeners();
  //   return homeRepository.streemlikeIncrease(context, id).then((value) => {});
  // }

  // likeIncreaseApi..............................................................>>
  Future<void> likeIncreaseApi(BuildContext context, String id) async {
    notifyListeners();
    return homeRepository.likeIncreaseApi(context, id);
  }

  // downloadIncreaseApi..............................................................>>
  Future<void> downloadIncreaseApi(BuildContext context, String id) async {
    return homeRepository.downloadsIncreaseApi(context, id);
  }

  // shareIncreaseApi..............................................................>>
  Future<void> shareIncreaseApi(BuildContext context, String id) async {
    return homeRepository.shareIncreaseApi(context, id);
  }

  // voice Get All..............................................................>>
  Future<void> voiceGetAll(BuildContext context) async {
    return homeRepository.voiceGetAll(context);
  }

  // get Community User Profile..............................................................>>
  Future<void> getCommunityUserProfile(BuildContext context, String id) async {
    return homeRepository.getCommunityUserProfile(context, id);
  }

  // getFAQs..............................................................>>
  Future<void> getFAQs(BuildContext context) async {
    return homeRepository.getFAQs(context);
  }

  // get Overview..............................................................>>
  Future<void> getOverview(BuildContext context) async {
    return homeRepository.getOverview(context);
  }

  // get PricingApi..............................................................>>
  Future getPricingApi(BuildContext context) async {
    return homeRepository.getPricingApi(context);
  }

  // get Mysubscription..............................................................>>
  Future getmysubscription(BuildContext context) async {
    return homeRepository.getMysubscription(context);
  }

  // // get Mysubscription..............................................................>>
  // Future subTypeGetAll(BuildContext context) async {
  //   return homeRepository.subTypeGetAll(context);
  // }

// get Comments ..............................................................>>
  bool isloading = false;
  setIsLoading(bool value) {
    isloading = value;
    notifyListeners();
  }
  

  CommentModel api = CommentModel();
  Future getCommentAll(context) async {
    setIsLoading(true);
    var provider = Provider.of<UserViewModel>(context, listen: false);

    final headers = {
      "Authorization": "Bearer ${provider.logintoken}",
    };
    try {

      var response = await http.get(
          Uri.parse(AppUrls.urlGetComments + provider.communityId)
              .replace(query: "populate=commentUid"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        api = CommentModel.fromJson(data);
        notifyListeners();
        setIsLoading(false);
      } else {
        setIsLoading(false);
      }
    } catch (e) {
      setIsLoading(false);

      print('Failed to load user chat: $e');
      throw Exception('Failed to load user chat: $e');
    }
  }
    ////
    
  CommentModel CommunityAllModel = CommentModel();
  Future getCommunityAll(context) async {
    setIsLoading(true);
    var provider = Provider.of<UserViewModel>(context, listen: false);

    final headers = {
      "Authorization": "Bearer ${provider.logintoken}",
    };
    try {

      var response = await http.get(
          Uri.parse(AppUrls.urlGetComments + provider.communityId)
              .replace(query: "populate=commentUid"),
          headers: headers);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        api = CommentModel.fromJson(data);
        notifyListeners();
        setIsLoading(false);
      } else {
        setIsLoading(false);
      }
    } catch (e) {
      setIsLoading(false);

      print('Failed to load user chat: $e');
      throw Exception('Failed to load user chat: $e');
    }
  }


///////
//   Stream<http.Response> fetchData(context) async* {
//     var provider =Provider.of<UserViewModel>(context,listen: false);
//     var headers = {
//   'Authorization': 'Bearer ${provider.logintoken}'
// };
//     var request = http.Request('GET', Uri.parse(AppUrls.urlCommunityAll));
//      request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     yield await http.Response.fromStream(response);
//   }
  ///
  Stream<http.Response> StreemGetCommunity(context) async* {
    // while (true) {
      try {
      var provider = Provider.of<UserViewModel>(context, listen: false);
      var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
      var response =
          await http.get(Uri.parse(AppUrls.urlCommunityAll).replace(query: "populate=referenceToUser"), headers: headers);
      if (response.statusCode == 200) {
        yield response;
        notifyListeners();

      }else if(response.statusCode==503){

      }
       else {
throw FatchDataExceptions("Please check your internet connection");
      }
      // await Future.delayed(Duration(seconds: 5)); 
    
      // Adjust the delay as needed

    } on SocketException{
throw InternetException("");

    }
    // }
  }

  // <<< Post API's..........................>>> //
  // contectUsApi.........................................................>>
  Future<void> contectUsApi(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    setLoading(true);
    homeRepository.contectUsApi(data, headers).then((value) {
      utils().flushBar(context, value["message"]);
      setLoading(false);
      const Dashboard()
          .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
      utils().flushBar(context, "Congrats! Your Message Succusfully post");
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }

  // postComment Api.........................................................>>
  Future<void> postComment(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    setLoading(true);
    await homeRepository.postComment(data, headers).then((value) {
      setLoading(false);
      Provider.of<HomeViewModel>(context, listen: false).getCommentAll(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }

   // createSubscriton API.........................................................>>
  Future<void> createSubscritonAPI(
      dynamic data, Map<String, String> headers, BuildContext context) async {
    await homeRepository.createSubscritonAPI(data, headers).then((value) {
      print("value Response: ${value}");
    }).onError((error, stackTrace) {
      utils().flushBar(context, error.toString());
      print("error: ${ error.toString()}");
    });
  }

  // Customize //Generate Voice...............................................
  Future generateVoice(
      context, Map<String, String> data, String audioURl) async {
    var p = Provider.of<UserViewModel>(context, listen: false);
    var p2 = Provider.of<UserViewModel2>(context, listen: false);
    p2.setLoading(true);
    var headers = {'Authorization': 'Bearer ${p.logintoken}'};
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.urlCustomizePost));
    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('audioURL', audioURl));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var generatedURl = await response.stream.bytesToString();
      p.getGeneratedAudioData(data, generatedURl);
    } else {
      p2.setLoading(false);

      // utils().toastMethod('Server: ${responseData["message"]}');
      // print(response.reasonPhrase);
    }
  }

  // Comunity POST (form File) .....
  void comunityPost(context, String audioURL, Map<String, String> data) async {
    var p = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${p.logintoken}'};
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.urlCommunityPost));
    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('audioURL', audioURL));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      utils().toastMethod("Posted");
    } else {}
  }

  // shareTo CommunityPost...............
  void shareToCommunityPost(context, Map<String, String> data) async {
    var p = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${p.logintoken}'};
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.urlCommunityPost));
    request.fields.addAll(data);
// request.files.add(await http.MultipartFile.fromPath('audioURL', audioURL));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      utils().toastMethod("Posted");
    } else {
      // print(response.reasonPhrase);
    }
  }

  // Update APIs..............................................................>>
  // UpdateMe Profile..............................................................>>
  Future<void> updateCommentApi(
      dynamic data, String id, BuildContext context) async {
    setLoading(true);
    homeRepository.updateCommentApi(data, id, context).then((value) async {
      setLoading(false);
      utils().flushBar(context, "Your comment has been Updated");
      Provider.of<HomeViewModel>(context, listen: false).getCommentAll(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
    });
  }

    // UpdateSubscription..............................................................>>
  Future<void> updateSubscription(
      dynamic data, String id, BuildContext context) async {
    homeRepository.updateSubscription(data, id, context).then((value) async {
      // utils().flushBar(context, "Your comment has been Updated");
    }).onError((error, stackTrace) {
      print("StripUpdate Error: ${error.toString()}");
      utils().flushBar(context, error.toString());

    });
  }

  // Delete APIs..............................................................>>
  // DeleteMe..............................................................>>
  Future<void> deleteCommentApi(String id, BuildContext context) async {
    setLoading(true);
    homeRepository.deleteCommentApi(id, context).then((value) async {
      setLoading(false);
      utils().flushBar(context, value["message"]);
      Provider.of<HomeViewModel>(context, listen: false).getCommentAll(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString());
      print(error.toString());
    });
  }

  // cancelSubscription API..............................................................>>
  Future<void> cancelSubscriptionAPI(String id, BuildContext context) async {
    homeRepository.cancelSubscriptionAPI(id, context).then((value) async {
  utils().toastMethod("Your current subscription has been permanently unsubscribed.");

    }).onError((error, stackTrace) {
      print("CancleSubsciption Erorr: ${error.toString()}");
      utils().flushBar(context, error.toString());
    });
  }

}
