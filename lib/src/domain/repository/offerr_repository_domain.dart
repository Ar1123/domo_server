import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';

abstract class OfferRepositoryDomain{

  Future<Either<Failure, bool>> createOffer({required Map<String, dynamic> data, required String id});
  Future<Either<Failure, dynamic>> getOfferById({required String id});
}