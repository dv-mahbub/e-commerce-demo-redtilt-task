import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartProductDetails> _cartItems = [];

  List<CartProductDetails> get cartItems => _cartItems;
  num totalAmount() {
    num amount = 0;
    for (var item in _cartItems) {
      num price = item.product?.price ?? 0;
      amount = amount + price * item.quantity!;
    }
    return amount;
  }

  void addToCart(CartProductDetails productDetails) {
    if (_cartItems.isEmpty) {
      productDetails.quantity = 1;
      _cartItems.add(productDetails);
    } else {
      bool found = false;
      for (var item in _cartItems) {
        if (productDetails.product?.id == item.product?.id) {
          item.quantity = item.quantity! + 1;
          found = true;
        }
      }
      if (!found) {
        productDetails.quantity = 1;

        _cartItems.add(productDetails);
      }
    }
    notifyListeners();
  }

  void removeFromCart(CartProductDetails productDetails) {
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].product?.id == productDetails.product?.id) {
        if (_cartItems[i].quantity == 1) {
          _cartItems.removeAt(i);
        } else {
          _cartItems[i].quantity = _cartItems[i].quantity! - 1;
        }
      }
    }
    notifyListeners();
  }

  void deleteCartData() {
    _cartItems = []; // Reset user data to null
    notifyListeners(); // Notify listeners after data reset
  }
}

class CartProductDetails {
  int? quantity;
  Product? product;

  // Constructor with mandatory and optional fields
  CartProductDetails({
    this.quantity,
    this.product,
  });

  // Method to convert an instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'product': product,
    };
  }
}
