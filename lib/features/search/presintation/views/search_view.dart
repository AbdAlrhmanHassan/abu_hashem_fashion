import 'dart:developer';

import 'package:abu_hashem_fashion/core/data/models/product_model.dart';
import 'package:abu_hashem_fashion/features/home/presintation/admin/cubit/view_all_products_cubit.dart';
import 'package:abu_hashem_fashion/features/search/presintation/views/widgets/search_text_field.dart';
import 'package:abu_hashem_fashion/features/search/presintation/views/widgets/searchitem_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, this.categories});
  static const String routeName = 'SearchView';
  final String? categories;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController searchTextController;
  List<ProductModel> productsList = [];

  @override
  void initState() {
    searchTextController = TextEditingController();
    if (widget.categories != null && widget.categories!.isNotEmpty) {
      searchForCategory(widget.categories!);
      searchTextController.text = widget.categories!;
    }
    super.initState();
  }

  x() {
    // Automatically search based on the categores if it's not null
  }

  Future<void> searchForCategory(String category) async {
    log('Searching for category: $category');

    productsList = await BlocProvider.of<ProductsCubit>(context)
            .searchForProduct(categores: category.trim()) ??
        [];
    setState(() {});
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
                //If i remove the condition it will return all products if the search text is empty
                if (value.isNotEmpty) {
                  productsList = await BlocProvider.of<ProductsCubit>(context)
                          .searchForProduct(productTitle: value.trim()) ??
                      [];
                } else {
                  productsList = [];
                }
                log(productsList.length.toString());
                setState(() {});
              },
              clearFieldF: () {
                setState(() {
                  productsList = [];
                  searchTextController.clear();
                  FocusScope.of(context).unfocus();
                });
              }),
          const SizedBox(
            height: 20,
          ),
          if (productsList.isEmpty && searchTextController.text.isNotEmpty)
            const Text('لم يتم العثور على نتائج'),
          Expanded(
            child: ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return SearchitemCard(productModel: productsList[index]);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
