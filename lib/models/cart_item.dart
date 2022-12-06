import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.g.dart';
part 'cart_item.freezed.dart';

@unfreezed
class CartItem with _$CartItem {
  factory CartItem({
    required String id,
    required String productId,
    required String name,
    required int quantity,
    required double price,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, Object?> json) =>
      _$CartItemFromJson(json);
}
