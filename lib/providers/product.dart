//Model class POJO and

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  //reverse the boolean :)
  Future<void> toggleFavoriteStatus(String productId) async {
    final url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/products/$id.json';
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      await http.patch(url,
          body: json.encode({
            Product.IS_FAVORITE: isFavorite,
          }));
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }

  }

  static const TITLE = 'title';
  static const DESCRIPTION = 'description';
  static const IMAGE_URL = 'imageUrl';
  static const PRICE = 'price';
  static const IS_FAVORITE = 'isFavorite';
}
