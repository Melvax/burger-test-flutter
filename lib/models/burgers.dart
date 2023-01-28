// To parse this JSON data, do
//
//     final burgerData = burgerDataFromJson(jsonString);

import 'dart:convert';

List<BurgerData> burgerDataFromJson(String str) =>
    List<BurgerData>.from(json.decode(str).map((x) => BurgerData.fromJson(x)));

class BurgerData {
  BurgerData({
    required this.ref,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
  });

  String ref;
  String title;
  String description;
  String thumbnail;
  int price;

  factory BurgerData.fromJson(Map<String, dynamic> json) => BurgerData(
        ref: json["ref"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        price: json["price"],
      );
}
