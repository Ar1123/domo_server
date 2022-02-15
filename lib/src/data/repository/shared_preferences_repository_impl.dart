import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/future_response/future_response.dart';
import '../../domain/repository/repository_domain.dart';
import '../datasource/data_source_data.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepositoryDomain{
 final SharedPreferencesLocalDataSource sharedPreferencesLocalDataSource;

  SharedPreferencesRepositoryImpl({required this.sharedPreferencesLocalDataSource});
  @override
  Future<Either<Failure, void>> clearAllPreferencec() async{
      return responseCache(()async{
        return await sharedPreferencesLocalDataSource.clearAllPreferencec();
      });

  }

  @override
  Future<Either<Failure, void>> clearPreferences(String key) async{
  return responseCache(()async{
        return await sharedPreferencesLocalDataSource.clearPreferences(key);
      });
  }

  @override
  Future<Either<Failure, bool>> getKeyBool({required String key})async {
  return responseCache(()async{
        return await sharedPreferencesLocalDataSource.getKeyBool(key: key);
      });
  }

  @override
  Future<Either<Failure, double>> getKeyDouble({required String key})async {
     return responseCache(()async{
        return await sharedPreferencesLocalDataSource.getKeyDouble(key: key);
      });
  }

  @override
  Future<Either<Failure, int>> getKeyInt({required String key}) async{
    return responseCache(()async{
        return await sharedPreferencesLocalDataSource.getKeyInt(key: key);
      });
  }

  @override
  Future<Either<Failure, List<String>>> getKeyListString({required String key})async {
  return responseCache(()async{
        return await sharedPreferencesLocalDataSource.getKeyListString(key: key);
      });
  }

  @override
  Future<Either<Failure, String>> getKeyString({required String key})async {
     return responseCache(()async{
        return await sharedPreferencesLocalDataSource.getKeyString(key: key);
      });
  }

  @override
  Future<Either<Failure, bool>> setKeyBool({required String key, required bool value})async {
    return responseCache(()async{
        return await sharedPreferencesLocalDataSource.setKeyBool(key: key, value: value);
      });
  }

  @override
  Future<Either<Failure, bool>> setKeyDouble({required String key, required double value}) async{
      return responseCache(()async{
        return await sharedPreferencesLocalDataSource.setKeyDouble(key: key, value: value);
      });
  }

  @override
  Future<Either<Failure, bool>> setKeyInt({required String key, required int value})async {
      return responseCache(()async{
        return await sharedPreferencesLocalDataSource.setKeyInt(key: key, value: value);
      });
  }

  @override
  Future<Either<Failure, bool>> setKeyString({required String key, required String value})async {
    return responseCache(()async{
        return await sharedPreferencesLocalDataSource.setKeyString(key: key, value: value);
      });
  }

  @override
  Future<Either<Failure, bool>> setKeyListString({required String key, required List<String> value}) {
  return responseCache(()async{
        return await sharedPreferencesLocalDataSource.setKeyListString(key: key, value: value);
      });
  }

}