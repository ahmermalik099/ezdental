import 'package:ezdental/model/product/product.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              color: Color(0xff6E7E98),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${product.price}',
                style: const TextStyle(
                  color: Color(0xff6E7E98),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Text(
            'Description',
            style: TextStyle(
              color: Color(0xff6E7E98),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Amazing Product, you will love it!',
            style: const TextStyle(
              color: Color(0xff6E7E98),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
