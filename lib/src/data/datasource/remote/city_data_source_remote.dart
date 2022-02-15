import 'dart:convert';

import '../../../core/api/http.dart';
import '../../../core/errors/execptions.dart';
import '../../model/city_model.dart';


abstract class CityRemote {
  Future<List<CityModel>> getCity();
}

class CityRemoteImpl implements CityRemote {
  final RequestHTTP requestHTTP = RequestHTTP();
  @override
  Future<List<CityModel>> getCity() async {
    List<CityModel> list = [];
    try {
      final result = await requestHTTP.getById(
          url:
              'https://raw.githubusercontent.com/marcovega/colombia-json/master/colombia.min.json');
      final jsonDecodeData = jsonDecode(result);

      for (var i = 0; i < jsonDecodeData.length; i++) {
        for (var j = 0; j < jsonDecodeData[i]['ciudades'].length; j++) {
          list.add(CityModel(
              city:  jsonDecodeData[i]['ciudades'][j],
              departamento: jsonDecodeData[i]['departamento'],
              id:0));
        }
      }

      return list;
    } catch (e) {
      Future.error('Error al obtener ciudades $e');
      throw ServerExceptions();
    }
  }
}
