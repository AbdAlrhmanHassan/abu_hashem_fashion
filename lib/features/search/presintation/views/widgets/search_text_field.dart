import 'package:flutter/material.dart';

TextField searchTextField({
  required BuildContext context,
  required TextEditingController searchTextController,
  void Function()? clearFieldF,
  required void Function(String)? onChangedF,
}) {
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
        onTap: clearFieldF,
        child: Icon(
          Icons.clear,
          color: Colors.red[300]!,
        ),
      ),
    ),
    onChanged: onChangedF,
  );
}

OutlineInputBorder buildOutLineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.blue[200]!, width: 2));
}
