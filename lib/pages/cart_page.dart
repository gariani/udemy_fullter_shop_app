import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10.0),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$ ${cart.totalAmount}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
