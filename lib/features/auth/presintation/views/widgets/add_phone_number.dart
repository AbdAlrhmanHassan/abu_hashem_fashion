import 'package:abu_hashem_fashion/core/helper_function/validators.dart';
import 'package:abu_hashem_fashion/core/widgets/bottom_navigation_bar.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_elevated_button.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_text_field.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/admin/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPhoneNumber extends StatefulWidget {
  const AddPhoneNumber({super.key});
  static const String routeName = 'VerifiedPhoneNumber';

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: CustomTextField(
                  controller: phoneNumberController,
                  hintText: 'ادخل رقم الهاتف',
                  validator: validatePhone),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              onPressedF: () async {
                if (formKey.currentState!.validate()) {
                  await BlocProvider.of<Authcubit>(context)
                      .updatePhoneNumber(phoneNumberController.text.trim());
                }
                if (await BlocProvider.of<Authcubit>(context)
                    .phoneNumberExists()) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RootScreen.routName, (route) => false);
                }
              },
              textV: 'تأكيد',
            )
          ],
        ),
      ),
    );
  }
}
