// To parse this JSON data, do
//
//     final distanceModel = distanceModelFromJson(jsonString);

import 'dart:convert';

DistanceModel distanceModelFromJson(String str) => DistanceModel.fromJson(json.decode(str));

String distanceModelToJson(DistanceModel data) => json.encode(data.toJson());

class DistanceModel {
  double message;
  int status;

  DistanceModel({
    required this.message,
    required this.status,
  });

  factory DistanceModel.fromJson(Map<String, dynamic> json) => DistanceModel(
    message: json["message"]?.toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
