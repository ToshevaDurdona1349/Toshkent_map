import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../model/distance_model.dart';
import '../model/token_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';
import '../service/prefs_service.dart';
import '../service/utils_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    _apiGetToken();
  }

  _apiGetToken() async {
    var response = await Network.POST(Network.API_TOKEN, Network.paramsToken());
    TokenModel tokenModel = Network.parseToken(response!);
    LogService.i(tokenModel.access);
    LogService.i(tokenModel.refresh);

    Prefs.storeAccessToken(tokenModel.access);
    Prefs.storeRefreshToken(tokenModel.refresh);
  }

  _apiGetDistance() async {
    Location firstLocation = Location(41.2615, 69.2177);

    var response = await Network.POST(Network.API_DISTANCE, Network.paramsDistance(firstLocation.latitude, firstLocation.longitude));
    DistanceModel distanceModel = Network.parseDistance(response!);
    LogService.i(distanceModel.message.toString());

    double distance = distanceModel.message;
    Location secondLocation = calculateNewCoordinates(firstLocation, distance, 90);
    LogService.i("New location latitude: ${secondLocation.latitude}");
    LogService.i("New location longitude: ${secondLocation.longitude}");

    _moveToNewLocation(secondLocation);
  }

  Future<void> _moveToNewLocation(Location location) async {
    (await mapControllerCompleter.future).moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
          zoom: 13,
        ),
      ),
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 4),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apiGetDistance();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.data_saver_on),
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) {
              mapControllerCompleter.complete(controller);
            },
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Icon(
              Icons.location_on,
              size: 40,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}