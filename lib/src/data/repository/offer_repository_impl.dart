import 'package:domo_server/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/utils/future_response/future_response.dart';
import 'package:domo_server/src/data/datasource/data_source_data.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class OfferRepositoryImpl implements OfferRepositoryDomain {
  final OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl({required this.offerRemoteDataSource});
  @override
  Future<Either<Failure, bool>> createOffer(
      {required Map<String, dynamic> data, required String id}) async {
    return response(() async {
      return await offerRemoteDataSource.createOffer(data: data, id: id);
    });
  }

  @override
  Future<Either<Failure, dynamic>> getOfferById({required String id}) async {
    return response(() async {
      return await offerRemoteDataSource.getOfferById(id: id);
    });
  }
}
