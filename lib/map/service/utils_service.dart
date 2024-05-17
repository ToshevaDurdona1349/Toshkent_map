import 'dart:math';

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);
}

Location calculateNewCoordinates(Location start, double distance, double bearing) {
  // Earth radius in kilometers
  const double earthRadius = 6371.0;

  // Convert distance from kilometers to radians
  double distanceRadians = distance / earthRadius;

  // Convert bearing from degrees to radians
  double bearingRadians = _degreesToRadians(bearing);

  // Convert latitudes and longitudes from degrees to radians
  double lat1Radians = _degreesToRadians(start.latitude);
  double lon1Radians = _degreesToRadians(start.longitude);

  // Calculate new latitude
  double lat2Radians = asin(sin(lat1Radians) * cos(distanceRadians) +
      cos(lat1Radians) * sin(distanceRadians) * cos(bearingRadians));

  // Calculate new longitude
  double lon2Radians = lon1Radians +
      atan2(sin(bearingRadians) * sin(distanceRadians) * cos(lat1Radians),
          cos(distanceRadians) - sin(lat1Radians) * sin(lat2Radians));

  // Convert back from radians to degrees
  double newLat = _radiansToDegrees(lat2Radians);
  double newLon = _radiansToDegrees(lon2Radians);

  return Location(newLat, newLon);
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}

double _radiansToDegrees(double radians) {
  return radians * 180.0 / pi;
}