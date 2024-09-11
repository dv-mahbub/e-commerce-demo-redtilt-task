import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_demo_redtilt_task/components/constants/api_endpoints.dart';
import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/api_response_data.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/get_api_controller.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_functions/navigate.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_app_bar.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/quantity_container.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/show_message.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:e_commerce_demo_redtilt_task/views/checkout_page.dart';
import 'package:e_commerce_demo_redtilt_task/views/product_details_page.dart';
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
      appBar: const CustomAppBar(title: 'Product List'),
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
      child: InkWell(
        onTap: () {
          if (mounted) {
            navigate(
                context: context, child: ProductDetailsPage(product: product));
          }
        },
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
                  QuantityContainer(product: product),
                ],
              ),
            ],
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
