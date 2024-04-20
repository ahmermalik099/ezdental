import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/home_card.dart';
import 'components/showcase_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 40,),
              ShowcaseSlider(),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  HomeCard(name: 'Scan', image: 'camera.svg', route: 'scan'),
                  HomeCard(name: 'Wisdom', image: 'onBoarding.svg', route: 'onBoarding'),
                  //HomeCard(name: 'News & update', image: 'newsAndUpdates.svg',route: 'newsAndUpdates'),
                  HomeCard(name: 'Products', image: 'newsAndUpdates.svg',route: 'products'),
                  HomeCard(name: 'Support', image: 'customerSupport.svg', route: 'customerSupport'), //help and FAQs


                ],
              ),
            ]
        ),
      ),
    );
  }
}
