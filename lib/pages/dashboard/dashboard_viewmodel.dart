import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/model/cart_product.dart';
import 'package:pos/model/product_models.dart';
import 'package:pos/state_global/state_global.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class DashboardViewmodel extends FutureViewModel {
  BuildContext? ctx;
  DashboardViewmodel({this.ctx});
  List<Recipe> listAllProduct = [];
  List<dynamic> listSelectProduct = [];

  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get tax => subTotal * 0.05;

  double get totalCartPrice => subTotal + tax;

  getProduct() async {
    try {
      setBusy(true);
      // ctx!.read<GlobalLoadingState>().show();
      await Future.delayed(Duration(seconds: 5));

      final response = await fetchRecipes();

      if (response.isNotEmpty) {
        listAllProduct = List.from(response);

        print("listAllProduct : ${listAllProduct}");
        ctx!.read<GlobalLoadingState>().hide();
        setBusy(false);
      } else {
        ctx!.read<GlobalLoadingState>().hide();
        setBusy(false);
      }
      ctx!.read<GlobalLoadingState>().hide();
      setBusy(false);
      notifyListeners();
    } catch (e) {
      ctx!.read<GlobalLoadingState>().hide();
      setBusy(false);
      print("Error get product : $e");
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    final res = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final List data = json['recipes'];
      return data.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch recipes");
    }
  }

  void addToCart(Recipe product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(Recipe product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void decreaseQuantity(Recipe product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        removeFromCart(product);
      }
    }
    notifyListeners();
  }

  int getQuantity(Recipe product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    return index != -1 ? _items[index].quantity : 0;
  }

  double get subTotal {
    return _items.fold(
      0,
      (sum, item) => sum + item.quantity * (item.product.price ?? 0),
    );
  }

  @override
  Future futureToRun() async {
    await getProduct();
  }
}
