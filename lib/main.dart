import 'package:ezdental/screens/auth/login.dart';
import 'package:ezdental/screens/auth/register.dart';
import 'package:ezdental/screens/home/home_screen.dart';
import 'package:ezdental/screens/bottomNavBar/navbar_screen.dart';
import 'package:ezdental/screens/home/sub_items/help.dart';
import 'package:ezdental/screens/home/sub_items/news_updates.dart';
import 'package:ezdental/screens/home/sub_items/rating.dart';
import 'package:ezdental/screens/home/sub_items/scan.dart';
import 'package:ezdental/screens/onboard/onboard.dart';
import 'package:ezdental/screens/preApp/pre_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
          initialRoute: '/scan', //checkscreen
          routes: {
            '/checkScreen': (context)=> CheckScreen(), //check if user is logged in or not
            '/bottomNavBar': (context) => BottomNavBar(),
            '/onBoarding': (context)=> OnboardingPage(),
            '/register': (context)=> RegisterScreen(),
            '/login': (context)=> LoginScreen(),
            '/home': (context)=> HomeScreen(),
            '/newsAndUpdates':(context) => NewsAndUpdatesScreen(),
            '/customerSupport':(context) => CustomerSupportScreen(),
            '/rating':(context) => RatingScreen(),
            '/scan':(context) => Scan(),

            // '/second': (context) => const SecondPage(),
          },
      ),
    );
  }
}

