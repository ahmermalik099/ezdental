import 'package:ezdental/model/product/product.dart';
import 'package:ezdental/screens/store/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  List<Product> productsList = [
    Product(name: 'Julraiz', imgurl: '/assets/mouthwash.jpeg', price: 5),
    Product(name: 'Julraiz', imgurl: '/assets/mouthwash.jpeg', price: 5),
    Product(name: 'Julraiz', imgurl: '/assets/mouthwash.jpeg', price: 5),
    Product(name: 'Julraiz', imgurl: '/assets/mouthwash.jpeg', price: 5),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Store'),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width * 0.5, // width
            mainAxisExtent: height * 0.25, // height
          ),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            final product = productsList[index];
            return ProductCard(
              product: product,
            );
          },
        ));
  }
}
