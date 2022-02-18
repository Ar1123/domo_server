import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/offer_entities.dart';

abstract class OfferRepositoryDomain{

  Future<Either<Failure, bool>> createOffer({required Map<String, dynamic> data, required String id});
  Future<Either<Failure, List<OfferEntities>>> getAllOfferById({required String id});
  Future<Either<Failure, OfferEntities>> getOfferById({required String idUser, required String idService});
}