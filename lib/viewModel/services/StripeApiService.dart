import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiServiceMethodType {
  get,
  post, 
  delete,
 
}

const baseUrl = 'https://api.stripe.com/v1';
final Map<String, String> requestHeaders = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization':'Bearer sk_test_51LjgmuBd21JmgpA7g0Ws1McFtiufLuhCZawJnJ32rrUIRCPdAiS92iIrSiME8YkpUeE70KPyn81tEmje5CiXhx6J00Ne6SuSby',
};

Future<Map<String, dynamic>?> apiService({
  required ApiServiceMethodType requestMethod,
  required String endpoint,
  Map<String, dynamic>? requestBody,
}) async {
  final requestUrl = '$baseUrl/$endpoint';

  // +++++++++++++++++
  // ++ GET REQUEST ++
  // +++++++++++++++++

  if (requestMethod == ApiServiceMethodType.get) {
    try {
      final requestResponse = await http.get(
        Uri.parse(requestUrl),
        headers: requestHeaders,
      );

      return json.decode(requestResponse.body);
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  // ++++++++++++++++++
  // ++ POST REQUEST ++
  // ++++++++++++++++++
if (requestMethod == ApiServiceMethodType.post) {
  try {
    final requestResponse = await http.post(
      Uri.parse(requestUrl),
      headers: requestHeaders,
      body: requestBody,
    );
  var data=json.decode(requestResponse.body);
   print("postResponse: ${data}");
    return data;
  } catch (err) {
    debugPrint("Error: $err");
  }
}
  // ++++++++++++++++++
  // ++ Delete REQUEST ++
  // ++++++++++++++++++
if (requestMethod == ApiServiceMethodType.delete) {
   try {
    final requestResponse = await http.delete(
      Uri.parse(requestUrl),
      headers: requestHeaders,
      body: requestBody,
    );
  var data=json.decode(requestResponse.body);
   print("postResponse: ${data}");
    return data;
  } catch (err) {
    debugPrint("Error: $err");
  }
  return null;

  
}
}