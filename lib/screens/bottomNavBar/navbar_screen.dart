import 'package:ezdental/screens/home/home_screen.dart';
import 'package:ezdental/screens/maps/maps_screen.dart';
import 'package:ezdental/screens/user/profile_screen.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/provider.dart';
import '../chat/chat.dart';


class NavPage extends ConsumerWidget {
  NavPage({Key? key}) : super(key: key);

  /// Controller to handle PageView and also handles initial page
  // final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page

  int maxCount = 4;

  final List<Widget> bottomBarPages = [
    HomeScreen(),
    ExploreScreen(),
    ChatScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _pageController = ref.watch(pageProvider);
    final _controller = ref.watch(navItemProver);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
              (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length<=maxCount) ? AnimatedNotchBottomBar(
          onTap: (index) {
            ref.read(navItemProver.notifier).updateIndex(index);
            ref.read(pageProvider.notifier).updateIndex(index);
            //  _pageController.jumpToPage(index);

          },
          notchBottomBarController: _controller,
          color: Colors.white,
          showLabel: false,
          notchColor: Colors.black87,
          removeMargins: false,
          bottomBarWidth: 500,
          durationInMilliSeconds: 300,
          bottomBarItems: [
            const BottomBarItem(
              inActiveItem: Icon(
                Icons.home_filled,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Home',
            ),

            const BottomBarItem(
              inActiveItem: Icon(
                Icons.location_on_outlined,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.location_on_outlined,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Collection',
            ),

            const BottomBarItem(
              inActiveItem: Icon(
                Icons.chat_bubble,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.chat_bubble,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Search',
            ),

            const BottomBarItem(
              inActiveItem: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Profile',
            ),
          ]

      )
          : null,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow, child: const Center(child: Text('Page 1')));
  }
}













// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
//
//   late int currentPage;
//   late TabController tabController;
//
//   final List<Color> colors = [
//     Colors.blue,
//     Colors.blue,
//     Colors.blue,
//     Colors.blue,
//     Colors.blue
//   ];
//
//   @override
//   void initState() {
//     currentPage = 0;
//     tabController = TabController(length: 5, vsync: this);
//     tabController.animation!.addListener(
//           () {
//         final value = tabController.animation!.value.round();
//         if (value != currentPage && mounted) {
//           changePage(value);
//         }
//       },
//     );
//     super.initState();
//   }
//
//   void changePage(int newPage) {
//     setState(() {
//       currentPage = newPage;
//     });
//   }
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('EZ Dental'),
//       ),
//       body: FrostedBottomBar(
//         opacity: 0.6,
//         sigmaX: 5,
//         sigmaY: 5,
//         child: TabBar(
//           indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
//           controller: tabController,
//           indicator: const UnderlineTabIndicator(
//             borderSide: BorderSide(color: Colors.blue, width: 4),
//             insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
//           ),
//           tabs: [
//             TabsIcon(
//                 icons: Icons.home,
//                 color: currentPage == 0 ? colors[0] : Colors.white),
//             TabsIcon(
//                 icons: Icons.location_on_outlined,
//                 color: currentPage == 1 ? colors[1] : Colors.white),
//             TabsIcon(
//                 icons: Icons.chat_bubble,
//                 color: currentPage == 2 ? colors[2] : Colors.white),
//             TabsIcon(
//                 icons: Icons.search_sharp,
//                 color: currentPage == 3 ? colors[3] : Colors.white),
//             TabsIcon(
//                 icons: Icons.person,
//                 color: currentPage == 4 ? colors[4] : Colors.white),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(100),
//         duration: const Duration(milliseconds: 800),
//         hideOnScroll: true,
//         body: (context, controller) => TabBarView(
//           controller: tabController,
//           dragStartBehavior: DragStartBehavior.down,
//           physics: const BouncingScrollPhysics(),
//           children: [
//             HomeScreen(),
//             ExploreScreen(),
//             ChatScreen(),
//             UserProfileScreen(),
//             UserProfileScreen(),
//           ]
//         ),
//       ),
//     );
//   }
//
// }
// class TabsIcon extends StatelessWidget {
//   final Color color;
//   final double height;
//   final double width;
//   final IconData icons;
//
//   const TabsIcon(
//       {Key? key,
//         this.color = Colors.white,
//         this.height = 60,
//         this.width = 50,
//         required this.icons})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: Center(
//         child: Icon(
//           icons,
//           color: color,
//         ),
//       ),
//     );
//   }
// }