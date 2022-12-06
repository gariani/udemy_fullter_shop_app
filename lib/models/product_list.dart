import 'dart:convert';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../exceptions/http_exception.dart';
import '../exceptions/saving_exception.dart';
import '../main.dart';
import 'product.dart';

part 'product_list.g.dart';
part 'product_list.freezed.dart';

@unfreezed
class ProductList with _$ProductList {
  factory ProductList({required List<Product> items}) = _ProductList;

  factory ProductList.fromJson(Map<String, Object?> json) =>
      _$ProductListFromJson(json);
}

class  ProductListNotifier with ChangeNotifier {
  ProductListNotifier(this.items);

  List<Product> items = [];

  List<Product> get favoriteItems =>
      items.where((prod) => prod.isFavorite).toList();

  List<Product> loadedProducts = [];

  int get itemsCount {
    return items.length;
  }

  Future<void> loadProducts() async {
    items.clear();

    final databaseProduct = FirebaseDatabase.instance.ref('products');
    final snapshot = await databaseProduct.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      data.forEach((productId, productData) {
        items.add(
          Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            price: double.tryParse(productData['price'].toString())!,
            imageUrl: productData['image'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    const Uuid uuid = Uuid();
    final String uuidStr = uuid.v4();

    DatabaseReference child =
        getIt<FirebaseDatabase>().ref('products').child(uuidStr);

    await child.set(
      {
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "image": product.imageUrl,
        "isFavorite": product.isFavorite
      },
    ).catchError((error) => throw SavingException());

    items.add(
      Product(
        id: uuidStr,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      imageUrl: data['image'] as String,
      price: data['price'] as double,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      final database = getIt<FirebaseDatabase>();
      final itemUpdate = database.ref('products').child(product.id);

      await itemUpdate.update(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "image": product.imageUrl,
        },
      );

      items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      final product = items[index];

      items.remove(product);
      notifyListeners();

      final database = getIt<FirebaseDatabase>();

      final itemDelete = database.ref('products').child(product.id);
      await itemDelete.remove().catchError(
        (onError) {
          items.insert(index, product);
          notifyListeners();
          throw HttpException(
            msg: 'Não foi possível excluir produto',
            statusCode: onError.hashCode,
          );
        },
      );
    }
  }
}
