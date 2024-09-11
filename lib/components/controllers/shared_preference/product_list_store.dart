import 'package:shared_preferences/shared_preferences.dart';

class ProductListStore {
  static const String productListKey = 'productList';

  static Future<String?> getProductList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(productListKey);
  }

  static Future<void> storeProductList(String productListJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(productListKey, productListJson);
  }

  static Future<void> removeProductList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(productListKey);
  }
}
