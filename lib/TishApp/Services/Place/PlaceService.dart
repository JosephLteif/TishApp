import 'dart:convert';
import 'dart:io';
import 'package:TishApp/TishApp/Services/httpInterceptor.dart';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class PlaceService {
  Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> getAll() async {
    dynamic responseJson;
    Client client = InterceptedClient.build(interceptors: [
      HttpInterceptor(),
    ]);
    try {
      final response = await client.get(Uri.parse(_baseUrl + '/Places'));
      print(response.statusCode);
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getOne(int id) async {
    dynamic responseJson;
    try {
      Client client = InterceptedClient.build(interceptors: [
        HttpInterceptor(),
      ]);
      final response = await client.get(Uri.parse(_baseUrl + '/Places/$id'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = (response.body);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }
}
