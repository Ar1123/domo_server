import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:image_picker/image_picker.dart';

import '../errors/execptions.dart';

Future<bool> uploadImage({
  required XFile image,
  required String id,
  required CollectionReference nameCollectio,
  required String name,
  required String path,
}) async {
  storage.UploadTask? task;
  try {
    storage.FirebaseStorage storageF = storage.FirebaseStorage.instance;
    storage.Reference ref = storageF.ref().child('$id/$path').child(image.name);
    task = ref.putFile(File(image.path));
    final result = await task.whenComplete(() async {
      await ref.getDownloadURL().then((value) async {
        await nameCollectio.doc(id).set(
            {
              name:value,
            },
            SetOptions(
              merge: true,
            ));
      });
    });
    return (result.ref.fullPath.isNotEmpty) ? true : false;
  } on FirebaseException catch (e) {
    Future.error('Error cargando  imagenes  $e');
    throw ServerExceptions();
  }
}
