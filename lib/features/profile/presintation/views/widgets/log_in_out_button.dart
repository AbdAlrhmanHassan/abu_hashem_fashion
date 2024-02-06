import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../auth/presintation/views/login_view.dart';

class LogInOutButton extends StatelessWidget {
  LogInOutButton({
    required this.function,
    super.key,
  });
  final Function()? function;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: user == null ? Colors.green[700] : Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
      icon: const Icon(Icons.login),
      label: Text(
        user == null ? "تسجيل الدخول" : "تسجيل خروج",
      ),
      onPressed: user != null
          ? function
          : () {
              Navigator.pushReplacementNamed(context, LogInView.routName);
            },
    );
  }
}
