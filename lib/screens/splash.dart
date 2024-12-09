import 'dart:async';
import 'package:flutter/material.dart';
import '../appsize.dart';
import '../session/shared_preferences.dart';

import 'login.dart';
import 'main_homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkSession();
    super.initState();
  }

  String? isLoggedIn;
  String? username;
  String? isregister;
  // CommonViewmodel? vm;
  Future _checkSession() async {
    isLoggedIn = await Store.getLoggedIn();
    username = await Store.getFcmtoken();

    Timer(Duration(seconds: 3), () {
      if (isLoggedIn == "no" || isLoggedIn == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else if (isLoggedIn == 'yes') {
        // vm = Provider.of<CommonViewmodel>(context, listen: false);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
        // }
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = AppSizes.getSize(context);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.fill)),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 150,
          ),
        ),
      ),
    );
  }
}
