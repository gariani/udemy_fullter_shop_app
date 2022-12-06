// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cart _$$_CartFromJson(Map<String, dynamic> json) => _$_Cart(
      items: (json['items'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, CartItem.fromJson(e as Map<String, dynamic>)),
      ),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$_CartToJson(_$_Cart instance) => <String, dynamic>{
      'items': instance.items,
      'totalAmount': instance.totalAmount,
    };
