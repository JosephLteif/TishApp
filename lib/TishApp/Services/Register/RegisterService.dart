import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../Settings/AppSettings.dart';

class RegisterService {
  Settings settings = Settings();

  Future<bool> registerService(
      String firstName, String lastName, String password, String email) async {
    dynamic responseJson, result;
    Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
    };
    try {
      final response = await dio.post((settings.login_url), 
      options: Options(headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }),
      data: {
        "client_secret": settings.client_secret_register,
        "grant_type": settings.grant_type_register,
        "client_id": settings.client_id_register
      });
      if(response.statusCode == 200 || response.statusCode == 201)
        responseJson = response.data;
      String accessToken = responseJson['access_token'];
      var temp = {
        "username": '$firstName',
        "enabled": 'true',
        "emailVerified": 'true',
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "credentials": [
          {"type": "password", "value": password, "temporary": "false"}
        ]
      };
      var data = (temp);
      final responseRegister = await dio.post((settings.Register_url),
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            "content-type": "application/json",
            "accept": "application/json",
          }),
          data: data);
      if(response.statusCode == 200 || response.statusCode == 201)
        result = responseRegister.data;

      temp = {
        "Username": '$firstName $lastName',
        "Email": email
      };
      data = (temp);
      final responseRegister2 =
          await dio.post((settings.save_User_In_DB_url),
          options: Options(
            headers: {
                'Authorization': 'Bearer $accessToken',
                "content-type": "application/json",
                "accept": "application/json",
              }
          ),
              data: data);
      print("Done");
    } on SocketException {
      print("ERROR");
      throw Exception('No Internet Connection');
    } catch (e){
      print(e);
      throw Exception('No Internet Connection');
    }
    return true;
  }

  Future<bool> AddToDB(String firstName, String lastName, String email,
      String accessToken) async {
        Dio dio = new Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
    };    
    try {
      var temp = {
        "Username": '$firstName $lastName',
        "Email": email,
      };
      var data = (temp);
      final responseRegister =
          await dio.post((settings.save_User_In_DB_url),
          options: Options(
            headers: {
                'Authorization': 'Bearer $accessToken',
                "content-type": "application/json",
                "accept": "application/json",
              }
          ),
              data: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  @visibleForTesting
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
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
