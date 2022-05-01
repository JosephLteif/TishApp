import 'package:TishApp/TishApp/Settings/AppSettings.dart';
import 'package:TishApp/TishApp/Settings/DioSettings.dart';
import 'package:TishApp/TishApp/model/TishAppModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepository {
    Settings settings = Settings();
  final String _baseUrl = Settings().backend_url;

  Future<dynamic> getAll() async {
    var responseJson;
    Dio dio = await DioSettings.getDio();
    try {
      final response = await dio.get((_baseUrl + '/Users'));
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
      Dio dio = await DioSettings.getDio();
      final response = await dio.get((_baseUrl + '/Users/$id'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getByEmail() async {
    dynamic responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Dio dio = await DioSettings.getDio();
      final response = await dio
          .get((_baseUrl + '/users/email/${prefs.getString('email')}'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> getByType(String type) async {
    dynamic responseJson;
    try {
      Dio dio = await DioSettings.getDio();
      final response = await dio.get((_baseUrl + '/Users/Type/$type'));
      responseJson = returnResponse(response);
    } on Exception catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw Exception(response.statusMessage.toString());
      case 401:
      case 403:
        throw Exception(response.statusMessage.toString());
      case 500:
      default:
        throw Exception('Error occured while communication with server' +
            ' with status code : ${response.statusCode}');
    }
  }

  Future<List<User>> fetchAllUser() async {
    List<User> list = [];
    dynamic response = await getAll();
    for (var item in response) {
      User UserFavoritePlace = User.fromJson(item);
      list.add(UserFavoritePlace);
    }
    return list;
  }

  Future<User> fetchUserByEmail() async {
    dynamic response = await getByEmail();
    User user = User.fromJson(response);
    return user;
  }

  Future<User> fetchOneUser(int id) async {
    dynamic response = await getOne(id);
    User user = User.fromJson(response);
    return user;
  }
}
