import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'flutter_log_in_widget.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static String routName = "LogInView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          title: customAppName(),
          centerTitle: true,
        ),
        body: const FlutterLogInWidget());
  }
}
