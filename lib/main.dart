import 'package:abu_hashem_fashion/core/style/styles.dart';
import 'package:abu_hashem_fashion/core/widgets/bottom_navigation_bar.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/views/login_view.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/admin/cubit/cart_cubit.dart';
import 'package:abu_hashem_fashion/features/home/presintation/admin/cubit/view_all_products_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash_view/splash_view.dart';

import 'features/auth/presintation/admin/cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthcubitCubit()),
                BlocProvider(create: (context) => ViewAllProductsCubit()),
                BlocProvider(create: (context) => CartCubit()),
              ],
              child: const AbuHashemFashionApp(),
            ),
          ));
}

class AbuHashemFashionApp extends StatelessWidget {
  const AbuHashemFashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: const [
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('ar', 'AE'),
      // ],
      theme: Styles.themeData(isDarkTheme: false, context: context),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: SplashView(
          logo: customAppName(duration: const Duration(seconds: 3)),
          backgroundColor: Colors.white,
          done: Done(
            const RootScreen(),
            animationDuration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        ),
      ),
      routes: {
        // HomeView.routName: (context) => const HomeView(),
        RootScreen.routName: (context) => const RootScreen(),
        LogInView.routName: (context) => const LogInView(),
      },
    );
  }
}
