
import 'dart:developer';

import 'package:domo_server/src/core/api/sqflite.dart';
import 'package:domo_server/src/core/errors/execptions.dart';
import 'package:domo_server/src/data/model/city_model.dart';


abstract class CityLocalDataSource {
  Future<int> createTable({required Map<String, dynamic> data});
  Future<int> updateTable({required Map<String, dynamic> data});
  Future<List<CityModel>> getDataById(
      {required Map<String, dynamic> data});
  Future<List<dynamic>> getAllData({required Map<String, dynamic> data});
}

class CityLocalDataSourceImpl extends CityLocalDataSource {
  @override
  Future<int> createTable({required Map<String, dynamic> data}) async {
    try {
      final result = await Sqflite.db.insert(data: data, table: "City");
      return result;
    } catch (e) {

      log('Errro $e', name: 'Error');
      throw CacheExceptions();
    }
  }

  @override
  Future<List> getAllData({required Map<String, dynamic> data}) async {
    final result = await Sqflite.db.getAll(table: 'City');
    return [];
  }

  @override
  Future<List<CityModel>> getDataById(
      {required Map<String, dynamic> data}) async {
    List<CityModel> list = [];
    try {
      String sql = "SELECT * FROM City WHERE (city LIKE LOWER ('%"
          '${data['city']}'
          "%')) LIMIT 5";
      final result = await Sqflite.db.getById2(sql: sql);
      for (var element in result) {
        list.add(CityModel(
          city: element['city'],
          departamento: element['departamento'],
          id: int.parse(element['id'].toString()),
        ));
      }
      
      return list;
    } catch (e) {
      Future.error(e);
      throw CacheExceptions();
    }
  }

  @override
  Future<int> updateTable({required Map<String, dynamic> data}) async {
    try {
      return await Sqflite.db.updateData(
          args: [data['id']],
          params: "id = ?",
          table: 'City',
          data: data);
    }  catch (e) {
      throw CacheExceptions();
    }
  }
}
