import 'dart:io';

import 'package:TishApp/TishApp/Services/AuthService.dart';
import 'package:TishApp/TishApp/Services/getNewTokenService.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DioSettings {
  DioSettings();

  static Future<Dio> getDio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    // dio.options.connectTimeout = 5000;
    dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      DateTime now = new DateTime.now();
      int current = now.millisecondsSinceEpoch ~/ 1000;
      if ((current - prefs.getInt('tokenStartTime')!.toInt()) >
          prefs.getInt('refreshDuration')!.toInt()) {
        Fluttertoast.showToast(
            msg: "Session Expired",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.black87,
            fontSize: 16.0);
        await AuthService().LogoutRepo();
      } else if ((current - prefs.getInt('tokenStartTime')!.toInt()) >
          prefs.getInt('tokenDuration')!.toInt()) {
        if (await RefreshToken(prefs.getString("refreshToken").toString())) {
          options.headers["Authorization"] =
              "Bearer ${prefs.getString("accessToken")}";
          options.headers["Content-Type"] = "application/json";
          return handler.next(options);
        }
      } else {
        // options.headers["Authorization"] =
        //     "Bearer ${prefs.getString("accessToken")}";
        options.headers["Content-Type"] = "application/json";
        return handler.next(options);
      }
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (error, handler) {
      print(error.error);
      return handler.next(error);
    }));
    return dio;
  }
}
