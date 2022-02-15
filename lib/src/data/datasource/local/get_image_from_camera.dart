import 'package:image_picker/image_picker.dart';

abstract class GetImageFromCameraLocal {
  Future<String> getimageFromLocal({required int type});
}

class GetImageFromCameraLocalimpl extends GetImageFromCameraLocal {
  @override
  Future<String> getimageFromLocal({required int type}) async {
    String img = "";
    XFile? photo;
    final ImagePicker _picker = ImagePicker();
    try {
      if (type == 1) {
        photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          img = photo.path;
        }
      } else if (type == 2) {
        photo = await _picker.pickImage(source: ImageSource.gallery);
        if (photo != null) {
          img = photo.path;
        }
      }
    } catch (e) {
      Future.error('Error al obtener imagen $e');
      img = "";
    }

    return img;
  }
}
