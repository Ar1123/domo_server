import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domo_server/src/core/errors/execptions.dart';
import 'package:domo_server/src/data/model/category_service_model.dart';

abstract class CategoryServiceRemoteDataSource {
  Future<List<CategoryServiceModel>> getCategoryservice();
}

class CategoryServiceRemoteDataSourceImpl
    implements CategoryServiceRemoteDataSource {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('category');
  @override
  Future<List<CategoryServiceModel>> getCategoryservice() async {
    try {
       List<CategoryServiceModel> list =[];
        final result = await _collectionReference.get();

        list  = result.docs.map((e) => CategoryServiceModel.fromJson(e.data() as Map<String, dynamic>)).toList();
        log(jsonEncode(result.docs[0].data()));
        return list;

    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }
}
