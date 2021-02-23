import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({@required this.id, @required this.amount, @required this.products, @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  // copy of that order list.
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final responseData = (response.body) as Map<String, dynamic>;
      if (responseData == null) {
        return;
      }
      final List<OrderItem> loadedOrderItems = [];
      responseData.forEach((orderId, orderData) {
        loadedOrderItems.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((cartItem) => CartItem(
                    id: cartItem['id'],
                    title: cartItem['title'],
                    price: cartItem['price'],
                    quantity: cartItem['quantity']))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime'])));
      });
      _orders = loadedOrderItems.reversed.toList();
      notifyListeners();
    } catch (error) {
      //THROW ERROR HERE.
      //throw HttpException("Get could not be possible");
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    //this is just for firebase ---> #products.json
    const url = 'https://shop-app-test-e0f69-default-rtdb.firebaseio.com/orders.json';
    final dateTime = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
            //map the fucker into json maps
            {
              AMOUNT: total,
              PRODUCTS: cartProducts
                  .map((cartItem) => {
                        'id': cartItem.id,
                        'title': cartItem.title,
                        'price': cartItem.price,
                        'quantity': cartItem.quantity
                      })
                  .toList(),
              DATETIME: dateTime.toIso8601String()
            }),
      );

      _orders.insert(
          0,
          new OrderItem(
              id: json.decode(response.body)['name'], amount: total, products: cartProducts, dateTime: dateTime));
      notifyListeners();
    } catch (error) {
      //THROW ERROR IF NEEDED.
    }
  }

  //OrderItem
  static const AMOUNT = 'amount';
  static const PRODUCTS = 'products';
  static const DATETIME = 'dateTime';
}
