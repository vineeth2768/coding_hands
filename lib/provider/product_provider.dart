import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  Product? _product;

  Product? get product => _product;

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _product = Product.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      log('Error fetching data: $error');
    }
  }
}
