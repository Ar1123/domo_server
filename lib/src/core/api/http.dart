import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:domo_server/src/core/errors/execptions.dart';




class RequestHTTP {
  RequestHTTP();
  final dio = Dio();
  Future<dynamic> getById({
    required String url,
    Map<String, dynamic>? paramns,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await dio.get(
        url,
        queryParameters: paramns,
        options: Options(headers: headers),
      );
      return result.data;
    } catch (e) {
      log('Error al obtener data por id $e');
      throw ServerExceptions();
    }
  }

  Future<dynamic> post(
    String url,
    FormData body,
    Map<String, dynamic> headers,
  ) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      return response.data;
    } catch (e) {
      log('Error al crear datos $e');
      throw ServerExceptions();
    }
  }

  Future<dynamic> path(
    String url,
    FormData data,
    Map<String, dynamic> headers,
  ) async {
    try {
      final response = await dio.patch(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      return response.data;
    } catch (e) {
      log('Error al crear datos $e');
      throw ServerExceptions();
    }
  }
}
