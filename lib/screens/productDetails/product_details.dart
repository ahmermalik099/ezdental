import 'package:ezdental/model/product/product.dart';
import 'package:ezdental/screens/productDetails/components/image_header.dart';
import 'package:ezdental/screens/productDetails/components/product_details.dart';
import 'package:ezdental/screens/productDetails/components/quantity.dart';
import 'package:ezdental/services/stripe_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final Map<String, dynamic> iceCream;

  const ProductDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int counter = 1;
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    // I am assuming, that cart button, quantity counter will use the BLoC pattern
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff6E7E98),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageHeader(
            productImgUrl: product.imgurl,
          ),
          ProductInfo(
            product: product,
          ),
          QuantityCounter(counter: counter),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xff6E7E98),
                  ),
                ),
                onPressed: () {
                  //StripePaymentHandle().stripeMakePayment(product.price);
                  
                },
                child: const Text(
                  'Buy!',
                  style: TextStyle(color: Color.fromARGB(255, 230, 233, 251)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
