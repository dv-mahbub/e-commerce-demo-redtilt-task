import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_demo_redtilt_task/components/constants/api_endpoints.dart';
import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/api_response_data.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/get_api_controller.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_button.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/show_message.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text('Product List'),
        foregroundColor: AppColors.whiteText,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ...List.generate(productList?.products?.length ?? 0,
                  (index) => productContainer(productList!.products![index])),
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
                // quantityContainer(),
                CustomButton(
                  text: 'Add',
                  onTap: () {},
                  width: 80,
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container quantityContainer() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          littleButton(text: '-', onTap: () {}),
          Text(
            '3',
            style: TextStyle(
              color: AppColors.whiteText,
            ),
          ),
          littleButton(text: '+', onTap: () {}),
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
