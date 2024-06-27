// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:paymob_pakistan/paymob_payment.dart';
//
// class CheckoutPage extends StatefulWidget {
//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }
// // ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRRNE5Ua3dMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuUEhEbzRYb0VSa096QzBlWXNESmxwSk0xN00tTTBCd1ZIQjhZSnRNNDJkdHduU18taHZVWDRUdzVraTNIOXFZTVNFVzRHQUJ5TWljZ25sT1ZLWElhTlE=
// class _CheckoutPageState extends State<CheckoutPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _selectedPaymentMethod = '';
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     PaymobPakistan.instance.initialize(
//       apiKey: "your_api_key",
//       jazzcashIntegrationId: 123123,
//       easypaisaIntegrationID: 123123,
//       integrationID: 123456,
//       iFrameID: 123456,
//     );
//   }
//
//   void handlePayment() async {
//     if (_selectedPaymentMethod == 'card') {
//       try {
//         final PaymobResponse? response = await PaymobPakistan.instance.pay(
//           context: context,
//           currency: "PKR",
//           amountInCents: "50000", // example amount, adjust accordingly
//           onPaymentSuccess: (response) {
//             Fluttertoast.showToast(
//                 msg: "Payment Successful",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//           },
//           onPaymentFailure: (response) {
//             Fluttertoast.showToast(
//                 msg: "Payment Failed",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 backgroundColor: Colors.redAccent,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//           },
//         );
//       } catch (e) {
//         Fluttertoast.showToast(
//             msg: "Error: $e",
//             toastLength: Toast.LENGTH_LONG,
//             gravity: ToastGravity.BOTTOM,
//             backgroundColor: Colors.redAccent,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//       }
//     } else if (_selectedPaymentMethod == 'cod') {
//       // Handle Cash on Delivery logic
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   'Select Payment Method:',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 SizedBox(height: 10),
//                 RadioListTile(
//                   title: Text('PayMob'),
//                   value: 'card',
//                   groupValue: _selectedPaymentMethod,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedPaymentMethod = value!;
//                     });
//                   },
//                 ),
//                 RadioListTile(
//                   title: Text('Cash on Delivery'),
//                   value: 'cod',
//                   groupValue: _selectedPaymentMethod,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedPaymentMethod = value!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       handlePayment();
//                     }
//                   },
//                   child: Text('Proceed to Pay'),
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Shipping Details',
//                   style: TextStyle(fontSize: 30.0),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10.0),
//                       gapPadding: 10.0,
//                     ),
//                     icon: Icon(Icons.person),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: addressController,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10.0),
//                       gapPadding: 10.0,
//                     ),
//                     icon: Icon(Icons.location_on),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your address';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10.0),
//                       gapPadding: 10.0,
//                     ),
//                     icon: Icon(Icons.phone),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (nameController.text.isEmpty || addressController.text.isEmpty || phoneController.text.isEmpty) {
//                         Fluttertoast.showToast(
//                             msg: 'Please Enter All Fields',
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.BOTTOM,
//                             backgroundColor: Colors.redAccent,
//                             textColor: Colors.white,
//                             fontSize: 16.0
//                         );
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "Order Placed Successfully",
//                             toastLength: Toast.LENGTH_LONG,
//                             gravity: ToastGravity.BOTTOM,
//                             backgroundColor: Colors.green,
//                             textColor: Colors.white,
//                             fontSize: 16.0
//                         );
//                       }
//                     },
//                     child: Text('Place Order'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paymob_pakistan/paymob_payment.dart';

class PaymentMethod extends StatelessWidget {
  final double total;
  const PaymentMethod(this.total, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentView(total: total),
    );
  }
}

