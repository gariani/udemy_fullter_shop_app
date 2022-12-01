import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_drawer.dart';
import '../models/order_list.dart';

import '../components/order.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro.'),
            );
          } else {
            return Consumer<OrderList>(
                builder: (context, orders, child) => ListView.builder(
                      itemCount: orders.itemsCount,
                      itemBuilder: (context, index) =>
                          OrderWidget(order: orders.items[index]),
                    ));
          }
        }),
      ),
    );
  }
}
