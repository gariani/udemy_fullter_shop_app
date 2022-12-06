import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item.dart';

part 'order.g.dart';
part 'order.freezed.dart';

@unfreezed
class Order with _$Order {
  factory Order({
    required String id,
    required double total,
    required List<CartItem> products,
    required DateTime date,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
}
