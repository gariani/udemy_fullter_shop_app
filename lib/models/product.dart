import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shop_app/main.dart';

part 'product.g.dart';
part 'product.freezed.dart';

@unfreezed
class Product with _$Product {
  factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    @Default(false) bool isFavorite,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

class ProductNotified with ChangeNotifier {
  ProductNotified({required this.product});
  final Product product;

  void _toggleFavorite() {
    product.isFavorite = product.isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    FirebaseDatabase database = getIt<FirebaseDatabase>();
    _toggleFavorite();
    await database.ref('products/$product.id').update(
        {"isFavorite": product.isFavorite}).onError((error, stackTrace) {
      _toggleFavorite();
    });
  }
}
