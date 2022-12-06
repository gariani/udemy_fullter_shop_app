import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductItemDetails extends StatelessWidget {
  const ProductItemDetails({super.key, required this.product});

  final Product product;

  Future confirmRemove(BuildContext context) async {
    final msg = ScaffoldMessenger.of(context);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tem certeza?'),
        content: const Text('Quer remover o item da lista de produtos?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Não!'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sim!'),
          )
        ],
      ),
    ).then((value) async {
      if (value ?? false) {
        try {
          await Provider.of<ProductListNotifier>(
            context,
            listen: false,
          ).removeProduct(product);
        } catch (error) {
          msg.showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.productForm, arguments: product);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                await confirmRemove(context).then(
                  (value) {
                    if (value ?? false) {
                      Provider.of<ProductListNotifier>(context, listen: false)
                          .removeProduct(product);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
