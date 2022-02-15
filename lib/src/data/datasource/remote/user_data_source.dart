import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/errors/execptions.dart';
import '../../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<bool> createUser({required Map<String, dynamic> data});
  Future<bool> update({required Map<String, dynamic> data, required String id});
  Future<USerModel> get({required String id});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('server');
  @override
  Future<bool> createUser({required Map<String, dynamic> data}) async {
    log("ssssssssss");
    try {
      await _reference.doc("${data['uid']}").set(data);

      return true;
    } on FirebaseException catch (e) {
      log('Error al crear usuario $e');
      throw ServerExceptions();
    }
  }

  @override
  Future<USerModel> get({required String id}) async {
    try {
      USerModel uSerModel = USerModel();
      final user = await _reference.doc(id).get();
      if (user.exists) {
        uSerModel = USerModel.fromJson(user.data() as Map<String, dynamic>);
      }else{
        uSerModel = USerModel.fromJson({});
      }
      return uSerModel;
    } on FirebaseException catch (e) {
      log('Error al obtener usuario $e');
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> update(
      {required Map<String, dynamic> data, required String id}) async {
    try {
      await _reference.doc(id).update(data);
      return true;
    } on FirebaseException catch (e) {
      log('Error al actualizar usuario $e');

      throw ServerExceptions();
    }
  }
}
