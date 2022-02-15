import 'package:firebase_auth/firebase_auth.dart';

import '../../../../injector.dart';
import '../../../core/errors/execptions.dart';
import '../../../domain/usecase/use_case_domain.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithPhone(
      {required PhoneAuthCredential phoneAuthCredential});
  Future<bool> verifySession();
  Future<void> logOut();
  Future<String> getUserId();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  User? user;

  final sharedPreferences = locator<SharedPrefencesUseCase>();

  AuthRemoteDataSourceImpl({required this.auth});

  @override
  Future<void> logOut() async{
     try {
      await auth.signOut();
    } catch (e) {
      Future.error('Error al cerrar sesión $e');
      throw ServerExceptions();
    }
  }

  @override
  Future<UserCredential> signInWithPhone(
      {required PhoneAuthCredential phoneAuthCredential}) async{
     try {
      final result = await auth.signInWithCredential(phoneAuthCredential);

      if (result.user != null) {
             await sharedPreferences.setKeyString(
            key: 'uid', value: result.user!.uid);
        return result;
      }

      throw ServerExceptions();
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> verifySession() async {
    bool status = false;

    try {
      user = auth.currentUser;
      if (user != null) {
        status = true;
      }
      return status;
    } catch (e) {
      Future.error('Error al verificar sesión $e');
      status = false;
      throw ServerExceptions(message: '');
    }
  }

  @override
  Future<String> getUserId() async{
    String id = ""; 
    try {
      user = auth.currentUser;
      if (user != null) {
        id = user!.uid;
      }
      return id;
    } catch (e) {
      Future.error('Error al verificar sesión $e');
      throw ServerExceptions(message: '');
    }
  }
}
