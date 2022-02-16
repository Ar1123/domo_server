// To parse this JSON data, do
//
//     final USerModel = USerModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:domo_server/src/domain/entities/user_entities.dart';

USerModel USerModelFromJson(String str) => USerModel.fromJson(json.decode(str));

String USerModelToJson(USerModel data) => json.encode(data.toJson());

class USerModel extends UserEntities {
  USerModel({
    bool? accountComplete,
    bool? active,
    String? uid,
    String? lastName,
    String? name,
    String? typeIde,
    String? ide,
    String? biography,
    String? phone,
    String? img,
    List<String>? labores,
    String? city,
    String? dep,
    String? experienceYear,
  }) : super(
            accountComplete: accountComplete,
            active: active,
            uid: uid,
            ide: ide,
            lastName: lastName,
            name: name,
            phone: phone,
            img: img,
            typeIde: typeIde,
            biography: biography,
            city: city,
            dep: dep,
            experienceYear: experienceYear,
            labores: labores);

  factory USerModel.fromJson(Map<String, dynamic> json) => USerModel(
        accountComplete:
            (json["accountComplete"] == null) ? false : json["accountComplete"],
        active: (json["active"] == null) ? false : json["active"],
        uid: (json["uid"] == null) ? '' : json["uid"],
        name: (json["name"] == null) ? '' : json["name"],
        lastName: (json["lastName"] == null) ? '' : json["lastName"],
        phone: (json["phone"] == null) ? '' : json["phone"],
        typeIde: (json["typeIde"] == null) ? '' : json["typeIde"],
        ide: (json["ide"] == null) ? '' : json["ide"],
        img: (json["img"] == null) ? '' : json["img"],
        biography: (json["biography"] == null) ? '' : json["biography"],
        experienceYear:
            (json["experienceYear"] == null) ? '' : json["experienceYear"],
        city: (json["city"] == null) ? '' : json["city"],
        dep: (json["dep"] == null) ? '' : json["dep"],
        labores: (json["labores"] == null)
            ? []
            : List<String>.from(json["labores"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "accountComplete": accountComplete,
        "active": active,
        "name": name,
        "lastName": lastName,
        "typeIde": typeIde,
        "ide": ide,
        "phone": phone,
        "uid": uid,
        "img": img,
        "biography": biography,
        "labores": List<dynamic>.from(labores!.map((x) => x)),
      };
}
