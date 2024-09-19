import 'package:abu_hashem_fashion/core/constants/screen_size.dart';
import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:abu_hashem_fashion/features/home/presintation/admin/cubit/view_all_products_cubit.dart';
import 'package:abu_hashem_fashion/features/search/presintation/views/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController searchTextController;
  List<ProductModel> productsList = [];

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(children: [
          searchTextField(
              context: context,
              searchTextController: searchTextController,
              onChangedF: (value) async {
                productsList = await BlocProvider.of<ProductsCubit>(context)
                    .searchForProduct(productTitle: value.trim());

                setState(() {});
              }),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return SearchitemCard(productModel: productsList[index]);
              },
            ),
          )
        ]),
      ),
    );
  }
}

class SearchitemCard extends StatelessWidget {
  const SearchitemCard({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productModel.productTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "JOD ",
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                            TextSpan(
                              text: productModel.productPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                  color: Colors.white,
                  width: getScreenWidth(context) * .25,
                  height: getScreenHight(context) * .15,
                  child: Image.network(
                    productModel.productImageUrl,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
