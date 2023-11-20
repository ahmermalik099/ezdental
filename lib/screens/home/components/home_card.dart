import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCard extends StatelessWidget {
  String name = '';
  String image = '';
  String route;

  HomeCard({
    required this.name,
    required this.image,
    required this.route
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 16,top: 16,right: 6,bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/$route');
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.cyanAccent.shade700,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              style: BorderStyle.solid,
              width: 2,
              color: Colors.black26,
            ),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                  'assets/$image',
                  height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
