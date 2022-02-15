
import 'dart:convert';

import 'package:domo_server/src/domain/entities/service_entities.dart';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel extends ServiceEntities {
  ServiceModel({
    String? date,
    List<String>? imagesevice,
    String? uid,
    String? hour,
    String? city,
    String? description,
    String? category,
    String? id,
    String? dep,
    bool? status,
    bool? finalizada,
  }):super(
    city: city, 
    date: date, 
    dep: dep, 
    description: description,
    finalizada: finalizada,
    hour: hour,
    id: id,
    imagesevice: imagesevice,
    status: status,
    uid: uid,
    category: category,
  

  );

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        date: json["date"],
        imagesevice: List<String>.from(json["imagesevice"].map((x) => x)),
        uid: json["uid"],
        hour: json["hour"],
        city: json["city"],
        description: json["description"],
        id: json["id"],
        dep: json["dep"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "imagesevice": List<dynamic>.from(imagesevice!.map((x) => x)),
        "uid": uid,
        "hour": hour,
        "city": city,
        "description": description,
        "id": id,
        "dep": dep,
        "category": category,
      };
}
