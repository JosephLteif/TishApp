import 'dart:convert';

import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:TishApp/TishApp/Settings/DioSettings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class PlaceService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> getAll() async {
    var responseJson;
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio.get((_baseUrl + '/Places'));
      responseJson = returnResponse(response);
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getOne(int id) async {
    dynamic responseJson;
    try {
      Dio dio = await DioSettings.getDio();
      final response = await dio.get((_baseUrl + '/Places/$id'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<String> getOneImage(String bucketName, String imageName) async {
    dynamic responseJson;
    try {
      Dio dio = await DioSettings.getDio();
      final response =
          await dio.get((_baseUrl + '/Places/$bucketName/$imageName'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson.toString();
  }

  Future<dynamic> getByType(String type) async {
    dynamic responseJson;
    try {
      Dio dio = await DioSettings.getDio();
      final response = await dio.get((_baseUrl + '/Places/Type/$type'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = (response.data);
        return responseJson;
      case 400:
        throw Exception(response.data.toString());
      case 401:
      case 403:
        throw Exception(response.data.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
