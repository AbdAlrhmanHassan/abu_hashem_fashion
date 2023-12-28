import 'package:abu_hashem_fashion/core/style/font.dart';
import 'package:abu_hashem_fashion/core/widgets/custom_app_bar.dart';
import 'package:abu_hashem_fashion/features/auth/presintation/views/login_view.dart';
import 'package:flutter/material.dart';

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
            const Row(
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
            ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Text(
                "عام",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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

            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                icon: const Icon(Icons.login),
                label: const Text(
                  false ? "Login" : "Logout",
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, LogInView.routName);
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

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.function});
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: () {
          function();
        },
        trailing: Image.asset(
          imagePath,
          height: 30,
        ),
        title: Text(
          text,
          style: Styles.textStyle20
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
          textDirection: TextDirection.rtl,
        ),
        leading: const Icon(Icons.keyboard_arrow_left),
      ),
    );
  }
}
