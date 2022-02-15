// To parse this JSON data, do
//
//     final CategoryServiceModel = CategoryServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:domo_server/src/domain/entities/category_service_entities.dart';

// ignore: non_constant_identifier_names
CategoryServiceModel CategoryServiceModelFromJson(String str) =>
    CategoryServiceModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String CategoryServiceModelToJson(CategoryServiceModel data) =>
    json.encode(data.toJson());

class CategoryServiceModel extends CategoryServiceEntities {
  const CategoryServiceModel({
    String? service,
    String? id,
  }):super(
    id: id, 
    service: service,
  );

  factory CategoryServiceModel.fromJson(Map<String, dynamic> json) =>
      CategoryServiceModel(
        service: json["service"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "id": id,
      };
}
