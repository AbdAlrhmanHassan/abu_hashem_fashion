import 'package:flutter/material.dart';

import '../../../../auth/presintation/views/login_view.dart';

class LogInOutButton extends StatelessWidget {
  const LogInOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
      icon: const Icon(Icons.login),
      label: const Text(
        false ? "Login" : "Logout",
      ),
      onPressed: () async {
        Navigator.pushNamed(context, LogInView.routName);
      },
    );
  }
}

