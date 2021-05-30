class AchivementModel{


  final String header;
  final String photo;
  final String description;


  AchivementModel.fromJson(Map json) :
        header = json['header'],
        photo = json['image'],
        description = json['description'];
}