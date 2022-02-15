import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/future_response/future_response.dart';
import '../../domain/entities/city_entities.dart';
import '../../domain/repository/repository_domain.dart';
import '../datasource/data_source_data.dart';



class RemoteCityRepositoryImpl implements RemoteCityRepoDomain{

  final CityRemote cityRemote;

  RemoteCityRepositoryImpl(this.cityRemote);
  @override
  Future<Either<Failure, List<CityEntities>>> getAllCity() {
  return response(()async{
    return await cityRemote.getCity();
  });
  }
}