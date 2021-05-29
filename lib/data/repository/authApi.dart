import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final client = Dio();

Future<Map> sendCode(int number) async{
  if (number.toString().length != 10){
    return {
      "ok" : false,
    };
  }

  var _dio = Dio();
  _dio.options.baseUrl = 'http://194.58.98.181:8000/api';
  var res = await _dio.post("/auth", data: {
    "phone_number" : "8"+number.toString()
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

Future<Map> cofirmCode(int code, int phone) async{
  if (code.toString() != "1234"){
    return {
      "ok" : false,
    };
  }
  var _dio = Dio();
  _dio.options.baseUrl = 'http://194.58.98.181:8000/api';
  var res = await _dio.post("/auth/code", data: FormData.fromMap({
    "phone_number" : int.parse("8"+phone.toString()),
    "code" : code
  }));
  if (res.statusCode == 200){
    final storage = new FlutterSecureStorage();
    var token = res.data['Token'];
    await storage.write(key: "USER_TOKEN", value:token );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("USER_TOKEN", token);
    return {
      "ok" : true,
    };
  }
  return {
    "ok" : false,
  };


}

void logout() async{
  final storage = new FlutterSecureStorage();
  await storage.delete(key: "USER_TOKEN");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}