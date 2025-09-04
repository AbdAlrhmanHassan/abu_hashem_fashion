import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/style/font.dart';
import 'package:abu_hashem_fashion/features/home/presintation/admin/cubit/view_all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/models/product_model.dart';
import '../../../../core/widgets/item_cart.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'widgets/categores.dart';
import 'widgets/swiper.dart';

class HomeView extends StatefulWidget {
  static String routName = "/HomeView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<ProductsCubit>(context).fetchProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: customAppName()),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () async {
          // Optionally refresh if needed
          return await BlocProvider.of<ProductsCubit>(context).fetchProducts();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getScreenHeight(context) * .22,
                  child: const SwiperHomePage(),
                ),
                const SizedBox(height: 16),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "الفئات",
                      style: Styles.textStyle20
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: getScreenHeight(context) * .25,
                  child: const Categories(),
                ),
                const SizedBox(height: 6),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "من أجلك",
                      style: Styles.textStyle20
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<ProductModel>>(
                  stream:
                      BlocProvider.of<ProductsCubit>(context).productsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading products'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No products available'));
                    } else {
                      List<ProductModel> productsModelL = snapshot.data!;
                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 9.8,
                        children: List.generate(
                            productsModelL.length,
                            (index) => ItemCard(
                                  productModell: productsModelL[index],
                                )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
