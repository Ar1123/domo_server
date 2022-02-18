import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/offer_entities.dart';
import '../repository/repository_domain.dart';

class OfferUseCase {


  final OfferRepositoryDomain offerRepositoryDomain;

  OfferUseCase({required this.offerRepositoryDomain});

  Future<Either<Failure, bool>> createOffer({required Map<String, dynamic> data, required String id})=>offerRepositoryDomain.createOffer(data: data, id: id);
  Future<Either<Failure, List<OfferEntities>>> getAllOfferById({ required String id})=>offerRepositoryDomain.getAllOfferById(id: id);
  Future<Either<Failure, OfferEntities>> getOfferById({ required String idUser, required idService})=>offerRepositoryDomain.getOfferById(idUser: idUser, idService:idService );
}