// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderList _$$_OrderListFromJson(Map<String, dynamic> json) => _$_OrderList(
      items: (json['items'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_OrderListToJson(_$_OrderList instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