class PaymentView extends StatefulWidget {
  final double total;
  const PaymentView({required this.total, Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {



  @override
  void initState() {
    super.initState();
    PaymobPakistan.instance.initialize(
      apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRRNE5Ua3dMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuUEhEbzRYb0VSa096QzBlWXNESmxwSk0xN00tTTBCd1ZIQjhZSnRNNDJkdHduU18taHZVWDRUdzVraTNIOXFZTVNFVzRHQUJ5TWljZ25sT1ZLWElhTlE=",
      jazzcashIntegrationId: 170583,
      easypaisaIntegrationID: 170583,
      integrationID: 170583,
      iFrameID: 179919,
    );
  }
  PaymobResponse? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/doctor.png', height: 400),
            const SizedBox(height: 24),
            if (response != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Success ==> ${response?.success}"),
                  const SizedBox(height: 8),
                  Text("Transaction ID ==> ${response?.transactionID}"),
                  const SizedBox(height: 8),
                  Text("Message ==> ${response?.message}"),
                  const SizedBox(height: 8),
                  Text("Response Code ==> ${response?.responseCode}"),
                  const SizedBox(height: 16),
                ],
              ),
            Column(
              children: [
                // ElevatedButton(
                //   child: const Text('Pay with Jazzcash'),
                //   onPressed: () => PaymobPakistan.instance.makePayment(
                //     context: context,
                //     currency: "PKR",
                //     amountInCents: "100",
                //     paymentType: PaymentType.jazzcash,
                //     onPayment: (response) => setState(() => this.response = response),
                //   ),
                // ),
                // ElevatedButton(
                //     child: const Text('Pay with Jazzcash'),
                //     onPressed: () async {
                //       try {
                //         PaymentInitializationResult response = await PaymobPakistan.instance.initializePayment(
                //           currency: "PKR",
                //           amountInCents: "100",
                //         );
                //
                //         String authToken = response.authToken;
                //         int orderID = response.orderID;
                //
                //         PaymobPakistan.instance.makePayment(context,
                //             currency: "PKR",
                //             amountInCents: "100",
                //             paymentType: PaymentType.jazzcash,
                //             authToken: authToken,
                //             orderID: orderID,
                //             onPayment: (response) => setState(() => this.response = response));
                //       } catch (err) {
                //         rethrow;
                //       }
                //     }),
                // ElevatedButton(
                //   child: const Text('Pay with Easypaisa'),
                //   onPressed: () => PaymobPakistan.instance.pay(
                //     context: context,
                //     currency: "PKR",
                //     amountInCents: "100",
                //     billingData: PaymobBillingData(
                //         email: "test@test.com",
                //         firstName: "Arshman",
                //         lastName: "Afzal",
                //         phoneNumber: "+921234567890",
                //         apartment: "NA",
                //         building: "NA",
                //         city: "NA",
                //         country: "Pakistan",
                //         floor: "NA",
                //         postalCode: "NA",
                //         shippingMethod: "Online",
                //         state: "NA",
                //         street: "NA"),
                //     paymentType: PaymentType.easypaisa,
                //     onPayment: (response) =>
                //         setState(() => this.response = response),
                //   ),
                // ),
                // ElevatedButton(
                //   child: const Text('Pay with Card'),
                //   onPressed: () => PaymobPakistan.instance.pay(
                //     context: context,
                //     currency: "PKR",
                //     amountInCents: "100",
                //     paymentType: PaymentType.card,
                //     onPayment: (response) =>
                //         setState(() => this.response = response),
                //   ),
                // ),
                ElevatedButton(
                  child: const Text('Pay with Card'),
                  onPressed: () => _payment(widget.total),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _payment(total) async {
    try {
      print('insie try payment');
      PaymentInitializationResult response =
      await PaymobPakistan.instance.initializePayment(
        currency: "PKR",
        amountInCents: ('1000').toString(),
      );

      String authToken = response.authToken;
      int orderID = response.orderID;

      await PaymobPakistan.instance.makePayment(context,
          currency: "PKR",
          amountInCents: ('1000').toString(),
          paymentType: PaymentType.card,
          authToken: authToken,
          orderID: orderID, onPayment: (response) async {
            // snackbar
            print('Responce Code ---------- ${response.responseCode}');
            if (response.responseCode == "APPROVED") {
              print("pass");
            } else {
              print("fail");
            }
          });
    } catch (err) {
      rethrow;
    }
  }
}
