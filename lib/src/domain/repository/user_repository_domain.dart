import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/entities/user_entities.dart';

abstract class UserRepositoryDomain{


  Future<Either<Failure, bool>> createUser({required Map<String, dynamic> data});
  Future<Either<Failure, bool>> updateUser({required Map<String, dynamic> data, required String id});
  Future<Either<Failure, UserEntities>>  getUser({required String id});
} 