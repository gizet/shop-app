import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/route/routes.dart';

import 'file:///C:/flutterProj/shop_app/lib/providers/product.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  //
  // ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
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
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
          //transparent bar
          backgroundColor: Colors.black54,
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                // estabilsh a connection to the nearest scaffold.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Item added to cart',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.white,
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
