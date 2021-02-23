import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/route/routes.dart';
import 'package:shop_app/view/cart_screen.dart';
import 'package:shop_app/view/edit_product_screen.dart';
import 'package:shop_app/view/orders_screen.dart';
import 'package:shop_app/view/product_details_screen.dart';
import 'package:shop_app/view/products_overview_sc.dart';
import 'package:shop_app/view/user_product_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    //allows us to listen register a class witch we can listen.
    // provides a instance to all it`s children that needs that data (witch are listening).
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter shop app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.black,
          fontFamily: 'Lato',
        ),
        home: ProductsOvewrviewScr(),
        routes: {
          Routes.PRODUCT_DETAIL_ROUTE: (ctx) => ProductDetailsView(),
          Routes.CART_ROUTE: (ctx) => CartView(),
          Routes.ORDER_ROUTE: (ctx) => OrdersView(),
          Routes.USER_PRODUCT_ROUTE: (ctx) => UserProductView(),
          Routes.EDIT_PRODUCT_ROUTE: (ctx) => EditProductScreen(),
        },
      ),
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
