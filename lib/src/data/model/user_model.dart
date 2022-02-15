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
    String? phone,
  }) : super(
          accountComplete: accountComplete,
          active: active,
          uid: uid,
          ide: ide,
          lastName: lastName,
          name: name,
          phone: phone,
          typeIde: typeIde,
        );

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
      };
}
