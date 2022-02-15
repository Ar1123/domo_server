import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthRepositoryDomain{
  Future<Either<Failure, UserCredential>> signInWithPhone({required PhoneAuthCredential phoneAuthCredential});
  Future<Either<Failure, bool>> verifySession();
  Future<Either<Failure, void>> logOut();
    Future<Either<Failure, String>> getUserId();


}