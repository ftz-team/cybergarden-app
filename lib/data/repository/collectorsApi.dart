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

Future<List<CollectorModel>> loadHistory() async{
  
  return [
    new CollectorModel.fromJson(
        {
          "id": 1,
          "name": "Пункт номер 44",
          "photo": "https://farm1.staticflickr.com/818/41215128032_c38295559b_b.jpg",
          "description": "Приложение служит вашим проводником  в мир AR. Удобная навигация и интересный контент, недоступный многим.",
          "long" :37.4219983,
          "lat" : -122.084,
          "point" : {
            "long" :37.4219983,
            "lat" : -122.084
          },
          "contact" : {},
          "visited_count" : 21,
          "liked" : false
        }
    )
  ];
}