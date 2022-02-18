import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/errors/execptions.dart';
import '../../model/offer_model.dart';

abstract class OfferRemoteDataSource {
  Future<bool> createOffer(
      {required Map<String, dynamic> data, required String id});
  Future<List<OfferModel>> getAllOfferById({required String id});
  Future<OfferModel> getOfferById(
      {required String idUser, required String idService});
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
  Future<List<OfferModel>> getAllOfferById({required String id}) async {
    try {
      List<OfferModel> list = [];
      final result = await _reference.where("owner", isEqualTo: id).get();
      list = result.docs
          .map((e) => OfferModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return list;
    } catch (e) {
      throw ServerExceptions();
    }
  }

  @override
  Future<OfferModel> getOfferById(
      {required String idUser, required String idService}) async {
    try {
      OfferModel offerModel = OfferModel();
      log(idService);
      log(idUser);
      final result = await _reference
          .where("owner", isEqualTo: idUser)
          .where("idService", isEqualTo: idService)
          .get();

      if (result.docs.isNotEmpty) {
        offerModel =
            OfferModel.fromJson(result.docs[0].data() as Map<String, dynamic>);
      }

      return offerModel;
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }
}
