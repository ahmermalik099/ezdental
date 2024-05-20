// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezdental/screens/home/home_screen.dart';
import 'package:ezdental/screens/maps/maps_screen.dart';
import 'package:ezdental/screens/user/profile_screen.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/provider.dart';
import '../../services/fire_store.dart';
import '../chat/appointment.dart';
import '../chat/chat.dart';


class NavPage extends ConsumerWidget {
  NavPage({Key? key}) : super(key: key);



  /// Controller to handle PageView and also handles initial page
  // final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page

  int maxCount = 5;
  String userType='patient';
  bool isDoctor=false;



  final List<Widget> bottomBarPages = [
    HomeScreen(),
    ExploreScreen(),
    ChatScreen(),
    AppointmentsScreen(),
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

            const BottomBarItem(
              inActiveItem: Icon(
                Icons.timelapse,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Appointments',
            ),
          ], kIconSize: 30.0, kBottomRadius: 30.0,

      )
          : null,
    );
  }


  Future<String> fetchUserType(String getuserType) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(getuserType).get();
      if (snapshot.exists) {
        userType = snapshot.data()?['type'] ?? '';
        return userType;
      } else {
        userType = 'patient';
      }
    } catch (e) {
      // Error occurred while fetching data, handle this error
      print('Error fetching patient data: $e');
    }
    return"";
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








// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
//
// import '../../riverpod/provider.dart';
//
// class NavPage extends ConsumerWidget {
//   NavPage({Key? key}) : super(key: key);
//
//   int maxCount = 5;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final _pageController = ref.watch(pageProvider);
//     final _controller = ref.watch(navItemProver);
//
//     return FutureBuilder<List<dynamic>>(
//       future: FirestoreService().getUsers(), // Replace with your method to fetch user data
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           final userData = snapshot.data! as Map<String, dynamic>;
//           final isDoctor = userData['type'] == 'doctor';
//           final List<Widget> bottomBarPages = [
//             if (!isDoctor) HomeScreen(),
//             if (!isDoctor) ExploreScreen(), // Include ExploreScreen if not a doctor
//             ChatScreen(),
//             UserProfileScreen(),
//             AppointmentsScreen(),
//           ];
//
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: PageView(
//               controller: _pageController,
//               physics: NeverScrollableScrollPhysics(),
//               children: bottomBarPages,
//             ),
//             extendBody: true,
//             bottomNavigationBar: (bottomBarPages.length <= maxCount)
//                 ? AnimatedNotchBottomBar(
//               onTap: (index) {
//                 ref.read(navItemProver.notifier).updateIndex(index);
//                 ref.read(pageProvider.notifier).updateIndex(index);
//               },
//               notchBottomBarController: _controller,
//               color: Colors.white,
//               showLabel: false,
//               notchColor: Colors.black87,
//               removeMargins: false,
//               bottomBarWidth: 500,
//               durationInMilliSeconds: 300,
//               bottomBarItems: [
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.home_filled,
//                     color: Colors.blueAccent,
//                   ),
//                   itemLabel: 'Home',
//                 ),
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.location_on_outlined,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.location_on_outlined,
//                     color: Colors.blueAccent,
//                   ),
//                   itemLabel: 'Collection',
//                 ),
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.chat_bubble,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.chat_bubble,
//                     color: Colors.blueAccent,
//                   ),
//                   itemLabel: 'Search',
//                 ),
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.person,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.person,
//                     color: Colors.blueAccent,
//                   ),
//                   itemLabel: 'Profile',
//                 ),
//                 const BottomBarItem(
//                   inActiveItem: Icon(
//                     Icons.timelapse,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.person,
//                     color: Colors.blueAccent,
//                   ),
//                   itemLabel: 'Appointments',
//                 ),
//               ],
//               kIconSize: 30.0,
//               kBottomRadius: 30.0,
//             )
//                 : null,
//           );
//         }
//       },
//     );
//   }
// }
