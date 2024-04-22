import 'package:flutter/material.dart';

class QuantityCounter extends StatelessWidget {
  int counter;
  QuantityCounter({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    // getting value of quantity
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            minimumSize: MaterialStateProperty.all(Size.zero),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(255, 230, 233, 251)),
          ),
          icon: const Icon(
            Icons.remove,
            color: Color(0xff6E7E98),
          ),
          onPressed: () {
            // context.read<CartBloc>().add(RemoveIceCreamEvent(iceCream));
            if(counter > 1) {
              counter--;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            counter.toString(),
            style: const TextStyle(
              color: Color(0xff6E7E98),
              fontSize: 14,
            ),
          ),
        ),
        IconButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            minimumSize: MaterialStateProperty.all(Size.zero),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(255, 230, 233, 251)),
          ),
          icon: const Icon(
            Icons.add,
            color: Color(0xff6E7E98),
          ),
          onPressed: () {
            counter++;
          },
        ),
      ],
    );
  }
}
