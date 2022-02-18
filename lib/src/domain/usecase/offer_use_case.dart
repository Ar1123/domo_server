import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/offer_entities.dart';
import '../repository/repository_domain.dart';

class OfferUseCase {


  final OfferRepositoryDomain offerRepositoryDomain;

  OfferUseCase({required this.offerRepositoryDomain});

  Future<Either<Failure, bool>> createOffer({required Map<String, dynamic> data, required String id})=>offerRepositoryDomain.createOffer(data: data, id: id);
  Future<Either<Failure, List<OfferEntities>>> getOfferById({ required String id})=>offerRepositoryDomain.getOfferById(id: id);
}