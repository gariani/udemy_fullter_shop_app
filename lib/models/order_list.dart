import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shop_app/main.dart';
import 'cart.dart';
import 'order.dart';
import 'package:uuid/uuid.dart';

import 'cart_item.dart';

part 'order_list.g.dart';
part 'order_list.freezed.dart';

@unfreezed
class OrderList with _$OrderList {
  factory OrderList({required List<Order> items}) = _OrderList;

  factory OrderList.fromJson(Map<String, Object?> json) =>
      _$OrderListFromJson(json);
}

class OrderListNotifier with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();

    final database = getIt<FirebaseDatabase>();

    final snapshot = await database.ref('orders').get();

    if (snapshot.exists) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      data.forEach((orderId, orderData) {
        _items.add(
          Order(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price'],
              );
            }).toList(),
          ),
        );
      });
    }

    notifyListeners();
  }

  Future<void> addOrder(CartNotifier cart) async {
    final date = DateTime.now();

    final database = getIt<FirebaseDatabase>();
    final auth = getIt<FirebaseAuth>();
    final currentUser = auth.currentUser;
    const uuid = Uuid();

    final String uuidStr = uuid.v4();
    final orderUpdate =
        database.ref('orders').child(currentUser!.uid).child(uuidStr);

    final List<CartItem> list = [];
    cart.items.forEach((key, value) {
      list.add(
        CartItem(
          id: value.id,
          productId: value.productId,
          name: value.name,
          quantity: value.quantity,
          price: value.price,
        ),
      );
    });

    final Order order = Order(
      id: uuidStr,
      total: cart.totalAmount,
      date: date,
      products: list.toList(),
    );

    await orderUpdate
        .update(
      order.toJson(),
    )
        .then((value) {
      _items.insert(
        0,
        Order(
          id: uuidStr,
          total: cart.totalAmount,
          date: date,
          products: cart.items.values.toList(),
        ),
      );
    }).catchError((onError) {});
    notifyListeners();
  }
}
