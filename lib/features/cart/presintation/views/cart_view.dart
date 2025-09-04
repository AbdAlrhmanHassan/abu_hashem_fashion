import 'package:abu_hashem_fashion/core/widgets/tell_user_to_signin_dialog.dart';
import 'package:abu_hashem_fashion/features/cart/presintation/views/widgets/cart_view_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: user == null
          ? const TellUserToSigninDialog()
          : const CartViewBody(),
    );
  }
}
