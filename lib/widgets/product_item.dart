import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/route/routes.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        //FIT: take all the available space
        child: GestureDetector(
          // one way to navigate to another screen.
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailsScreen(),
            //   ),
            // );
            // PUSHEDNAME WAY
            Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL_ROUTE, arguments: product.id);

          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          //transparent bar
          backgroundColor: Colors.black54,
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
