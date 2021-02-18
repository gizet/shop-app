import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/route/routes.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewView extends StatefulWidget {
  @override
  _ProductsOverviewViewState createState() => _ProductsOverviewViewState();
}

class _ProductsOverviewViewState extends State<ProductsOverviewView> {
  var _showOnlFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('The Shop'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  // productsContainer.showFavoritesOnly();
                  _showOnlFavorites = true;
                } else {
                  _showOnlFavorites = false;
                  //productsContainer.showAll();
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              color: Colors.red,
              child: ch,
              value: cart.itemCount.toString(),
            ),
            // the child from line 52, is actually the one form the builder from 46. In this way the Icons are not rebuilding.
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.CART_ROUTE);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlFavorites),
    );
  }
}
