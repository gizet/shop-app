import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailsView extends StatelessWidget {
  // final Product product;
  // ProductDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    //retrive data from our routing action.
    final productId =
        ModalRoute.of(context).settings.arguments as String; // this will give us the id from the navigator
    //pro fucking vider.!
    // this widget will not rebuild becasue of listen: false.
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);
    //..


    Widget buildContainer(Widget child) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 200,
          width: 300,
          child: child);
    }

    // decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [color.withOpacity(0.4), color],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     borderRadius: BorderRadius.circular(15),

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.withOpacity(0.4), Colors.grey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              height: (MediaQuery.of(context).size.height / 3),
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // take as much space as it has
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
