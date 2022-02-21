import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/execptions.dart';
import '../../model/service_model.dart';

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
          .where("city", isEqualTo: data['city']).
          where("status", isEqualTo: true)
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
