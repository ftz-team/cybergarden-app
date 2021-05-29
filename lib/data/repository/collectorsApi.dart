import 'package:cybergarden_app/data/models/CollectorModel.dart';

Future<List<CollectorModel>> getCollectors() async{
  return [
    new CollectorModel.fromJson(
      {
        "id": 1,
        "name": "Пункт номер 44",
        "photo": "https://farm1.staticflickr.com/818/41215128032_c38295559b_b.jpg",
        "description": "Очень крутой пункт приема, посещаю каждый день с семьей из 12 детей. ",
        "point" : {
          "long" : "37.4219983",
          "lat" : "-122.084"
        },
        "contact" : {},
        "visited_cnt" : 21
      }
    )
  ];
}