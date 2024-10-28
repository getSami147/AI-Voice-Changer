import 'package:provider/provider.dart';
import 'package:voice_changer/data/network/baseApiServices.dart';
import 'package:voice_changer/data/network/networkApiServices.dart';
import 'package:voice_changer/res/appUrl.dart';
import 'package:voice_changer/view/screens/communityComment.dart';
import 'package:voice_changer/view/screens/updateComment.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

class HomeRepository {
  NetworkApiServices apiServices = NetworkApiServices();

                 // <<< Get API's..........................>>> //
  //All BlogApi...........
  Future<dynamic> blogApi(context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlBlog, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //single Blog Api...........
  Future<dynamic> singleBlogApi(context,String id) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlSingleBlog+id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //community Api...........
  
  Future<dynamic> communityApi(context,page,limit) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(
        '${AppUrls.urlCommunityAll}?limit=$limit&page=$page',
        headers,query: "populate=referenceToUser"
      // dynamic response = await apiServices.getApi(AppUrls.urlCommunityAll, headers);
      // return response;
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  //voiceGetAll...........
  Future<dynamic> voiceGetAll(context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urldreemvoice, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  
  //singleCommunityApi...........
  Future<dynamic> singleCommunityApi(context,id) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlCommunitySingle+id, headers);
      return response;
      
    } catch (e) {
      throw e.toString();
    }
  }

      //getCommunityUserProfile...........
  Future getCommunityUserProfile(context,String id) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    // var provider
    try {
     dynamic response = await apiServices.getApi(AppUrls.urlCommunityProfile+id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
      //getFAQs...........
  Future getFAQs(context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    // var provider
    try {
     dynamic response = await apiServices.getApi(AppUrls.urlFAQ, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
     //get Overview...........
  Future getOverview(context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    // var provider
    try {
     dynamic response = await apiServices.getApi(AppUrls.urloverview, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
//   // Streem Like..
//  Future<dynamic> streemlikeIncrease(context,String id) async {
//     var provider=Provider.of<UserViewModel>(context,listen: false);
//     var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
//     try {
//       dynamic response = apiServices.getStreemApi(AppUrls.urlLikeIncrease+id, headers);
//       return response;
//     } catch (e) {
//       throw e.toString();
//     }
//   }
   //likeIncreaseApi...........
  Future<dynamic> likeIncreaseApi(context,String id) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlLikeIncrease+id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
   //downloadsIncrease...........
  Future<dynamic> downloadsIncreaseApi(context,String id) async {
      var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {
  'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urldownloadsIncrease+id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
   //shareIncrease...........
  Future<dynamic> shareIncreaseApi(context,String id) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlSharesIncrease+id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
   //get PricingApi...........
  Future<dynamic>getPricingApi (context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlsubscriptiontype, headers,);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
    //get getMysubscription( My Payments)...........
  Future<dynamic>getMysubscription (context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlMysubscription, headers,query:  "populate=subscriptionType");
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  //    //get SubTypeGetAll( My Payments)...........
  // Future<dynamic>subTypeGetAll (context) async {
  //   var provider=Provider.of<UserViewModel>(context,listen: false);
  //   var headers = {'Authorization': 'Bearer ${provider.logintoken}'};
  //   try {
  //     dynamic response = await apiServices.getApi(AppUrls.urlsubscriptiontype, headers,);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

                 // <<< Post API's..........................>>> //
    // contect us API...........
  Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
   // postComment API...........
  Future<dynamic> postComment(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlcommentPost, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  } 
    // createSubscriton API...........
  Future<dynamic> createSubscritonAPI(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlCreatesubscription, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  
 // shareTo CommunityPost...........
  Future<dynamic> shareToCommunityPost(dynamic data,Map<String, String> headers) async {
    try {
      dynamic response = await apiServices.postApi(data,AppUrls.urlCommunityPost, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }   
  //// contect us API...........
  // Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
  //   try {
  //     dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }   // contect us API...........
  // Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
  //   try {
  //     dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }   // contect us API...........
  // Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
  //   try {
  //     dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }   // contect us API...........
  // Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
  //   try {
  //     dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }   // contect us API...........
  // Future<dynamic> contectUsApi(dynamic data,Map<String, String> headers) async {
  //   try {
  //     dynamic response = await apiServices.postApi(data,AppUrls.urlContactUs, headers);
  //     return response;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  
 // Update Me API //...................................................>>>
   // Update Me Profile.................................................>>
  Future<dynamic> updateCommentApi(dynamic data,String id,context) async {
        var provider=Provider.of<UserViewModel>(context,listen: false);
        var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.updateApi(data, AppUrls.urlCommentUpdate+id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

   // UpdateSubscription.................................................>>
  Future<dynamic> updateSubscription(dynamic data,String id,context) async {
        var provider=Provider.of<UserViewModel>(context,listen: false);
        var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${provider.logintoken}'};
    try {
      dynamic response = await apiServices.updateApi(data, AppUrls.urlUpdatesubscription+id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  // Delete APIs //.......................................................>>>
  // Delete Me api......................................................>>>
  Future<dynamic> deleteCommentApi(String id,context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {
  'Authorization': 'Bearer ${provider.logintoken}'
};
    try {
      dynamic response = await apiServices.deleteApi(AppUrls.urlCommentDelete+id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

   // Delete Me api......................................................>>>
  Future<dynamic> cancelSubscriptionAPI(String id,context) async {
    var provider=Provider.of<UserViewModel>(context,listen: false);
    var headers = {
  'Authorization': 'Bearer ${provider.logintoken}'
};
    try {
      dynamic response = await apiServices.deleteApi(AppUrls.urlCanclesubscription+id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}


