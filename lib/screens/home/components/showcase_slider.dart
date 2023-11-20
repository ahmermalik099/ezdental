import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:ezdental/screens/home/components/showcase_card.dart';
import 'package:flutter/material.dart';

class ShowcaseSlider extends StatelessWidget {
  const ShowcaseSlider({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20)
          ),
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
        height: height * 0.3,
        width: width * 0.95,
        child: Swiper(
    
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ShowcaseSliderCard(
              ),
            );
          },
          itemCount: 2,
          pagination: const SwiperPagination(),
          control: null,
        ),
      ),
    );
  }
}
