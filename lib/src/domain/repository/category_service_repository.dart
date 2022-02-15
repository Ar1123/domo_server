import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/category_service_entities.dart';

abstract class CategoryServiceRepositoryDomain{
  Future<Either<Failure, List<CategoryServiceEntities>>> getCategoryservice();
}


