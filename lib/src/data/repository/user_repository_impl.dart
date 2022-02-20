import 'package:cross_file/src/types/interface.dart';
import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/core/utils/future_response/future_response.dart';
import 'package:domo_server/src/data/datasource/data_source_data.dart';
import 'package:domo_server/src/data/model/user_model.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class UserRepositoryImpl implements UserRepositoryDomain {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, bool>> createUser(
      {required Map<String, dynamic> data}) async {
    return response(() async {
      return await userRemoteDataSource.createUser(data: data);
    });
  }

  @override
  Future<Either<Failure, USerModel>> getUser({required String id}) async {
    return response(() async {
      return await userRemoteDataSource.get(id: id);
    });
  }

  @override
  Future<Either<Failure, bool>> updateUser(
      {required Map<String, dynamic> data, required String id}) async {
    return response(() async {
      return await userRemoteDataSource.update(data: data, id: id);
    });
  }

  @override
  Future<Either<Failure, bool>> addImage({required String file, required String id}) async{
    return response(()async{
      return await userRemoteDataSource.addImage(file: file, id: id);
    });
  }

  @override
  Future<Either<Failure, String>> getToken({required String id}) async{

    return response(()async{
     return await userRemoteDataSource.getToken(id: id);
    });
  }
}
