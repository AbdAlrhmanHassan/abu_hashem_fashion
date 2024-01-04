import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/list_tile.dart';
import 'widgets/log_in_out_button.dart';
import 'widgets/user_details.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserDetails(),
            //  Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            //             child: Text(
            //               "عام",
            //               style: TextStyle(
            //                 fontSize: 24,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),

            const Divider(
              height: 60,
              thickness: 1.5,
              endIndent: 7,
              indent: 7,
            ),
            CustomListTile(
                imagePath: "assets/image/important_image/order_svg.png",
                text: "جميع الطلبات",
                function: () {}),
            CustomListTile(
                imagePath: "assets/image/important_image/wishlist_svg.png",
                text: "قائمة الأماني",
                function: () {}),
            CustomListTile(
                imagePath: "assets/image/important_image/recent.png",
                text: "العناصر المشاهده حديثا",
                function: () {}),
            const Divider(
              height: 30,
              thickness: 1.5,
              endIndent: 7,
              indent: 7,
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            //   child: Text(
            //     "عام",
            //     style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            SwitchListTile(
              secondary: Image.asset(
                "assets/image/important_image/theme.png",
                height: 30,
              ),
              title: const Text(true ? "Dark mode" : "Light mode"),
              value: true,
              onChanged: (value) {
                ThemeData.dark();
              },
            ),
            const Divider(
              height: 40,
              thickness: 1.5,
              endIndent: 7,
              indent: 7,
            ),
            const Center(
              child: LogInOutButton(),
            ),
          ],
        ),
      ),
    );
  }
}


// Guest Image
//  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"

