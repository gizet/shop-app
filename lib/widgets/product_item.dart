import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      //FIT: take all the available space
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        title: Text(product.title, textAlign: TextAlign.center,),
        leading: Icon(Icons.favorite),
        //transparent bar
        backgroundColor: Colors.black54,
        trailing: Icon(Icons.shopping_cart),
      ),
    );
  }
}
