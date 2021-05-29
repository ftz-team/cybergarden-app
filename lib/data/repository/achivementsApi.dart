import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:dio/dio.dart';

import 'default.dart';

Future<List<AchivementModel>> getAll() async{

  Dio dio = await getApiClient();
  //dio.get
  return [
    AchivementModel.fromJson(
      {
        "header" : "Лучший  среди животных!",
        "photo" : "https://previews.123rf.com/images/bobrovee/bobrovee1610/bobrovee161000029/63637650-abstract-modern-painting-in-mondrian-style-square-illustration.jpg",
        "description" : "Приложение служит вашим проводником  в мир AR. Удобная навигация и интересный контент, недоступный многим."
      }
    ),
    AchivementModel.fromJson(
        {
          "header" : "Лучший  среди животных!",
          "photo" : "https://previews.123rf.com/images/bobrovee/bobrovee1610/bobrovee161000029/63637650-abstract-modern-painting-in-mondrian-style-square-illustration.jpg",
          "description" : "Приложение служит вашим проводником  в мир AR. Удобная навигация и интересный контент, недоступный многим."
        }
    )
  ];

}