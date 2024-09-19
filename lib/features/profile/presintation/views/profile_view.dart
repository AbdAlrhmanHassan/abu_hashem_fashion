import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/core/widgets/show_error_or_warning_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth/presintation/views/login_view.dart';
import 'widgets/list_tile.dart';
import 'widgets/log_in_out_button.dart';
import 'widgets/user_details.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
            Visibility(visible: user != null, child: const UserDetails()),
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
              // ignore: dead_code
              title: const Text(true ? "Dark mode" : "Light mode"),
              value: false,
              onChanged: (value) {},
            ),
            const Divider(
              height: 40,
              thickness: 1.5,
              endIndent: 7,
              indent: 7,
            ),
            Center(
              child: LogInOutButton(
                function: () async {
                  showErrorORWarningDialog(
                      context: context,
                      subtitle: "تسجيل الخروج ",
                      fct: () async {
                        await FirebaseAuth.instance.signOut();

                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                              context, LogInView.routName);
                        }
                      },
                      isError: false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Guest Image
//  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"

