import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/city_entities.dart';


abstract class LocalCityRepositoryDomain {
  Future<Either<Failure, int>> createTable( {required Map<String, dynamic> data});
  Future<Either<Failure, int>> updateTable({required Map<String, dynamic> data});
  Future<Either<Failure,  List<CityEntities>>> getDataById({required Map<String, dynamic> data});
  Future<Either<Failure, List<dynamic>>> getAllData({required Map<String, dynamic> data});
}