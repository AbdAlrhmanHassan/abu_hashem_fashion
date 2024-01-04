import 'package:abu_hashem_fashion/features/search/presintation/views/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child:
            Column(children: [searchTextField(context, searchTextController)]),
      ),
    );
  }
}
