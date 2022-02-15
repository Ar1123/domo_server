import 'package:domo_server/src/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/utils/future_response/future_response.dart';
import 'package:domo_server/src/data/datasource/data_source_data.dart';
import 'package:domo_server/src/data/model/category_service_model.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class CategoryServiceRepositoryImpl implements CategoryServiceRepositoryDomain{
  final CategoryServiceRemoteDataSource categoryServiceRemoteDataSource;

  CategoryServiceRepositoryImpl({required this.categoryServiceRemoteDataSource});
  @override
  Future<Either<Failure, List<CategoryServiceModel>>> getCategoryservice() async{
        return response(()async{
          return await categoryServiceRemoteDataSource.getCategoryservice();
        });
  }
}