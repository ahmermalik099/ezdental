import 'package:flutter/material.dart';

class BookingMessage extends StatelessWidget {
  const BookingMessage({Key? key, required this.bookingMessage}) : super(key: key);

  final bookingMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text('$bookingMessage'),
    );
  }
}
