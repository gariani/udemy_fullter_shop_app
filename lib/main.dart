import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/api_servers.dart';
import 'models/auth.dart';
import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';
import 'pages/auth_or_home_page.dart';
import 'pages/cart_page.dart';
import 'pages/orders_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/product_form_page.dart';
import 'pages/product_page.dart';
import 'pages/products_overview_page.dart';
import 'utils/app_routes.dart';
import 'package:get_it/get_it.dart';
import 'utils/firebase_options.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadSettings();

  runApp(const MyApp());
}

Future<void> _loadFirebaseAuth() async {
  await Firebase.initializeApp(
    options: (Platform.isLinux || Platform.isWindows)
        ? DefaultFirebaseOptions.web
        : DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _loadFileSettings() async {
  final file = await rootBundle.loadString('assets/api/api.json');
  final jsonvalue = jsonDecode(file);
  ApiServer api = ApiServer.fromJson(jsonvalue);
  getIt.registerSingleton<ApiServer>(api, signalsReady: true);
}

Future<void> _loadFirebaseDatabase() async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  getIt.registerSingleton<FirebaseDatabase>(database, signalsReady: true);
}

Future loadSettings() async {
  await _loadFileSettings();
  await _loadFirebaseAuth();
  await _loadFirebaseDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList('', []),
          update: (context, auth, previous) {
            return ProductList(
              auth.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.white),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.authOrHome: (context) => const AuthOrHomePage(),
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
          AppRoutes.cart: (context) => const CartPage(),
          AppRoutes.home: (context) => const MyHomePage(),
          AppRoutes.orders: (context) => const OrdersPage(),
          AppRoutes.product: (context) => const ProductPage(),
          AppRoutes.productForm: (context) => const ProductFormPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: ProductsOverviewPage(),
    );
  }
}
