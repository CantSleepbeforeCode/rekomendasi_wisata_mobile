class WisataModel {
  final String wisata_name;
  final String wisata_description;
  final String wisata_picture;
  final String wisata_latitude;
  final String wisata_longitude;
  final int wisata_min_price;
  final int wisata_max_price;

  WisataModel({
    required this.wisata_name,
    required this.wisata_description,
    required this.wisata_picture,
    required this.wisata_latitude,
    required this.wisata_longitude,
    required this.wisata_min_price,
    required this.wisata_max_price,
  });

  factory WisataModel.fromJson(Map<String, dynamic> json) {
    return WisataModel(
      wisata_name: json['wisata_name'],
      wisata_description: json['wisata_description'],
      wisata_picture: json['wisata_picture'],
      wisata_latitude: json['wisata_latitude'],
      wisata_longitude: json['wisata_longitude'],
      wisata_min_price: json['wisata_min_price'],
      wisata_max_price: json['wisata_max_price'],
    );
  }
}
