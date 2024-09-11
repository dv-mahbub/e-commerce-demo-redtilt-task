import 'package:e_commerce_demo_redtilt_task/components/global_widget/custom_app_bar.dart';
import 'package:e_commerce_demo_redtilt_task/components/global_widget/quantity_container.dart';
import 'package:e_commerce_demo_redtilt_task/models/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/error_image.png',
                      width: .9.sw,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  QuantityContainer(product: product),
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
}
