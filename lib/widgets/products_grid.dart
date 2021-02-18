import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavorites;


  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    // connection to one of the provided classes. (default is true).
    final productData = Provider.of<Products>(context, listen: true);
    final products =  showFavorites ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      //specify the number
      itemCount: products.length,
      //receives the context and the index of the item and return a widget for every item
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (context) => products[i],
        value: products[i],
        child: ProductItem(),
      ),
      // define how the grid should be structured.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
    );
  }
}
