import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 14),
            Text(
              "User Name ",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 7),
            Text(
              "UserEmail@gmail.com ",
              style:
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}
