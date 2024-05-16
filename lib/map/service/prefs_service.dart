import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const _accessTokenKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE2MDcyNjU5LCJpYXQiOjE3MTU4NTY2NTksImp0aSI6ImY1ZjYzNmQ5YTdlOTQ4ZDdiMTVjN2IwNzVhMzU5NjU5IiwidXNlcl9pZCI6M30.baeIEZGqM_Y7bifus8ImEndwy0TDMbPXmzHcmUGocjU';
  static const _refreshTokenKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxODQ0ODY1OSwiaWF0IjoxNzE1ODU2NjU5LCJqdGkiOiI2NDIxMGI3ZTZjN2Q0Mjk5YmQyZWNlZjY1YzJlNDRjYyIsInVzZXJfaWQiOjN9.KWe549QWFII3YcKGkNFqQsSZIv_ta2WHdYvGIjCqVBA';

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}