import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/route/routes.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;

  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final productsProvider = Provider.of<Products>(context, listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        //backgroundImage take an ImageProvider that yealds an image.
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        //should use size of the phone
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.EDIT_PRODUCT_ROUTE, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Do you want to remove the item from the cart?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                try {
                                  await productsProvider.removeProduct(id);
                                  //Navigator.of(context).pop(true);
                                  //Navigator.of(context).pop(true);
                                } catch (error) {
                                  Navigator.of(ctx).pop(true);
                                  scaffold.showSnackBar(
                                    SnackBar(
                                      content: Text("Deleting failed!"),
                                    ),
                                  );
                                }
                                Navigator.of(ctx).pop(true);
                              },
                              child: Text('Yes'),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text('No'))
                          ],
                        ));
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
