import 'package:dio/dio.dart';

final client = Dio();

Future<Map> sendCode(int number) async{
  return {
    "ok" : true,
  };
  var _dio = Dio();
  _dio.options.baseUrl = 'http://194.58.98.181/api';
  var res = await _dio.post("/auth", data: {
    "phone_number" : number
  });
  if (res.statusCode == 200){
    return {
      "ok" : true,
    };
  }
  return {
    "ok" : false,
  };

}

Future<Map> cofirmCode(int code) async{
  return {};
}