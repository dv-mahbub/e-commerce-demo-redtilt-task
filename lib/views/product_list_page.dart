import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_demo_redtilt_task/components/constants/api_endpoints.dart';
import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/api_response_data.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/get_api_controller.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_functions/navigate.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_button.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/show_message.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:e_commerce_demo_redtilt_task/views/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListModel? productList;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    try {
      ApiResponseData result =
          await getApiController(ApiEndpoints.productList, false);
      if (result.statusCode == 200) {
        if (mounted) {
          setState(() {
            productList =
                ProductListModel.fromJson(jsonDecode(result.responseBody));
          });
        }
      } else {
        log('Product List failed: ${result.statusCode} : ${result.responseBody}');
        showError('Failed to get product list');
      }
    } catch (e) {
      log('Fetch all products error: $e');
      showError('Failed to connect server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Product List'),
        foregroundColor: AppColors.whiteText,
        actions: [
          Consumer<CartProvider>(builder: (context, cart, child) {
            return Visibility(
              visible: cart.cartItems.isNotEmpty,
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    navigate(context: context, child: const CheckoutPage());
                  }
                },
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          '${cart.cartItems.length}',
                          style: TextStyle(
                            color: AppColors.whiteText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(width: 15),
        ],
      ),
      floatingActionButton:
          Consumer<CartProvider>(builder: (context, cart, child) {
        return cart.cartItems.isEmpty
            ? Container()
            : InkWell(
                onTap: () {
                  if (mounted) {
                    navigate(context: context, child: const CheckoutPage());
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade800,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Checkout >>',
                    style: TextStyle(color: AppColors.whiteText),
                  ),
                ),
              );
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ...List.generate(productList?.products?.length ?? 0,
                  (index) => productContainer(productList!.products![index])),
              SizedBox(
                height: 50,
                width: 1.sw,
              ),
            ],
          ),
        ),
      ),
    );
  }

  productContainer(Product product) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: .45.sw,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 3,
              color: AppColors.shadowColor.withOpacity(.3),
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  product.image ?? '',
                  width: .40.sw,
                  height: .5.sw,
                ),
              ],
            ),
            Text(
              product.title ?? 'No Title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price ?? '0'}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Consumer<CartProvider>(builder: (context, cart, child) {
                  int index = -1;
                  for (int i = 0; i < cart.cartItems.length; i++) {
                    if (cart.cartItems[i].id == product.id) {
                      index = i;
                    }
                  }
                  return index == -1
                      ? CustomButton(
                          text: 'Add',
                          onTap: () {
                            cart.addToCart(
                              CartProductDetails(
                                id: product.id,
                                price: product.price,
                              ),
                            );
                          },
                          width: 80,
                          height: 40,
                        )
                      : quantityContainer(cart: cart, index: index);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container quantityContainer(
      {required CartProvider cart, required int index}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          littleButton(
              text: '-',
              onTap: () {
                cart.removeFromCart(
                    CartProductDetails(id: cart.cartItems[index].id));
              }),
          Text(
            '${cart.cartItems[index].quantity ?? 0}',
            style: TextStyle(
              color: AppColors.whiteText,
            ),
          ),
          littleButton(
              text: '+',
              onTap: () {
                cart.addToCart(cart.cartItems[index]);
              }),
        ],
      ),
    );
  }

  Widget littleButton(
      {required String text,
      required Function() onTap,
      bool isBiggerFont = true}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.whiteText,
            fontSize: isBiggerFont ? 18 : 14,
            fontWeight: isBiggerFont ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  showError(String message) {
    if (mounted) {
      showErrorMessage(context, message);
    }
  }
}
