 
import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
 import 'package:flutter/material.dart';
 
import 'widgets/flutter_log_in_widget.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static String routName = "LogInView";

  @override
  Widget build(BuildContext context) {
     
    
    
        return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              title: customAppName(),
              centerTitle: true,
            ),
            body: const LoginPage(),);
 
  }
}
