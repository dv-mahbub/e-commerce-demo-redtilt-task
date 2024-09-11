import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/provider/cart_provider.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_app_bar.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_button.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/quantity_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      body: Consumer<CartProvider>(builder: (context, cart, child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1.sw,
                    ),
                    ...List.generate(
                      cart.cartItems.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: .95.sw,
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
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  cart.cartItems[index].product?.image ?? '',
                                  height: 55,
                                  width: 55,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/error_image.png',
                                      width: 55,
                                      height: 55,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  cart.cartItems[index].product?.title ?? '',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              QuantityContainer(
                                  product: cart.cartItems[index].product!),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                child: Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 8),
              child: CustomButton(
                  text: 'Procced to Payment',
                  height: 45,
                  width: .95.sw,
                  onTap: () {}),
            ))
          ],
        );
      }),
    );
  }
}
