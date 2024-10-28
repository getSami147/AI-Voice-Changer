import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voice_changer/res/appUrl.dart';

class PaginationViewModel with ChangeNotifier {
 List<String> items = [];
  int page = 1;
  int limit=4;
  bool isLoading = false;
  final String apiUrl = 'YOUR_API_URL';

  Future<void> fetchData() async {
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
      final response = await http.get(Uri.parse( '${AppUrls.urlCommunityAll}?limit=$limit&page=$page'));

      if (response.statusCode == 200) {
        List<String> fetchedData =
            (json.decode(response.body) as List).cast<String>();
        items.addAll(fetchedData);
        page++;
      } else {
        throw Exception('Failed to load data');
      }
      isLoading = false;
      notifyListeners();
    }
  }

}
