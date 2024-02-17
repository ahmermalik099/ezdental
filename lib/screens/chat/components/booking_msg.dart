import 'package:flutter/material.dart';

class BookingMessage extends StatelessWidget {
  const BookingMessage({Key? key, required this.bookingMessage}) : super(key: key);

  final bookingMessage;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(top: 8, left: 38, right: 38, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Your Booking Is Confirmed'),
            const SizedBox(height: 8),
            Text('$bookingMessage'),
            const SizedBox(height: 8),
          ],
        ),
      ),

    );
  }
}
