

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageProvider = StateNotifierProvider<PageItem, PageController>((ref) { //counter is the value/state, String is the type of the state
  return PageItem();
});



class PageItem extends StateNotifier<PageController> {
  PageItem() : super(PageController(initialPage: 0));
  void updateIndex(int i){
    state.jumpToPage(i);

  }

}


final navItemProver = StateNotifierProvider<navItem, NotchBottomBarController>((ref) { //counter is the value/state, String is the type of the state
  return navItem();
});



class navItem extends StateNotifier<NotchBottomBarController> {
  navItem() : super(NotchBottomBarController(index: 0));

  void updateIndex(int i){
    state.jumpTo(i);

  }

}