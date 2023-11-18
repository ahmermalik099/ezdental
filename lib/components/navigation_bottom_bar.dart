
import 'package:flutter/material.dart';


import 'navigation_item.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(36.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigationItem(index: 0, icon: "assets/about.svg"),
          NavigationItem(index: 1, icon: "assets/profile.svg"),
          NavigationItem(index: 2, icon: "assets/about.svg"),
          NavigationItem(index: 3, icon: "assets/profile.svg"),

        ],
      ),
    );
  }
}
