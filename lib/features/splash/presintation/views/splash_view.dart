import 'package:abu_hashem_fashion/core/consts/consts_photo.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/bottom_navigation_bar.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RootScreen.routName);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          ConstsAppImage.appMainLogoWhite,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
