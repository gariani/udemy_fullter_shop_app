import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<OrderList>(
        create: (order) => OrderList(),
        // we use `builder` to obtain a new `BuildContext` that has access to the provider
        builder: (context, child) {
          // final OrderList orders =
          //     Provider.of<OrderList>(context, listen: false);

          return Scaffold(
              appBar: AppBar(
                title: const Text('Meus Pedidos'),
              ),
              drawer: const AppDrawer(),
              body: Container()
              // ListView.builder(
              // itemCount: orders.itemsCount,
              // itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
              // ),
              );
        });
  }
}
