import 'dart:io';
import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:TishApp/TishApp/utils/TishAppString.dart';
import 'package:TishApp/main.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:jwt_decode/jwt_decode.dart';


class AuthService {
    Settings settings = Settings();
      LocalStorage _localStorage = LocalStorage('UserInfo');

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
      if (response.statusCode == 200 || response.statusCode == 201)
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
      if (response.statusCode == 200 || response.statusCode == 201)
        result = responseRegister.data;

      temp = {"Username": '$firstName $lastName', "Email": email};
      data = (temp);
      final responseRegister2 = await dio.post((settings.save_User_In_DB_url),
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            "content-type": "application/json",
            "accept": "application/json",
          }),
          data: data);
      print("Done");
    } on SocketException {
      print("ERROR");
      throw Exception('No Internet Connection');
    } catch (e) {
      print(e);
      throw Exception('No Internet Connection');
    }
    return true;
  }

  Future<void> LogoutRepo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _localStorage.clear();
    await prefs.setBool('IsLoggedIn', false);
    navigator.currentState!.popUntil((route) => route.isFirst);
  }

  Future<dynamic> loginService(String username, String password) async {
    Dio dio = new Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
    Response response;
    try {
      response = await dio.post((settings.login_url),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          }),
          data: {
            "username": username,
            "password": password,
            "grant_type": settings.grant_type_login,
            "client_id": settings.client_id_login,
            "client_secret": settings.client_secret_login,
          });
    } catch (e) {
      print(e);
      throw Exception('No Internet Connection');
    }
    return response.data;
  }

  // ignore: non_constant_identifier_names
  Future<bool> LoginRepo(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await loginService(username, password);
    final jsonData = (response);
    Map<String, dynamic>? jwtData = {};
    print(jsonData['access_token']);
    jwtData = Jwt.parseJwt(jsonData['access_token'].toString());
    await prefs.setString("accessToken", jsonData['access_token']);
    await prefs.setString("refreshToken", jsonData['refresh_token']);
    await prefs.setString("UserID", jwtData['sub']);
    await prefs.setInt("tokenDuration", jsonData['expires_in']);
    await prefs.setInt("refreshDuration", jsonData['refresh_expires_in']);
    await prefs.setInt("tokenStartTime", jwtData['iat']);
    await prefs.setString('name', jwtData['name'].toString());
    await prefs.setString('refresh_token', jwtData['refresh-token'].toString());
    await prefs.setString('email', jwtData['email'].toString());
    await prefs.setString(
        'email_verified', jwtData['email_verified'].toString());
    await prefs.setString('given_name', jwtData['given_name'].toString());
    await prefs.setString('family_name', jwtData['family_name'].toString());
    await prefs.setString(prefs_UserLocation, "Beirut");
    await prefs.setBool('IsLoggedIn', true);
    return true;
  }
}
