// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

import 'package:domo_server/src/domain/entities/offer_entities.dart';

OfferModel offerModelFromJson(String str) =>
    OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel extends OfferEntities {
  OfferModel({
    String? owner,
    bool? acept,
    Service? service,
    String? price,
    String? client,
    bool? status,
  }) : super(
          acept: acept,
          client: client,
          owner: owner,
          price: price,
          service: service,
          status: status,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        owner: json["owner"],
        acept: json["acept"],
        service: Service.fromJson(json["service"]),
        price: json["price"],
        client: json["client"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "acept": acept,
        "service": service,
        "price": price,
        "client": client,
        "status": status,
      };
}

class Service extends ServiceOffer {
  Service({
    String? date,
    List<String>? imagesevice,
    String? uid,
    String? hour,
    String? city,
    String? description,
    String? id,
    String? category,
    String? dep,
  }) : super(
          category: category,
          city: city,
          date: date,
          dep: dep,
          description: description,
          hour: hour,
          id: id,
          imagesevice: imagesevice,
          uid: uid,
        );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        date: json["date"],
        imagesevice: List<String>.from(json["imagesevice"].map((x) => x)),
        uid: json["uid"],
        hour: json["hour"],
        city: json["city"],
        description: json["description"],
        id: json["id"],
        category: json["category"],
        dep: json["dep"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "imagesevice": List<dynamic>.from(imagesevice!.map((x) => x)),
        "uid": uid,
        "hour": hour,
        "city": city,
        "description": description,
        "id": id,
        "category": category,
        "dep": dep,
      };
}