import 'dart:developer';

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

class HomeView extends StatelessWidget {
  static String routName = "/HomeView";
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    List<ProductModel> productsModelL = [];

    return BlocBuilder<ViewAllProductsCubit, ViewAllProductsState>(
      builder: (context, state) {
        if (state is ViewAllProductsSuccess) {
          productsModelL = state.productModel;
          log("ProductModel ${productsModelL.length}");
        }
        return Scaffold(
          appBar: AppBar(title: customAppName()),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: getScreenHight(context) * .22,
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
                  const Categories(),
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
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 9.8,
                    children: List.generate(
                        productsModelL.length,
                        (index) => ItemCard(
                              productModell: productsModelL[index],
                              qty: 1,
                            )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
