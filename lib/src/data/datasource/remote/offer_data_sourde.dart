import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domo_server/src/core/errors/execptions.dart';

abstract class OfferRemoteDataSource {
  Future<bool> createOffer(
      {required Map<String, dynamic> data, required String id});
  Future<dynamic> getOfferById({required String id});
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('offer');
  @override
  Future<bool> createOffer(
      {required Map<String, dynamic> data, required String id}) async {
    try {
      await _reference.doc(id).set(data);
      return true;
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }

  @override
  Future<dynamic> getOfferById({required String id}) async {
    try {
      final result = await _reference.where("owner", isEqualTo: id).get();

      log(jsonEncode(result.docs[0].data()));

      return [];
    } catch (e) {
      throw ServerExceptions();
    }
  }
}
