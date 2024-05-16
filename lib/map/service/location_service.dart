import 'package:geolocator/geolocator.dart';
import '../model/app_lat_long.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}
class LocationService implements AppLocation {
  final defLocation = const TashkentLocation();

//joriy geopazitsiyani aniqlash
  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }
// joylashuvni aniqlash xizmatidan foydalanishga ruxsat so'rash
  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
//foydalanuvchi qurilmaning joylashuviga kirishga ruxsat berganligini tekshiradi.
  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }


  Future<void> getDistance() async {
    final apiKey = 'Aa7274830.123456789-0123456789_0';
    final origin = 'Nurhayot';
    final destination = 'Los Angeles, CA';
    final mode = 'driving';
    final message = 5731.892253110097;
    final status =200;// or 'walking', 'bicycling', etc.

    final url = 'https://api.example.com/distance?'
        'origin=$origin&'
        'destination=$destination&'
        'mode=$mode&'
        'message=$message&'
        'status=$status&'
        'key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final distanceData = jsonDecode(response.body);
      final distance = distanceData['distance']; // Extract distance from response
      print('Distance: $distance');
    } else {
      print('Failed to get distance: ${response.statusCode}');
    }
  }
}
