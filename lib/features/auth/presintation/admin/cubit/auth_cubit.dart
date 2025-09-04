import 'dart:developer';

import 'package:abu_hashem_fashion/core/data/models/user_address_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class Authcubit extends Cubit<AuthcubitState> {
  Authcubit() : super(AuthcubitInitial());

  Future<void> loginUserF(
      {required String lEmail, required String lPassword}) async {
    try {
      User? user1 = FirebaseAuth.instance.currentUser;

      emit(AuthcubitLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: lEmail.trim(), password: lPassword.trim());
      if (user1 != null) {
        log(user1.email.toString());
        log(user1.email.toString());
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
      emit(AuthcubitFailure(errMsg: e.message.toString()));
    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));

      log(e.toString());
    }
  }

  Future<void> signUpUserF({
    required String lEmail,
    required String phone,
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
        "userEmail": lEmail,
        "userName": name,
        "userPhone": phone,
        "createAt": Timestamp.now(),
        "userCart": []
      });

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
    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));

      log(e.toString());
    }
  }

  Future<void> saveUserAddress(
      {required UserAddressModel userAddressModel}) async {
    try {
      User? user1 = FirebaseAuth.instance.currentUser;

      emit(AuthcubitLoading());
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user1!.uid)
          .collection("userAddress")
          .doc(user1.uid)
          .set(userAddressModel.toMap());
      emit(AuthcubitSuccess());
    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));
      log(e.toString());
    }
  }

  Future<UserAddressModel?> getUserAddress() async {
    try {
      emit(AuthcubitLoading());

      User? user1 = FirebaseAuth.instance.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userAddressDoc =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user1!.uid)
              .collection("userAddress")
              .doc(user1.uid)
              .get();

      if (userAddressDoc.data() == null) {
        // ignore: prefer_const_constructors
        emit(AuthcubitFailure(errMsg: "No address found"));
        return null;
      }
      UserAddressModel? userAddressModel =
          UserAddressModel.fromJson(userAddressDoc);

      emit(AuthcubitSuccess());
      return userAddressModel;
    } catch (e) {
      emit(AuthcubitFailure(errMsg: e.toString()));
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Sign out from GoogleSignIn to ensure the account selection prompt appears

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new
      bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      // Get the phone number if available
      String? phoneNumber = userCredential.user?.phoneNumber;

      if (isNewUser) {
        // Save the user data in Firestore if it's a new user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "userId": userCredential.user!.uid,
          "userEmail": userCredential.user!.email,
          "userName": userCredential.user!.displayName,
          "userPhone": phoneNumber, // Add phone number if available
          "createAt": Timestamp.now(),
          "userCart": []
        });
      } else {
        // Handle existing user logic if needed
      }

      return userCredential.user; // Return the signed-in user
    } else {
      return null; // Sign-in failed or canceled
    }
  }

  Future<bool> phoneNumberExists() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false; // User is not signed in
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (userDoc.exists && userDoc.data() != null) {
      // Check if 'userPhone' field exists and is not null
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return userData.containsKey("userPhone") && userData["userPhone"] != null;
    }

    return false; // Document doesn't exist or 'userPhone' field is missing
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({"userPhone": phoneNumber});
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

  // Future<User?> facebookSignIn() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  //   try {
  //     final LoginResult accessToken = await FacebookAuth.instance.login();
  //     final OAuthCredential credential =
  //         FacebookAuthProvider.credential(accessToken.toString());
  //     final UserCredential authResult =
  //         await auth.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     return user;
  //   } catch (error) {
  //     // Handle error
  //   }
  //   return null;
  // }
}
