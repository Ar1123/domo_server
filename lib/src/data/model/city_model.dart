// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

import 'package:domo_server/src/domain/entities/city_entities.dart';

List<CityModel> cityFromJson(String str) =>
    List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel extends CityEntities {
  const CityModel({
    int? id,
    String? departamento,
    String? city,
  }) : super(
          departamento: departamento,
          id: id,
          city: city,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: (json["id"] == null) ? '' : json["id"],
        city: (json["city"] == null) ? '' : json["dity"],
        departamento:
            (json["departamento"] == null) ? '' : json["departamento"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departamento": departamento,
        "ciudades": List<dynamic>.from(ciudades!.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final cityLocalModel = cityLocalModelFromJson(jsonString);

