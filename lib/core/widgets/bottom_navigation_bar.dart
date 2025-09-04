import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presintation/admin/cubit/cart_cubit.dart';
import '../../features/cart/presintation/views/cart_view.dart';
import '../../features/home/presintation/views/home_view.dart';
import '../../features/profile/presintation/views/profile_view.dart';
import '../../features/search/presintation/views/search_view.dart';

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
    controllerV = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controllerV,
        physics: const NeverScrollableScrollPhysics(),
        children: screenList,
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: kBottomNavigationBarHeight + 10,
        elevation: 6,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controllerV!.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home),
              label: "الرئيسية"),
          const NavigationDestination(icon: Icon(Icons.search), label: "البحث"),
          NavigationDestination(
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return StreamBuilder<int>(
                  stream: BlocProvider.of<CartCubit>(context)
                      .getAllCartItemsQuantityStream(),
                  builder: (context, snapshot) {
                    // Determine which icon to show based on snapshot data
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show the loading state icon
                      return const Icon(Icons.shopping_cart);
                    } else if (snapshot.hasData && snapshot.data! > 0) {
                      // Show the badge if there are items in the cart
                      return Badge(
                        offset: const Offset(-8, -6),
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        label: Text(
                          snapshot.data.toString(),
                        ),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.shopping_cart),
                      );
                    } else {
                      // Show the base icon when there are no items
                      return const Icon(Icons.shopping_cart);
                    }
                  },
                );
              },
            ),
            label: 'السلة',
          ),
          const NavigationDestination(
              icon: Icon(Icons.person), label: "الملف الشخصي"),
        ],
      ),
    );
  }
}
