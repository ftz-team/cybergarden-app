import 'package:cybergarden_app/data/models/PointModel.dart';

class CollectorModel{

  final int id;
  final String name;
  final String photo;
  final String description;
  final PointModel point;
  final Map contact;
  final int visited_cnt;


  CollectorModel.fromJson(Map json) :
      id = json['id'],
      name = json['name'],
      photo = json['photo'],
      description = json['description'],
      point = PointModel.fromJson(json['point']),
      contact = json['contact'],
      visited_cnt = json['visited_cnt'];

}