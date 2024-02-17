import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:ezdental/screens/user/components/profile_image_card.dart';
import 'package:flutter/material.dart';

import '../../../services/storage.dart';

class ProfileSlider extends StatelessWidget {
  const ProfileSlider(
      {super.key, required this.isEditing, required this.images});
  final List<dynamic> images;
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyanAccent.shade700,
        ),
        height: height * 0.4,
        width: double.infinity,
        child: Swiper(
          autoplay: isEditing ? false : true,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                images.length == 0
                    ? Container()
                    : ProfileImageCard(image: images[index]),
                isEditing
                    ? Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            StorageService().selectFiles();
                          },
                          child: Text(
                            'Upload new Images',
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
          itemCount: images.length == 0 ? 1 : images.length,
          pagination: const SwiperPagination(),
          control: null,
        ),
      ),
    );
  }
}
