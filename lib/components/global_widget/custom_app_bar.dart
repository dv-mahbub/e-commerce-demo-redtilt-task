import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_functions/navigate.dart';
import 'package:e_commerce_demo_redtilt_task/views/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;

  const CustomAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(title),
      foregroundColor: AppColors.whiteText,
      actions: [
        Consumer<CartProvider>(builder: (context, cart, child) {
          return Visibility(
            visible: cart.cartItems.isNotEmpty,
            child: InkWell(
              onTap: () {
                navigate(context: context, child: const CheckoutPage());
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
    );
  }
}
