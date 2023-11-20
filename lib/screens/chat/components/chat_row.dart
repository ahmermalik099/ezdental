import 'package:flutter/material.dart';

class ChatRow extends StatelessWidget {
  const ChatRow({super.key, required this.message, required this.name, required this.img});
  final String message, name, img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          // use state management later to remove the item from the list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Message dismissed'),
            ),
          );
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              transform: GradientRotation(1),
              colors: [
                Color(0xff19A9C1),
                Color(0xff45BDC3),
                Color(0xff19A9C1),
                Color(0xff43C7CB),
              ],
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(img),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(message),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
