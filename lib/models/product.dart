import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  bool isFavortire;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavortire = false,
  });

  void toggleFavorite() {
    isFavortire = !isFavortire;
    notifyListeners();
  }
}
