import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/city_entities.dart';

abstract class RemoteCityRepoDomain {
  Future<Either<Failure, List<CityEntities>>> getAllCity();
}
