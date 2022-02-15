import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../entities/category_service_entities.dart';
import '../repository/repository_domain.dart';

class CategoryServiceUseCase {
  final CategoryServiceRepositoryDomain categoryServiceRepositoryDomain;

  CategoryServiceUseCase({
    required this.categoryServiceRepositoryDomain,
  });

  Future<Either<Failure, List<CategoryServiceEntities>>> getCategoryservice() =>
      categoryServiceRepositoryDomain.getCategoryservice();
}
