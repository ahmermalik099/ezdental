import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../services/stripe_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'checkout.dart';

class Product {
  final String name;
  final String price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [
    Product(name: 'Toothpaste', price: '\$5.99', imageUrl: 'assets/toothpaste.jpg'),
    Product(name: 'Toothbrush', price: '\$2.99', imageUrl: 'assets/toothbrush.jpeg'),
    Product(name: 'Tongue Cleaner', price: '\$2.99', imageUrl: 'assets/tonguecleaners.jpg'),
    Product(name: 'Mouth Wash', price: '\$6.99', imageUrl: 'assets/mouthwash.jpeg'),
    Product(name: 'Flosses', price: '\$2.99', imageUrl: 'assets/flosses.jpg'),
    Product(name: 'Care Kit', price: '\$14.99', imageUrl: 'assets/carekit.jpeg'),
    // Add more products here
  ];

  Map<Product, int> cart = {};

  void addToCart(Product product) {
    if (cart.containsKey(product)) {
      setState(() {
        cart[product] = cart[product]! + 1;
      });
    } else {
      setState(() {
        cart[product] = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductItem(
                    product: products[index],
                    onTap: () {
                      addToCart(products[index]);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              showCartDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cart Total: \$${calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    double total = 0;
    cart.forEach((product, quantity) {
      total += double.parse(product.price.substring(1)) * quantity;
    });
    return total;
  }

  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cart"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var entry in cart.entries)
                  ListTile(
                    title: Text(entry.key.name),
                    subtitle: Text('\$${entry.key.price} x ${entry.value}'),
                  ),
                SizedBox(height: 10),
                Text(
                  'Total: \$${calculateTotal().toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Perform actions to complete the purchase
                // For example, navigate to a checkout page
                //Navigator.of(context).pop();
                // Add your navigation logic here
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
              },
              child: Text('Complete Purchase'),
            ),
          ],
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.price),
        leading: CircleAvatar(
          backgroundImage: AssetImage(product.imageUrl),
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          child: Text('Add to Cart'),
        ),
        onTap: onTap,
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return ProductPage() ;

  }
}




// class ProductDetailsPage extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailsPage({Key? key, required this.product}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               product.imageUrl,
//               height: 200,
//             ),
//           ),
//           Text(
//             product.name,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Price: ${product.price}',
//             style: TextStyle(fontSize: 18),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Handle buy now action
//               //StripePaymentHandle().stripeMakePayment(product.price);
//             },
//             child: Text('Buy Now'),
//           ),
//         ],
//       ),
//     );
//   }
// }
