import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_button.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityContainer extends StatelessWidget {
  final Product product;
  const QuantityContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      int index = -1;
      for (int i = 0; i < cart.cartItems.length; i++) {
        if (cart.cartItems[i].product?.id == product.id) {
          index = i;
        }
      }
      return index == -1
          ? CustomButton(
              text: 'Add',
              onTap: () {
                cart.addToCart(
                  CartProductDetails(product: product),
                );
              },
              width: 80,
              height: 40,
            )
          : _quantityContainer(cart: cart, index: index);
    });
  }

  Container _quantityContainer(
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
                  cart.removeFromCart(CartProductDetails(
                      product: cart.cartItems[index].product));
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
