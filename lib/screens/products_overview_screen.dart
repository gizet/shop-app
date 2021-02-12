import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';

//THIS WILL BE USED AS THE HOME SCREEN
class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 19.99,
      imageUrl: 'https://imgprd19.hobbylobby.com/5/ba/61/5ba610f22c7cd6efb4e6c69387d938451a6c40e6/700Wx700H-633719-0320.jpg',
    ),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 69.99,
        imageUrl: 'https://cdn-img.prettylittlething.com/d/f/5/3/df535a449d555f2a2977b8c3424fbc2619d95ef0_CLV7631_1.jpg'),
    Product(
        id: 'p3',
        title: 'Hat',
        description: 'A back hat',
        price: 29.99,
        imageUrl: 'https://cdn11.bigcommerce.com/s-hsi95a83fz/product_images/uploaded_images/1118-grade-hat-black-thumb.jpg?t=1585690423&_ga=2.25919934.2069277356.1585516345-1869486607.1578452111'),
    Product(
        id: 'p4',
        title: 'Jeans',
        description: 'Blue jeans',
        price: 79.99,
        imageUrl: 'https://www.balmain.com/12/12373671PW_11_f.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Shop')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        //specify the number
        itemCount: loadedProducts.length,
        //receives the context and the index of the item and return a widget for every item
        itemBuilder: (ctx, i) => ProductItem(loadedProducts[i]),
        // define how the grid should be structured.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      ),

    );
  }
}
