import 'package:abu_hashem_fashion/features/cart/presintation/views/cart_view.dart';
import 'package:abu_hashem_fashion/features/home/presintation/views/home_view.dart';
import 'package:abu_hashem_fashion/features/profile/presintation/views/profile_view.dart';
import 'package:abu_hashem_fashion/features/search/presintation/views/search_view.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static String routName = "RootScreen";

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  PageController? controllerV;
  List<Widget> screenList = [
    const HomeView(),
    const SearchView(),
    const CartView(),
    const ProfileView(),
  ];
  int currentScreen = 0;
  @override
  void initState() {
    super.initState();
    controllerV = PageController(
      initialPage: currentScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controllerV,
        // physics: const NeverScrollableScrollPhysics(),
        children: screenList,
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentScreen,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: kBottomNavigationBarHeight + 10,
          elevation: 15,
          onDestinationSelected: (index) {
            setState(() {
              currentScreen = index;
            });
            controllerV!.jumpToPage(currentScreen);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "HomePage"),
            NavigationDestination(icon: Icon(Icons.search), label: "Search"),
            NavigationDestination(
                icon: Icon(Icons.shopping_cart_rounded), label: "cart"),
            NavigationDestination(icon: Icon(Icons.person), label: "profile"),
          ]),
    );
  }
}
