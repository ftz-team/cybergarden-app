import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'collectorsApi.dart';

Future<Dio> getApiClient() async {

  var _dio = Dio();
  _dio.options.baseUrl = 'http://194.58.98.181:8000/api';

  final storage = new FlutterSecureStorage();


  //var token = await storage.read(key: "USER_TOKEN");
  var token = "b532f8fe87407fb3106ee68b0e4435acf43595fe";
  _dio.interceptors.clear();
  _dio.options.headers["Authorization"] = "Token " + token;
  return _dio;
}

//await storage.write(key: key, value: value);


Future<bool> isTokenValid(String token) async{
  return true;
}