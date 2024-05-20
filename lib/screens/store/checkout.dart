import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State {
  final _formKey = GlobalKey<FormState>();
  String _selectedPaymentMethod = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Select Payment Method:',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10),
                RadioListTile(
                  title: Text('Credit Card'),
                  value: 'card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Cash on Delivery'),
                  value: 'cod',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedPaymentMethod == 'card') {
                        // Implement card payment logic
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CardPaymentPage()));
                      } else if (_selectedPaymentMethod == 'cod') {
                        // Implement cash on delivery logic
                      }
                    }
                  },
                  child: Text('Proceed to Pay'),
                ),

                SizedBox(
                  height: 30,
                ),
                Text(
                  'Shipping Details',
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 10.0,
                    ),
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 10.0,
                    ),
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                      gapPadding: 10.0,
                    ),
                    icon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: (){
                        if (nameController.text.isEmpty || addressController.text.isEmpty || phoneController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Please Enter All Feilds',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Order Placed Successfully",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                      child: Text('Place Order'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


