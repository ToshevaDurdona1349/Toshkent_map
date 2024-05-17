import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../model/distance_model.dart';
import '../model/token_model.dart';
import 'http_helper.dart';

class Network {
  static bool isTester = true;
  static String SERVER_DEV = "quiz.4fun.uz";
  static String SERVER_PROD = "quiz.4fun.uz";

  static final client = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    retryPolicy: HttpRetryPolicy(),
  );

  static String getServer() {
    if (isTester) return SERVER_DEV;
    return SERVER_PROD;
  }

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.post(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.put(uri, body: jsonEncode(params));
      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    try {
      var uri = Uri.https(getServer(), api, params);
      var response = await client.delete(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        _throwException(response);
      }
    } on SocketException catch (_) {
      // if the network connection fails
      rethrow;
    }
  }

  static _throwException(Response response) {
    String reason = response.reasonPhrase!;
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(reason);
      case 401:
        throw InvalidInputException(reason);
      case 403:
        throw UnauthorisedException(reason);
      case 404:
        throw FetchDataException(reason);
      case 500:
      default:
        throw FetchDataException(reason);
    }
  }

  /* Http Apis*/
  static String API_DISTANCE = "/get_distance/";
  static String API_TOKEN = "/token/";

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsToken() {
    Map<String, String> params = {};
    params.addAll({'username': "tester", 'password': 'tester1'});
    return params;
  }

  static Map<String, String> paramsDistance(double latitude, double longitude) {
    Map<String, String> params = {};
    params.addAll({'latitude': latitude.toString(), 'longitude': longitude.toString()});
    return params;
  }

/* Http Parsing */

  static TokenModel parseToken(String response) {
    dynamic json = jsonDecode(response);
    return TokenModel.fromJson(json);
  }

  static DistanceModel parseDistance(String response) {
    dynamic json = jsonDecode(response);
    return DistanceModel.fromJson(json);
  }
}
