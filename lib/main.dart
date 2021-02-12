import 'package:flutter/material.dart';
import 'package:shop_app/route/routes.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter shop app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.black,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
      routes:
      {Routes.PRODUCT_DETAIL_ROUTE: (ctx) => ProductDetailsScreen()},
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('My Shop Body'),
      ),
    );

  }
}
