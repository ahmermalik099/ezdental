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
                  HomeCard(name: 'Scan', image: 'camera.svg', route: 'newsAndUpdates'),
                  HomeCard(name: 'Wisdom', image: 'about.svg', route: 'onBoarding'),
                  HomeCard(name: 'Teeth Care', image: 'care.svg',route: 'rating'),
                  HomeCard(name: 'Support', image: 'helpdesk.svg', route: 'customerSupport'), //help and FAQs


                ],
              ),
            ]
        ),
      ),
    );
  }
}
