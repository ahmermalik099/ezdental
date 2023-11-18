
import 'package:ezdental/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'components/navigation_bottom_bar.dart';



class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _pageList = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    //const DiscoverScreen(),
   // const CartScreen(),
    // const MessageScreen(),
    //const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: _pageList[
          0
        ]
      ),

      bottomNavigationBar: const NavigationBottomBar(),
      extendBody: true,
    );
  }
}
