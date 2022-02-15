import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';

import '../entities/city_entities.dart';
import '../repository/repository_domain.dart';


class LocalCityUseCase {
  final LocalCityRepositoryDomain localCityRepositoryDomain;

  LocalCityUseCase(this.localCityRepositoryDomain);

  Future<Either<Failure, int>> create({required Map<String, dynamic> data}) =>
      localCityRepositoryDomain.createTable(data: data);
  Future<Either<Failure, List<dynamic>>> getAll(
          {required Map<String, dynamic> data}) =>
      localCityRepositoryDomain.getAllData(data: data);

  Future<Either<Failure, List<CityEntities>>> getById(
          {required Map<String, dynamic> data}) =>
      localCityRepositoryDomain.getDataById(data: data);

        Future<Either<Failure, int>> update({required Map<String, dynamic> data}) 
  => localCityRepositoryDomain.updateTable(data: data);
}
