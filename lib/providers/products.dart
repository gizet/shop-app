// ChangeNotifier notify the listeners when the data changes.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 19.99,
    //   imageUrl:
    //       'https://imgprd19.hobbylobby.com/5/ba/61/5ba610f22c7cd6efb4e6c69387d938451a6c40e6/700Wx700H-633719-0320.jpg',
    // ),
    // Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 69.99,
    //     imageUrl:
    //         'https://cdn-img.prettylittlething.com/d/f/5/3/df535a449d555f2a2977b8c3424fbc2619d95ef0_CLV7631_1.jpg'),
    // Product(
    //     id: 'p3',
    //     title: 'Hat',
    //     description: 'A back hat',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn11.bigcommerce.com/s-hsi95a83fz/product_images/uploaded_images/1118-grade-hat-black-thumb.jpg?t=1585690423&_ga=2.25919934.2069277356.1585516345-1869486607.1578452111'),
    // Product(
    //     id: 'p4',
    //     title: 'Jeans',
    //     description: 'Blue jeans',
    //     price: 79.99,
    //     imageUrl: 'https://www.balmain.com/12/12373671PW_11_f.jpg'),
  ];

  var _showFavoritesOnly = false;

  // spread operator
  //
  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    } else {
      return [..._items];
    }
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.get(url);
      //Tells dart that we have a map of a "dynamic" (which is a map).
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      if (response.body == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      responseData.forEach((prodId, productData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: productData['title'],
            price: productData['price'],
            description: productData['description'],
            isFavorite: productData['isFavorite'],
            imageUrl: productData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
      print(json.decode(response.body));
    } on Exception catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    //this is just for firebase ---> #products.json
    const url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          Product.TITLE: product.title,
          Product.DESCRIPTION: product.description,
          Product.PRICE: product.price,
          Product.IMAGE_URL: product.imageUrl,
          Product.IS_FAVORITE: product.isFavorite
        }),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } on Exception catch (error) {
      print(error);
      throw error;
    }
    // .then((response) {
    // }).catchError((error) {
    //   print(error);
    //   throw error;
    // });
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            Product.TITLE: product.title,
            Product.PRICE: product.price,
            Product.DESCRIPTION: product.description,
            Product.IMAGE_URL: product.imageUrl,
            Product.IS_FAVORITE: product.isFavorite,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    } else {
      print('Product with id' + id + ' was not updated');
    }
  }

  Future<void> removeProduct(String id) async {
    final url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    // dart still keeps the object because it still has a reference (existingProduct) but removes it from the list.
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete Product.');
    }
    existingProduct = null;
  }

  // //OPTIMISTIC UPDATE
  // void removeProduct(String id) {
  //   final url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products/$id';
  //   final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
  //   var existingProduct = _items[existingProductIndex];
  //   // dart still keeps the object because it still has a reference (existingProduct) but removes it from the list.
  //   http.delete(url).then((response) {
  //     if (response.statusCode >= 400) {
  //       throw HttpException('Could not delete Product.');
  //     }
  //     //print(response.statusCode);
  //     existingProduct = null;
  //   }).catchError((_) {
  //     _items.insert(existingProductIndex, existingProduct);
  //     notifyListeners();
  //   });
  //   _items.removeAt(existingProductIndex);
  //   notifyListeners();
  //
  //   //shorterWay
  //   //_items.removeWhere((prod) => prod.id == id);
  //
  //   // final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   // if (prodIndex >= 0) {
  //   //   _items.remove(_items[prodIndex]);
  //   // }
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
