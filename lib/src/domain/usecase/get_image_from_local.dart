import 'package:domo_server/src/domain/repository/repository_domain.dart';


class GetImageFromLocalUseCase
{


  final GetImageFromLocalRepositoryDomain getImageCameraRepoD;

  GetImageFromLocalUseCase(this.getImageCameraRepoD);

  Future<String> getimageFromLocal({required int type}) => getImageCameraRepoD.getimageFromLocal(type:type);
}