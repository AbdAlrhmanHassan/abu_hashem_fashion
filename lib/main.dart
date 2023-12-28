import 'package:abu_hashem_fashion/core/widgets/bottom_navigation_bar.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/style/styles.dart';
import 'features/splash/presintation/views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const AbuHashemFashionApp()));
}

class AbuHashemFashionApp extends StatelessWidget {
  const AbuHashemFashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Styles.themeData(isDarkTheme: false, context: context),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: SplashView(),
      ),
      routes: {
        // HomeView.routName: (context) => const HomeView(),
        RootScreen.routName: (context) => const RootScreen(),
        LogInView.routName: (context) => const LogInView(),
      },
    );
  }
}
