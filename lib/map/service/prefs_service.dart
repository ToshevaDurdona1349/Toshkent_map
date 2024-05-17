
import 'package:shared_preferences/shared_preferences.dart';


class Prefs {

  static storeAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", accessToken);
  }

  static Future<String?> loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");
    return accessToken;
  }

  static storeRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh_token", refreshToken);
  }

  static Future<String?> loadRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString("refresh_token");
    return refreshToken;
  }
}