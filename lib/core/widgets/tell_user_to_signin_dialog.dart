import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/views/login_view.dart';
import 'package:flutter/material.dart';

class TellUserToSigninDialog extends StatelessWidget {
  const TellUserToSigninDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey[100],
        elevation: 12,
        child: SizedBox(
          height: getScreenHeight(context) * 0.3,
          width: getScreenWidth(context) * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('ليس لديك حساب؟',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[800])),
              CustomElevatedButton(
                onPressedF: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LogInView.routName,
                    (route) => false,
                  );
                },
                textV: 'تسجيل الدخول',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
