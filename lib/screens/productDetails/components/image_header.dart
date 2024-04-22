import 'package:flutter/material.dart';

class ProductImageHeader extends StatelessWidget {
  final String productImgUrl;
  const ProductImageHeader({super.key, required this.productImgUrl});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30, left: 10),
          width: width,
          height: height * 0.3,
          decoration: const BoxDecoration(
            color: Color(0xff6E7E98),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(70),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            productImgUrl,
            width: width,
            height: height * 0.3,
            fit: BoxFit.cover,
          )
        ),
      ],
    );
  }
}