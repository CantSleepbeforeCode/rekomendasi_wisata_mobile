class KulinerModel {
  final String kuliner_name;
  final String kuliner_description;
  final String kuliner_picture;
  final String kuliner_latitude;
  final String kuliner_longitude;
  final int kuliner_min_price;
  final int kuliner_max_price;

  KulinerModel({
    required this.kuliner_name,
    required this.kuliner_description,
    required this.kuliner_picture,
    required this.kuliner_latitude,
    required this.kuliner_longitude,
    required this.kuliner_min_price,
    required this.kuliner_max_price,
  });

  factory KulinerModel.fromJson(Map<String, dynamic> json) {
    return KulinerModel(
      kuliner_name: json['kuliner_name'],
      kuliner_description: json['kuliner_description'],
      kuliner_picture: json['kuliner_picture'],
      kuliner_latitude: json['kuliner_latitude'],
      kuliner_longitude: json['kuliner_longitude'],
      kuliner_min_price: json['kuliner_min_price'],
      kuliner_max_price: json['kuliner_max_price'],
    );
  }
}
