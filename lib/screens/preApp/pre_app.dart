import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../auth/login.dart';
import '../onboard/onboard.dart';


class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream, // when user changes builder will run again
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return  Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          //user is logged in
          //String email=FirebaseAuth.instance.currentUser!.email.toString();

          return OnboardingPage();
        } else { //user is null
          return LoginScreen();
        }
      },
    );
  }
}