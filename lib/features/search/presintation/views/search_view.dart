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
        child: Column(children: [
          TextField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            controller: searchTextController,
            decoration: InputDecoration(
              border: buildOutLineInputBorder(),
              enabledBorder: buildOutLineInputBorder(),
              disabledBorder: buildOutLineInputBorder(),

              hintText: "إبدأ بالبحث الآن",
              // filled: true,
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              prefixIcon: GestureDetector(
                onTap: () {
                  // setState(() {
                  searchTextController.clear();
                  FocusScope.of(context).unfocus();
                  // });
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.red[300]!,
                ),
              ),
            ),
            onChanged: (value) {},
            onSubmitted: (value) {},
          ),
        ]),
      ),
    );
  }

  OutlineInputBorder buildOutLineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.blue[200]!, width: 2));
  }
}
