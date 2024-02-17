import 'package:flutter/material.dart';


class ProfileImageCard extends StatelessWidget {
  const ProfileImageCard({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Image.network(
          width: double.infinity,
          height: height * 0.35,
          image,
          fit: BoxFit.cover,
        ),
      ]
      ),
    );
  }
}
