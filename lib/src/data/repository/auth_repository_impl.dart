import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/future_response/future_response.dart';
import '../../domain/repository/repository_domain.dart';
import '../datasource/data_source_data.dart';

class AuthRepositoryImpl implements AuthRepositoryDomain{
final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, void>> logOut() async{
    return response(()async{

      return await authRemoteDataSource.logOut();
    });
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithPhone({required PhoneAuthCredential phoneAuthCredential}) async{
   return response(()async{

      return await authRemoteDataSource.signInWithPhone(phoneAuthCredential: phoneAuthCredential);
    });
  }

  @override
  Future<Either<Failure, bool>> verifySession()async {
   return response(()async{

      return await authRemoteDataSource.verifySession();
    });
  }

  @override
  Future<Either<Failure, String>> getUserId() async{
    return response(()async{
      return await authRemoteDataSource.getUserId();
    });
  }
}