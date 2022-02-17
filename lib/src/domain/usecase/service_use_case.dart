import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/service_entities.dart';

import '../repository/repository_domain.dart';

class ServiceUseCase {
  final ServiceRepositoryDomanin serviceRepositoryDomanin;

  ServiceUseCase({required this.serviceRepositoryDomanin});


  Future<Either<Failure, List<ServiceEntities>>> getServiceById({required Map<String, dynamic> data}) =>
      serviceRepositoryDomanin.getServiceById(data: data);
  
}
