import 'package:dio/dio.dart';

final client = Dio();

Future<Map> sendCode(int number) async{
  return {
    "ok" : true,
  };
}

