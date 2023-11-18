
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class NavigationItem extends StatefulWidget {
  final int index;
  final String icon;

  const NavigationItem({
    required this.index,
    required this.icon,
    super.key,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 50,
      height: 50,
      child: IconButton(
        onPressed: () {
          // if (BaseController.navigationController.selectedIndex.value ==
          //     widget.index) {
          //   return;
          // }
          // HapticFeedback.selectionClick();
          // BaseController.navigationController.changeScreen(widget.index);
        },
        style: IconButton.styleFrom(
          backgroundColor:
            Colors.white10,
          // BaseController.navigationController.selectedIndex.value ==
          //     widget.index
          //     ? kWhiteColor
          //     : kLightTextPrimaryColor,
        ),
        icon: Stack(
          children: [
            SvgPicture.asset(
              widget.icon,
              colorFilter: ColorFilter.mode(
                1 ==
                    widget.index
                    ? Colors.cyanAccent.shade700
                    : Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
