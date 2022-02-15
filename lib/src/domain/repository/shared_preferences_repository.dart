import 'package:dartz/dartz.dart';
import 'package:domo_server/src/core/errors/failures.dart';

abstract class SharedPreferencesRepositoryDomain{

/*
  Para obtener los valores que se almacenen de acuerdo al tipo de dato y su llave
  en el almacenamiento local con las sharedPrefences.

*/
  Future<Either<Failure,String>> getKeyString({required String key});
  Future<Either<Failure,double>> getKeyDouble({required String key});
  Future<Either<Failure,int>> getKeyInt({required String key});
  Future<Either<Failure,bool>> getKeyBool({required String key});
  Future<Either<Failure,List<String>>> getKeyListString({required String key});
  Future<Either<Failure,void>> clearPreferences(String key);
  Future<Either<Failure,void>> clearAllPreferencec();
/*
  Para guardar en el almacenamiento local con sharedPreferences, con una llave y su tipo de dato
*/

Future<Either<Failure,bool>> setKeyString({required String key, required String value});
Future<Either<Failure,bool>> setKeyDouble({required String key, required double value});
Future<Either<Failure,bool>> setKeyInt({required String key, required int value});
Future<Either<Failure,bool>> setKeyListString({required String key, required List<String> value});
Future<Either<Failure,bool>> setKeyBool({required String key, required bool value});


}