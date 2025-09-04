import 'dart:developer';

import 'package:abu_hashem_fashion/features/auth/presintation/views/widgets/add_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/screen_size.dart';
import '../../../../../core/helper_function/validators.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../admin/cubit/auth_cubit.dart';
import 'custom_auth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool obscureTextV1 = true;
  bool obscureTextV2 = true;
  bool isSignUp = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    String? errorMsg;

    return BlocBuilder<Authcubit, AuthcubitState>(
      builder: (context, state) {
        isLoading = state is AuthcubitLoading;
        errorMsg = state is AuthcubitFailure ? state.errMsg : null;
        log('error $state');
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: getScreenHeight(context) * .05),

                    // Email Input
                    CustomTextField(
                      controller: emailController,
                      hintText: "البريد الإلكتروني",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      suffixIcon: const Icon(Icons.email),
                      validator: validateEmail, // Use email validator
                    ),

                    const SizedBox(height: 20),

                    // Toggle between login and signup fields
                    if (isSignUp)
                      Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hintText: "الاسم",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            suffixIcon: const Icon(Icons.abc),
                            validator: validateName, // Use name validator
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: phoneController,
                            hintText: "الهاتف",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            suffixIcon: const Icon(Icons.phone),
                            validator: validatePhone, // Use phone validator
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),

                    // Password Input
                    CustomTextField(
                      controller: passwordController,
                      hintText: "كلمة المرور",
                      obscureText: obscureTextV1,
                      textInputAction: TextInputAction.next,
                      suffixIcon: IconButton(
                        icon: Icon(obscureTextV1
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscureTextV1 = !obscureTextV1;
                          });
                        },
                      ),
                      validator: validatePassword, // Use password validator
                    ),

                    const SizedBox(height: 20),

                    // Password Confirmation Input for Signup
                    if (isSignUp)
                      CustomTextField(
                        controller: passwordConfirmController,
                        hintText: "تأكيد كلمة المرور",
                        obscureText: obscureTextV2,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(obscureTextV2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              obscureTextV2 = !obscureTextV2;
                            });
                          },
                        ),
                        validator: (value) => validatePasswordConfirmation(
                            passwordController.text,
                            value), // Use password confirmation validator
                      ),

                    const SizedBox(height: 30),

                    // Submit Button
                    CustomElevatedButton(
                      onPressedF: () async {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                        if (formKey.currentState!.validate()) {
                          if (isSignUp) {
                            // if (selectedGovernorate == null) {
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(const SnackBar(
                            //     duration: Duration(seconds: 5),
                            //     backgroundColor: Colors.red,
                            //     content: Text('الرجاء أختيار المحافظة'),
                            //   ));
                            // }
                            await BlocProvider.of<Authcubit>(context)
                                .signUpUserF(
                                    lEmail: emailController.text,
                                    phone: phoneController.text,
                                    lPassword: passwordController.text,
                                    name: nameController.text);
                          } else {
                            await BlocProvider.of<Authcubit>(context)
                                .loginUserF(
                                    lEmail: emailController.text,
                                    lPassword: passwordController.text);
                          }
                        }
                        if (errorMsg != null) {
                          // Display toast message with error

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 5),
                            backgroundColor: Colors.red,
                            content: Text(errorMsg!),
                          ));
                        }
                        User? user = FirebaseAuth.instance.currentUser;
                        if (context.mounted) {
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 4),
                              backgroundColor: Colors.green,
                              content: isSignUp
                                  ? const Text("تم التسجيل بنجاح")
                                  : const Text("تم تسجيل الدخول بنجاح"),
                            ));
                            Navigator.pushReplacementNamed(
                                context, RootScreen.routName);
                          }
                        }
                      },
                      childV: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              isSignUp ? "إنشاء حساب" : "تسجيل الدخول",
                              style: const TextStyle(
                                // color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                    ),

                    const SizedBox(height: 10),

                    // Toggle between Signup/Login
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, RootScreen.routName);
                                  },
                                  child: Text("تخطي تسجيل الدخول",
                                      style:
                                          TextStyle(color: Colors.blue[400]!))),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSignUp =
                                        !isSignUp; // Toggle between login and signup
                                  });
                                },
                                child: Text(
                                  isSignUp ? "تسجيل الدخول" : "قم بالتسجيل",
                                  style: TextStyle(color: Colors.blue[400]!),
                                ),
                              ),
                              Text(
                                isSignUp ? "هل لديك حساب؟" : "ليس لديك حساب؟",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Row(children: [
                          Expanded(
                              child: Divider(
                            endIndent: 12,
                          )),
                          Text(
                            'أو',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              child: Divider(
                            indent: 12,
                          ))
                        ]),
                        const SizedBox(height: 16),
                        CustomAuthButton(
                          onPressedF: () async {
                            await BlocProvider.of<Authcubit>(context)
                                .signInWithGoogle();
                            if (await BlocProvider.of<Authcubit>(context)
                                .phoneNumberExists()) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RootScreen.routName, (route) => false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 4),
                                backgroundColor: Colors.green,
                                content: Text("تم تسجيل الدخول بنجاح"),
                              ));
                            } else {
                              Navigator.pushNamed(
                                  context, AddPhoneNumber.routeName);
                            }

                            // if (user != null && mounted) {
                            //   Navigator.pushReplacementNamed(
                            //       context, RootScreen.routName);
                            // }
                          },
                          text: 'تسجيل بواسطة جوجل',
                          leadingIcon:
                              SvgPicture.asset(Assets.assetsImageGoogle),
                        ),
                        // Button for Facebook Login
                        // ElevatedButton.icon(
                        //   style:
                        //       ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        //   onPressed: () {
                        //     BlocProvider.of<AuthcubitCubit>(context).facebookSignIn();
                        //   },
                        //   icon: const Icon(Icons.facebook),
                        //   label: const Text('تسجيل الدخول باستخدام فيسبوك'),
                        // ),
                        // const SizedBox(height: 10),
                        // // Button for Google Sign-In
                        // ElevatedButton.icon(
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.red[500]),
                        //   onPressed: () async {
                        //     // await BlocProvider.of<AuthcubitCubit>(context)
                        //     //     .googleSignInF(context);

                        //     // if (user != null && mounted) {
                        //     //   Navigator.pushReplacementNamed(
                        //     //       context, RootScreen.routName);
                        //     // }
                        //   },
                        //   icon: const Icon(Icons.g_mobiledata_rounded),
                        //   label: const Text("تسجيل الدخول باستخدام جوجل"),
                        // )
                      ],
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
