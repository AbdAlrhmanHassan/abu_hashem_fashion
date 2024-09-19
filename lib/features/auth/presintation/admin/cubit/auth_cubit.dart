import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'auth_state.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthcubitInitial());

  User? user1 = FirebaseAuth.instance.currentUser;

  Future<void> loginUserF(
      {required String lEmail, required String lPassword}) async {
    try {
      emit(AuthcubitLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: lEmail.trim(), password: lPassword.trim());
      if (user1 != null) {
        log(user1!.email.toString());
        log(user1!.email.toString());
      }

      emit(AuthcubitSuccess());
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      emit(AuthcubitFailure(errMsg: e.message.toString()));

      if (e.code == 'user-not-found') {
        log('user-not-found');
      } else if (e.code == 'wrong-password') {
        log('wrong-password');
      } else {
        emit(AuthcubitFailure(errMsg: e.message.toString()));

        log(e.toString());
      }
    } on FirebaseException catch (e) {
      emit(AuthcubitFailure(errMsg: e.message.toString()));

    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));

      log(e.toString());
    }
  }

  Future<void> signUpUserF({
    required String lEmail,
    required String lPassword,
    required String name,
  }) async {
    try {
      emit(AuthcubitLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: lEmail.trim(), password: lPassword.trim());
      User? user = FirebaseAuth.instance.currentUser;

      user!.updateDisplayName(name);
      final String uId = user.uid;

      log(user.uid);
      await FirebaseFirestore.instance.collection("users").doc(uId).set({
        "userId": uId,
        "userName": name,
        "userEmail": lEmail,
        "createAt": Timestamp.now(),
        "userCart": []
      });
      if (user1 != null) {
        log(user1!.email.toString());
        log(user1!.email.toString());
      }

      emit(AuthcubitSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthcubitFailure(errMsg: e.code.toString()));

      if (e.code == 'user-not-found') {
        log('user-not-found');
      } else if (e.code == 'wrong-password') {
        log('wrong-password');
      } else {
        log(e.toString());
      }
    } on FirebaseException catch (e) {
      emit(AuthcubitFailure(errMsg: e.code.toString()));

      // Handle other types of FirebaseExceptions
      print("FirebaseException occurred: $e");
    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));

      log(e.toString());
    }
  }

  // Future<User?> gooleSignInF() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       final UserCredential authResult =
  //           await auth.signInWithCredential(credential);
  //       final User? user = authResult.user;

  //       return user;
  //     }
  //   } catch (error) {
  //     print(error);
  //     // Handle error
  //   }
  //   return null;
  // }

  // Future<void> goolgeSignInFF({required BuildContext context}) async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         final authResults = await FirebaseAuth.instance
  //             .signInWithCredential(GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken,
  //           idToken: googleAuth.idToken,
  //         ));
  //         WidgetsBinding.instance.addPostFrameCallback((_) async {
  //           Navigator.pushReplacementNamed(context, RootScreen.routName);
  //         });
  //       } on FirebaseException catch (error) {
  //         WidgetsBinding.instance.addPostFrameCallback((_) async {
  //           emit(AuthcubitFailure(errMsg: error.message!));
  //         });
  //       } catch (error) {
  //         emit(AuthcubitFailure(errMsg: error.toString()));
  //       }
  //     }
  //   }
  // }

  // Future<void> googleSignInF(BuildContext context) async {
  //   User? user;
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   googleSignIn.signOut();

  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //     try {
  //       emit(AuthcubitLoading());

  //       // ignore: unused_local_variable
  //       final userCredential = await auth.signInWithCredential(credential);
  //       user = userCredential.user;
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         await FirebaseFirestore.instance
  //             .collection("users")
  //             .doc(userCredential.user!.uid)
  //             .set({
  //           "userId": userCredential.user!.uid,
  //           "userName": userCredential.user!.displayName,
  //           "userEmail": userCredential.user!.email,
  //           "createAt": Timestamp.now(),
  //           "userCart": []
  //         });
  //       }
  //       emit(AuthcubitSuccess());
  //     } on FirebaseAuthException catch (e) {
  //       emit(AuthcubitFailure(errMsg: e.message.toString()));
  //     } catch (e) {
  //       emit(AuthcubitFailure(errMsg: e.toString()));
  //     }
  //   }

  //   if (!context.mounted) return;

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Navigator.pushReplacementNamed(context, RootScreen.routName);
  //   });
  // }

  Future<User?> facebookSignIn() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final LoginResult accessToken = await FacebookAuth.instance.login();
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.toString());
      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (error) {
      print(error);
      // Handle error
    }
    return null;
  }
}
