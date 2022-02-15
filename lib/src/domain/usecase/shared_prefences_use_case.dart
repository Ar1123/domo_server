import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class SharedPrefencesUseCase{

final SharedPreferencesRepositoryDomain sharedPreferencesRepositoryDomain;

  SharedPrefencesUseCase({required this.sharedPreferencesRepositoryDomain});
  Future<Either<Failure,String>> getKeyString({required String key})=>sharedPreferencesRepositoryDomain.getKeyString(key: key);
  Future<Either<Failure,double>> getKeyDouble({required String key})=>sharedPreferencesRepositoryDomain.getKeyDouble(key: key);
  Future<Either<Failure,int>> getKeyInt({required String key})=>sharedPreferencesRepositoryDomain.getKeyInt(key: key);
  Future<Either<Failure,bool>> getKeyBool({required String key})=>sharedPreferencesRepositoryDomain.getKeyBool(key: key);
  Future<Either<Failure,List<String>>> getKeyListString({required String key})=>sharedPreferencesRepositoryDomain.getKeyListString(key: key);
  Future<Either<Failure,void>> clearPreferences(String key)=>sharedPreferencesRepositoryDomain.clearPreferences(key);
  Future<Either<Failure,void>> clearAllPreferencec()=>sharedPreferencesRepositoryDomain.clearAllPreferencec();
/*
  Para guardar en el almacenamiento local con sharedPreferences, con una llave y su tipo de dato
*/

Future<Either<Failure,bool>> setKeyString({required String key, required String value})=>sharedPreferencesRepositoryDomain.setKeyString(key: key, value: value);
Future<Either<Failure,bool>> setKeyDouble({required String key, required double value})=>sharedPreferencesRepositoryDomain.setKeyDouble(key: key, value: value);
Future<Either<Failure,bool>> setKeyInt({required String key, required int value})=>sharedPreferencesRepositoryDomain.setKeyInt(key: key, value: value);
Future<Either<Failure,bool>> setKeyBool({required String key, required bool value})=>sharedPreferencesRepositoryDomain.setKeyBool(key: key, value: value);
Future<Either<Failure,bool>> setKeyListString({required String key, required List<String> value})=>sharedPreferencesRepositoryDomain.setKeyListString(key: key, value: value);


}