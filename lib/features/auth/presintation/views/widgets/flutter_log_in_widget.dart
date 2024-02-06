import 'dart:developer';

import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/widgets/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../admin/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.isLoading, this.errorMsg});
  final bool isLoading;
  final String? errorMsg;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool obscureTextV = true;
  bool isSignUp = false; // Track whether the user is signing up

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: getScreenHight(context) * .17),
              TextFormField(
                textDirection: TextDirection.ltr,
                controller: emailController,
                key: const ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintTextDirection: TextDirection.ltr,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  // Add more validation logic if needed
                  return null;
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                crossFadeState: isSignUp
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Container(),
                secondChild: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textDirection: TextDirection.ltr,
                      controller: nameController,
                      key: const ValueKey('Name'),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintTextDirection: TextDirection.ltr,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.abc),
                        hintText: "Name",
                      ),
                      validator: (String? value) {
                        if (!isSignUp) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        } else if (value.length < 3) {
                          return "Name at least 3 characters";
                        }
                        // Add more validation logic if needed
                        return null;
                      },
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                key: const ValueKey('password'),
                textDirection: TextDirection.ltr,
                obscureText: obscureTextV,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.ltr,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextV = !obscureTextV;
                      });
                    },
                    icon: obscureTextV
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: "Password",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (passwordController.value !=
                          passwordConfirmController.value &&
                      isSignUp) {
                    return 'password Not the same';
                  }
                  // Add more validation logic if needed
                  return null;
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                crossFadeState: isSignUp
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Container(),
                secondChild: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordConfirmController,
                      key: const ValueKey('password confirm'),
                      textDirection: TextDirection.ltr,
                      obscureText: obscureTextV,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintTextDirection: TextDirection.ltr,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureTextV = !obscureTextV;
                            });
                          },
                          icon: obscureTextV
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "confirm Password",
                      ),
                      validator: (String? value) {
                        if (!isSignUp) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (passwordController.value !=
                            passwordConfirmController.value) {
                          return 'password Not the same';
                        }
                        // Add more validation logic if needed
                        return null;
                      },
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  log(formKey.currentState!.validate().toString());
                  if (formKey.currentState!.validate()) {
                    if (isSignUp) {
                      await BlocProvider.of<AuthcubitCubit>(context)
                          .signUpUserF(
                              lEmail: emailController.text,
                              lPassword: passwordController.text,
                              name: nameController.text);
                    } else {
                      await BlocProvider.of<AuthcubitCubit>(context).loginUserF(
                          lEmail: emailController.text,
                          lPassword: passwordController.text);
                    }
                  }
                  if (widget.errorMsg != null) {
                    // Display toast message with error
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.red,
                      content: Text(widget.errorMsg!),
                    ));
                  }
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null && mounted) {
                    Navigator.pushReplacementNamed(
                        context, RootScreen.routName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(150, 50),
                  shadowColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                    side: BorderSide(
                        color: Colors.blue[100]!,
                        width: 4), // Set border color here
                  ),
                ),
                child: widget.isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.blue[300],
                        ),
                      )
                    : Text(
                        isSignUp ? "إنشاء حساب" : "تسجيل الدخول",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RootScreen.routName);
                            },
                            child: const Text("تخطي تسجيل الدخول")),
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
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        Text(
                          isSignUp ? "هل لديك حساب؟" : "ليس لديك حساب؟",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button for Facebook Login
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      BlocProvider.of<AuthcubitCubit>(context).facebookSignIn();
                    },
                    icon: const Icon(Icons.facebook),
                    label: const Text('تسجيل الدخول باستخدام فيسبوك'),
                  ),
                  const SizedBox(height: 10),
                  // Button for Google Sign-In
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500]),
                    onPressed: () async {
                      // await BlocProvider.of<AuthcubitCubit>(context)
                      //     .googleSignInF(context);

                      // if (user != null && mounted) {
                      //   Navigator.pushReplacementNamed(
                      //       context, RootScreen.routName);
                      // }
                    },
                    icon: const Icon(Icons.g_mobiledata_rounded),
                    label: const Text("تسجيل الدخول باستخدام جوجل"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
