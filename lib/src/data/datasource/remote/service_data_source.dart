import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domo_server/src/core/errors/execptions.dart';
import 'package:domo_server/src/core/utils/upload_image.dart';
import 'package:domo_server/src/data/model/service_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServiceById(
      {required Map<String, dynamic> data});
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("service");

  @override
  Future<List<ServiceModel>> getServiceById(
      {required Map<String, dynamic> data}) async {
    try {
      List<ServiceModel> list = [];
      log("$data");
      final result = await _reference
          .where(
            "category",
            isEqualTo: data['category'],
          )
          .where("city", isEqualTo: data['city'])
          .get();

      list = result.docs
          .map((e) => ServiceModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }
}
