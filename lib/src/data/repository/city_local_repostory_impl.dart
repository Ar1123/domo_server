import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/future_response/future_response.dart';
import '../../domain/repository/local_city_repository.dart';
import '../datasource/data_source_data.dart';
import '../model/city_model.dart';

class CityRepositoryLocalImpl extends LocalCityRepositoryDomain{

  final CityLocalDataSource cityLocalDataSource;

  CityRepositoryLocalImpl(this.cityLocalDataSource);
  @override
  Future<Either<Failure, int>> createTable({required Map<String, dynamic> data}) async{
    return  responseCache(()async{
      return await cityLocalDataSource.createTable(data: data);
    });
  }

  @override
  Future<Either<Failure, List>> getAllData({required Map<String, dynamic> data})async {
      return responseCache(()async{
        return await cityLocalDataSource.getAllData(data: data);
      });
  }

  @override
  Future<Either<Failure, List<CityModel>>> getDataById({required Map<String, dynamic> data}) {
     return  responseCache(()async{
       return await cityLocalDataSource.getDataById(data: data);
     });
  }

  @override
  Future<Either<Failure, int>> updateTable({required Map<String, dynamic> data}) {
      return responseCache(()async{
        return await cityLocalDataSource.updateTable(data: data);
      });
  }
}