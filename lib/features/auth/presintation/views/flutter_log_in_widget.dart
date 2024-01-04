import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import '../../../../core/widgets/bottom_navigation_bar.dart';

class FlutterLogInWidget extends StatelessWidget {
  const FlutterLogInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginProviders: [
        LoginProvider(
          callback: () {},
          button: Buttons.facebook,
          label: "Facebook",
          animated: true,
        ),
        LoginProvider(
          callback: () {},
          button: Buttons.google,
          label: "Google",
          animated: true,
        ),
      ],
      messages: LoginMessages(
          signupButton: "انشاء حساب",
          loginButton: "تسجيل الدخول",
          forgotPasswordButton: "نسيت كلمة السر",
          goBackButton: "رجوع",
          resendCodeButton: "متابعه",
          passwordHint: "كلمة السر",
          confirmPasswordHint: "تاكيد كلمة السر",
          userHint: "البريد الالكتروني",
          recoveryCodeHint: "Re",
          recoverPasswordButton: "ارسال",
          recoverPasswordDescription:
              "سوف نرسل كلمة المرور الخاصة بك بنص عادي إلى حساب البريد الإلكتروني هذا",
          recoverPasswordIntro: "أعد تعيين كلمة المرور الخاصة بك هنا"
          // signUpSuccess: "",
          ),
      theme: LoginTheme(
          pageColorLight: Colors.grey[300],
          pageColorDark: Colors.grey[200],
          primaryColor: Colors.black,
          bodyStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          cardTheme: CardTheme(
            elevation: 30,
            color: Colors.grey[100],
          ),
          accentColor: Colors.grey[200],
          buttonStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600),
          switchAuthTextColor: Colors.black,
          buttonTheme: LoginButtonTheme(
            splashColor: Colors.blue[200],
            highlightColor: Colors.blue[100],
            backgroundColor: Colors.blue[50],
          ),
          primaryColorAsInputLabel: true),
      onLogin: (data) {},
      onSignup: (data) {},
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ));
      },
      onRecoverPassword: (data) {},
    );
  }
}
