import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/auth_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';

import '../models/auth.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
        future: auth.decideStartingPage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data as bool) {
              return const ProductsOverviewPage();
            }
          }
          return const AuthPage();
        });
  }
}
