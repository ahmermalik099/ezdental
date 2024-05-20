import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../bottomNavBar/navbar_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => NavPage()),
    );
  }

  Widget _buildFullscreenImage() {
    return SvgPicture.asset(
      'assets/gettingstarted.svg',
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(
      'assets/$assetName.svg',
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }


  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 13.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );



    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            //child: _buildImage('flutter.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome to Ez Dental!",
          body: "Welcome to our dental app, where modern technology meets oral care excellence. Discover a smarter way to manage your dental health today!",
          image: _buildImage('welcome'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "What is Ez Dental?",
          body:"Discover EZ Dental, your ultimate dental companion. Connect with nearby patients, chat, scan teeth, and book appointments seamlessly, all within our innovative app",
          image: _buildImage('what'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Why Ez Dental?",
          body:"Choose EZ Dental for a smarter approach to oral healthcare. With seamless connectivity to nearby patients, advanced teeth scanning capabilities, and effortless appointment booking, EZ Dental is your trusted partner in achieving a brighter, healthier smile.",
          image: _buildImage('why'),
          decoration: pageDecoration,
        ),
        //
        // PageViewModel(
        //   title: "Getting Started Is Easy:",
        //   body:
        //   " 1) Download Hello Neighbors and create your profile.\n 2) Connect with your neighbors and explore your local community.\n  3) Engage in conversations, share experiences, and enjoy a stronger neighborhood connection.",
        //   image: _buildImage('gettingstarted'),
        //   decoration: pageDecoration,
        // ),
        // // PageViewModel(
        // //   title: "Getting Started Is Easy:",
        // //   body:
        // //   " 1) Download Hello Neighbors and create your profile.\n 2) Connect with your neighbors and explore your local community.\n  3) Engage in conversations, share experiences, and enjoy a stronger neighborhood connection.",
        // //   image: _buildFullscreenImage(),
        // //   decoration: pageDecoration.copyWith(
        // //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
        // //     fullScreen: true,
        // //     bodyFlex: 2,
        // //     imageFlex: 3,
        // //     safeArea: 100,
        // //   ),
        // // ),
        // PageViewModel(
        //   title: "Edit Your Profile.",
        //   body: "From the last icon on the bottom navigation bar, you can add or edit your Bio, city, age, gender, Profile Picture, and Additional Images for Display to personalize your profile and connect with your neighbors.",
        //   image: _buildImage('profile'),
        //   // footer: ElevatedButton(
        //   //   onPressed: () {
        //   //     introKey.currentState?.animateScroll(0);
        //   //   },
        //   //   style: ElevatedButton.styleFrom(
        //   //     backgroundColor: Colors.lightBlue,
        //   //     shape: RoundedRectangleBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //     ),
        //   //   ),
        //   //   child: const Text(
        //   //     'FooButton',
        //   //     style: TextStyle(color: Colors.white),
        //   //   ),
        //   // ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 6,
        //     imageFlex: 6,
        //     safeArea: 80,
        //   ),
        // ),
        // PageViewModel(
        //   image: _buildImage('enjoy'),
        //   title: "Enjoy Your Neighborhood!",
        //   body: "We hope you find these profile features helpful for making meaningful connections in your neighborhood. If you have any feedback or suggestions, we'd love to hear from you. Enjoy connecting with your neighbors!",
        //   //  bodyWidget: const Row(
        //   //    mainAxisAlignment: MainAxisAlignment.center,
        //   //    // children: [
        //   //    //   // Text("Click on ", style: bodyStyle),
        //   //    //   // Icon(Icons.edit),
        //   //    //   // Text(" to edit a post", style: bodyStyle),
        //   //    // ],
        //   //  ),
        //   decoration: pageDecoration.copyWith(
        //     bodyFlex: 2,
        //     imageFlex: 4,
        //     bodyAlignment: Alignment.bottomCenter,
        //     imageAlignment: Alignment.topCenter,
        //   ),
        //
        //   reverse: true,
        // ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      // controlsPadding: kIsWeb
      //     ? const EdgeInsets.all(12.0)
      //     : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}