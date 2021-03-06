import 'package:dartz/dartz.dart';
import 'package:domo_server/src/data/model/service_model.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/future_response/future_response.dart';
import '../../domain/repository/repository_domain.dart';
import '../datasource/data_source_data.dart';

class ServiceRepositoryImpl implements ServiceRepositoryDomanin {
  final ServiceRemoteDataSource serviceRemoteDataSource;

  ServiceRepositoryImpl({required this.serviceRemoteDataSource});
  @override
  Future<Either<Failure, bool>> createService({
    required Map<String, dynamic> data,
    required List<String> file,
  }) async {
    return response(() async {
      return await serviceRemoteDataSource.createService(
        data: data,
        file: file,
      );
    });
  }

  @override
  Future<Either<Failure, List>> getAllService() async {
    return response(() async {
      return await serviceRemoteDataSource.getAllService();
    });
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getServiceById(
      {required String id}) {
    return response(() async {
      return await serviceRemoteDataSource.getServiceById(id: id);
    });
  }
}
