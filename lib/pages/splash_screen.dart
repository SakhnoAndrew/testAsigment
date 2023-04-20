import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_application_1/constants.dart';

import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(Constants.lottieAssets),
      nextScreen: const MainPage(),
      duration: 1000,
      backgroundColor: Colors.blue,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
