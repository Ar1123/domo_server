import '../../domain/repository/repository_domain.dart';
import '../datasource/data_source_data.dart';

class GetimageFromCameraRepoImpl extends GetImageFromLocalRepositoryDomain{

  final GetImageFromCameraLocal getImageFromCameraLocal;

  GetimageFromCameraRepoImpl(this.getImageFromCameraLocal);

  @override
  Future<String> getimageFromLocal({required int type})=> getImageFromCameraLocal.getimageFromLocal(type: type);
 
}