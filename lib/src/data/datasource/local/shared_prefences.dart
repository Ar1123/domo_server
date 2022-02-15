import 'package:domo_server/src/core/errors/execptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesLocalDataSource {
/*
  Para obtener los valores que se almacenen de acuerdo al tipo de dato y su llave
  en el almacenamiento local con las sharedPrefences.

*/
  Future<String> getKeyString({required String key});
  Future<double> getKeyDouble({required String key});
  Future<int> getKeyInt({required String key});
  Future<bool> getKeyBool({required String key});
  Future<List<String>> getKeyListString({required String key});
  Future<void> clearPreferences(String key);
  Future<void> clearAllPreferencec();
/*
  Para guardar en el almacenamiento local con sharedPreferences, con una llave y su tipo de dato
*/

  Future<bool> setKeyString({required String key, required String value});
  Future<bool> setKeyDouble({required String key, required double value});
  Future<bool> setKeyInt({required String key, required int value});
  Future<bool> setKeyBool({required String key, required bool value});
  Future<bool> setKeyListString(
      {required String key, required List<String> value});
}

class SharedPreferencesLocalDataSourceImpl
    implements SharedPreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SharedPreferencesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getKeyBool({required String key}) async {
    bool status = false;
    try {
      status = sharedPreferences.getBool(key) ?? false;
    return status;
    } catch (e) {
      Future.error('Error al obteer ener datov$e');
      throw CacheExceptions();
   
    }

  }

  @override
  Future<double> getKeyDouble({required String key}) async {
    double number = 0;
    try {
      number = sharedPreferences.getDouble(key)!;
      return number;
    } catch (e) {
      Future.error('Error al obtener datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<int> getKeyInt({required String key}) async {
    int number = 0;
    try {
      number = sharedPreferences.getInt(key)!;
      return number;
    } catch (e) {
      Future.error('Error al obtener datos $e');
      throw CacheExceptions();
    }
    
  }

  @override
  Future<List<String>> getKeyListString({required String key}) async {
    List<String> list = [];
    try {
      list = (sharedPreferences.getStringList(key))!;
      return list;
    } catch (e) {
      Future.error('Error al obtener datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<String> getKeyString({required String key}) async {
    String value = "";
    try {
      value = (sharedPreferences.getString(key))!;
      return value;
    } catch (e) {
      Future.error('Error al obtener datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<bool> setKeyBool({required String key, required bool value}) async {
    try {
      sharedPreferences.setBool(key, value);
      return true;
    } catch (e) {
      Future.error('Error al guardar datos $e');

      throw CacheExceptions();
    }
  }

  @override
  Future<bool> setKeyDouble(
      {required String key, required double value}) async {
    try {
      sharedPreferences.setDouble(key, value);
      return true;
    } catch (e) {
      Future.error('Error al guardar datos $e');

      throw CacheExceptions();
    }
  }

  @override
  Future<bool> setKeyInt({required String key, required int value}) async {
    try {
     await sharedPreferences.setInt(key, value);
      return true;
    } catch (e) {
      Future.error('Error al guardar datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<bool> setKeyListString(
      {required String key, required List<String> value}) async {
    try {
   await    sharedPreferences.setStringList(key, value);
      return true;
    } catch (e) {
      Future.error('Error al guardar datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<bool> setKeyString(
      {required String key, required String value}) async {
    try {
      sharedPreferences.setString(key, value);
      return true;
    } catch (e) {
      Future.error('Error al guardar datos $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<void> clearPreferences(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      Future.error('Error al eliminar preferencias $e');
      throw CacheExceptions();
    }
  }

  @override
  Future<void> clearAllPreferencec() async {
    try {
      await sharedPreferences.clear();
    } catch (e) {
      Future.error('Error al eliminar preferencias $e');
      throw CacheExceptions();
    }
  }
}
