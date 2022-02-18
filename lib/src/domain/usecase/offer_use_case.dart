import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class OfferUseCase {


  final OfferRepositoryDomain offerRepositoryDomain;

  OfferUseCase({required this.offerRepositoryDomain});

  Future<Either<Failure, bool>> createOffer({required Map<String, dynamic> data, required String id})=>offerRepositoryDomain.createOffer(data: data, id: id);
  Future<Either<Failure, dynamic>> getOfferById({ required String id})=>offerRepositoryDomain.getOfferById(id: id);
}