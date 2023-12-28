import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/features/home/presintation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static String routName = "LogInView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: customAppName(),
        centerTitle: true,
      ),
      body: FlutterLogin(
        initialAuthMode: AuthMode.signup,
        theme: LoginTheme(
            pageColorLight: Colors.blue[200],
            primaryColor: Colors.blue[100],
            cardTheme: CardTheme(
              color: Colors.grey[50],
            )),
        onLogin: (data) {},
        onSignup: (data) {},
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
        },
        onRecoverPassword: (data) {},
        scrollable: false,
      ),
    );
  }
}
