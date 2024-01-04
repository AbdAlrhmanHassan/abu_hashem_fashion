import 'package:flutter/material.dart';

TextField searchTextField(BuildContext context,TextEditingController searchTextController) {
    return TextField(
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
        );
  }

  OutlineInputBorder buildOutLineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.blue[200]!, width: 2));
  }