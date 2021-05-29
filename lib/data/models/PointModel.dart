class PointModel{

    final double long;
   final  double lat;

  PointModel({
    required this.long ,
    required this.lat
  });

  PointModel.fromJson(Map<dynamic, dynamic> json):
    long = double.parse(json['long']),
    lat = double.parse(json['lat']);

}