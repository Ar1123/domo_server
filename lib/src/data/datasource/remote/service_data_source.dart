
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domo_server/src/core/errors/execptions.dart';
import 'package:domo_server/src/core/utils/upload_image.dart';
import 'package:domo_server/src/data/model/service_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ServiceRemoteDataSource {
  Future<bool> createService(
      {required Map<String, dynamic> data, required List<String> file});
  Future<List<ServiceModel>> getServiceById({required String id});
  Future<List<dynamic>> getAllService();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("service");
  @override
  Future<bool> createService(
      {required Map<String, dynamic> data, required List<String> file}) async {
    await _reference.doc(data["id"]).set(data);
    await uploadImage(
      image: XFile((file[0])),
      id: data['id'],
      nameCollectio: _reference,
      name: "imagesevice",
      path: "serviceImage${data["id"]}",
    );
    await uploadImage(
      image: XFile((file[1])),
      id: data['id'],
      nameCollectio: _reference,
      name: "imagesevice",
      path: "serviceImage${data["id"]}",
    );

    try {
      return true;
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }

  @override
  Future<List> getAllService() async {
    try {
      return [];
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }

  @override
  Future<List<ServiceModel>> getServiceById({required String id}) async {
    try {
      List<ServiceModel> list = [];
      final result = await _reference.where("uid", isEqualTo: id).get();

      list = result.docs
          .map((e) => ServiceModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw ServerExceptions();
    }
  }
}
