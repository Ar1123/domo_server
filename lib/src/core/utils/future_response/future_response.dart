import 'package:dartz/dartz.dart';

import '../../errors/execptions.dart';
import '../../errors/failures.dart';

Future<Either<Failure, T>> response<T>(Function() funtion) async {
  try {
    final result = await funtion();
    return Right(result);
  } on ServerExceptions catch (e) {
    return Left(ServerFailure(message: e.message));
  }
}

Future<Either<Failure, T>> responseCache<T>(Function() funtion) async {
  try {
    final result = await funtion();
    return Right(result);
  } on CacheExceptions catch (e) {
    return Left(CacheFailure(message: e.message));
  }
}
