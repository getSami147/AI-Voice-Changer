// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:voice_maker/data/appException.dart';
import 'package:voice_maker/data/network/baseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  // Get API Method......
  @override
  Future<dynamic> getApi(String url, Map<String, String> headers,{String? query}) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url).replace(query: query), headers: headers);
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;
  }

  // getStreemApiMethod......
    @override
  getStreemApi(String url, Map<String, String> headers) async {
       dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;

  }

  // Post API Method......
  @override
  Future<dynamic> postApi(
      dynamic data, String url, Map<String, String> headers) async {
    dynamic jsonResponse;
    try {
      
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 15));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;
  }
 // update Api Method......
  @override
  Future<dynamic> updateApi( dynamic data,String url, Map<String, String> headers) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .patch(Uri.parse(url),body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 15));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;
  }
  // delete Api Method......
  @override
  Future<dynamic> deleteApi(String url, Map<String, String> headers) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 15));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    }
    return jsonResponse;
  }
   
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        throw "";
      case 404:
        throw jsonDecode(response.body)["message"].toString();
      case 400:
        throw jsonDecode(response.body)["message"].toString();
      case 401:
        throw jsonDecode(response.body)["message"].toString();
      case 500:
        throw jsonDecode(response.body)["message"].toString();

      default:
        throw FatchDataExceptions(
            "Error occur While Fatching The Data:  ${response.statusCode}");
    }
  }
  

}
