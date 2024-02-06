import 'dart:developer';

import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/admin/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/flutter_log_in_widget.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static String routName = "LogInView";

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    String? errorMsg;
    return BlocBuilder<AuthcubitCubit, AuthcubitState>(
      builder: (context, state) {
        if (state is AuthcubitLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }

        if (state is AuthcubitFailure) {
          errorMsg = state.errMsg;
        } else {
          errorMsg = null;
        }
        log("error msg :$errorMsg");
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: customAppName(),
              centerTitle: true,
            ),
            body: LoginPage(isLoading: isLoading, errorMsg: errorMsg));
      },
    );
  }
}
