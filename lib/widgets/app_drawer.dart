import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/route/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.ORDER_ROUTE);
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.USER_PRODUCT_ROUTE);
            },
          ),
          // this means that will never add a back button.
        ],
      ),
    );
  }
}
