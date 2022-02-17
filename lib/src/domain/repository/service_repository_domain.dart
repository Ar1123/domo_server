import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/service_entities.dart';

abstract class ServiceRepositoryDomanin{

  Future<Either<Failure, List<ServiceEntities>>> getServiceById({required Map<String, dynamic> data});
}