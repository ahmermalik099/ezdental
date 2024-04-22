import 'package:ezdental/model/product/product.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        top: 3,
        left: 3,
        right: 3,
        bottom: 3,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/product_details', arguments: product);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(200, 245, 245, 245),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 130, 149, 179),
                          ),
                        ),),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        product.imgurl,
                        width: 140,
                        height: 140,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}