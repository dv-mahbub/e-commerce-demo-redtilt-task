import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_functions/navigate.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_app_bar.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_button.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:e_commerce_demo_redtilt_task/views/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 1.sw,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: .4.sh),
                child: Image.network(
                  product.image ?? '',
                  width: .9.sw,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  SizedBox(
                    width: .03.sw,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                product.title ?? 'No tilte',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                product.description ?? '',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${product.price ?? 0}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
      child: IntrinsicWidth(
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
}
