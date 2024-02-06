import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log(user.displayName.toString());
    }
    String userImage = (user != null && user.photoURL != null)
        ? user.photoURL!
        : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: user!.photoURL != null,
          child: CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 14),
            Text(
              user != null ? user.displayName ?? " " : " ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 7),
            Text(
              user != null ? user.email ?? " " : " ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}
