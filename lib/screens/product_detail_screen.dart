import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final Product product;
  //
  //
  //
  // ProductDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    //retrive data from our routing action.
    ModalRoute.of(context).settings.arguments as String; // this will give us the id from the navigator
    //..
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
