import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.dart';
import 'product.dart';

part 'cart.g.dart';
part 'cart.freezed.dart';

@unfreezed
class Cart with _$Cart {
  factory Cart(
      {required Map<String, CartItem> items,
      required double totalAmount}) = _Cart;

  factory Cart.fromJson(Map<String, Object?> json) => _$CartFromJson(json);
}

class CartNotifier with ChangeNotifier {
  CartNotifier({required this.items});

  Map<String, CartItem> items = {};

  int get itemsCount {
    return items.length;
  }

  double get totalAmount {
    double total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (items.containsKey(product.id)) {
      items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!items.containsKey(productId)) {
      return;
    }

    if (items[productId]?.quantity == 1) {
      items.remove(productId);
    } else {
      items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    items = {};
    notifyListeners();
  }
}
