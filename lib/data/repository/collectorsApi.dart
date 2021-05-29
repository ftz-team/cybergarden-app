import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:dio/dio.dart';

import 'default.dart';

Future<List<CollectorModel>> getCollectors(String filter) async{



  Dio dio = await getApiClient();

  var response = await dio.get("/collector/get?type="+filter, );

  if (response.statusCode == 200){
    List<CollectorModel> res= [];
    for (var json in response.data['data']){
      res.add(CollectorModel.fromJson(json));
    }
    return res;
  }else{
    return [];
  }

}
Future<dynamic> likeCollectorApi(String action , int id) async {
  Dio dio = await getApiClient();
  var response = await dio.get("/collector/add_to_favourites?action="+action+"&id="+id.toString(), );
  return response;
}